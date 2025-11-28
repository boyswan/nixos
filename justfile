NIXADDR := "192.168.99.128"
NIXPORT := "22"
NIXUSER := "jack"
NIXNAME := "jack_vm"
SSH_OPTIONS := "-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"

# Stage 1: Partition, format, and install minimal NixOS
vm-bootstrap0:
	ssh {{SSH_OPTIONS}} -p{{NIXPORT}} root@{{NIXADDR}} " \
		umount -R /mnt || true; \
		parted /dev/nvme0n1 -- mklabel gpt; \
		parted /dev/nvme0n1 -- mkpart primary 512MB -8GB; \
		parted /dev/nvme0n1 -- mkpart primary linux-swap -8GB 100\%; \
		parted /dev/nvme0n1 -- mkpart ESP fat32 1MB 512MB; \
		parted /dev/nvme0n1 -- set 3 esp on; \
		sleep 1; \
		mkfs.ext4 -L nixos /dev/nvme0n1p1; \
		mkswap -L swap /dev/nvme0n1p2; \
		mkfs.fat -F 32 -n boot /dev/nvme0n1p3; \
		sleep 1; \
		mount /dev/disk/by-label/nixos /mnt; \
		mkdir -p /mnt/boot; \
		mount /dev/disk/by-label/boot /mnt/boot; \
		nixos-generate-config --root /mnt; \
		sed --in-place '/system\.stateVersion = .*/a \
			nix.package = pkgs.nixVersions.latest;\n \
			nix.extraOptions = \"experimental-features = nix-command flakes\";\n \
			services.openssh.enable = true;\n \
			services.openssh.settings.PasswordAuthentication = true;\n \
			services.openssh.settings.PermitRootLogin = \"yes\";\n \
			users.users.root.initialPassword = \"root\";\n \
		' /mnt/etc/nixos/configuration.nix; \
		echo 'nameserver 8.8.8.8' > /etc/resolv.conf; \
		nixos-install --no-root-passwd && reboot; \
	"

# Fetch hardware config from VM
vm-fetch-hardware-config:
	scp {{SSH_OPTIONS}} -P{{NIXPORT}} root@{{NIXADDR}}:/etc/nixos/hardware-configuration.nix ./config/aarch64-hardware-configuration.nix

# Stage 2: Copy config and switch to flake
vm-bootstrap: vm-fetch-hardware-config vm-copy vm-switch
	ssh {{SSH_OPTIONS}} -p{{NIXPORT}} {{NIXUSER}}@{{NIXADDR}} "sudo reboot"

vm-ssh-key:
	cat ~/.ssh/id_ed25519.pub | ssh {{SSH_OPTIONS}} -p{{NIXPORT}} root@{{NIXADDR}} " \
		mkdir -p ~/.ssh; \
		cat >> ~/.ssh/authorized_keys; \
		chmod 700 ~/.ssh; \
		chmod 600 ~/.ssh/authorized_keys; \
	"

# Copy nix config to VM
vm-copy:
	rsync -av -e "ssh {{SSH_OPTIONS}} -p{{NIXPORT}}" \
		--exclude='.git/' \
		./ root@{{NIXADDR}}:/nix-config

# Switch to flake config
vm-switch:
	ssh {{SSH_OPTIONS}} -p{{NIXPORT}} root@{{NIXADDR}} " \
		echo 'nameserver 8.8.8.8' > /etc/resolv.conf; \
		nixos-rebuild switch --flake /nix-config#{{NIXNAME}}; \
	"

# Copy SSH keys and GPG to VM
vm-secrets:
	rsync -av -e "ssh {{SSH_OPTIONS}} -p{{NIXPORT}}" \
		--exclude='environment' \
		~/.ssh/ {{NIXUSER}}@{{NIXADDR}}:~/.ssh
	rsync -av -e "ssh {{SSH_OPTIONS}} -p{{NIXPORT}}" \
		--exclude='.#*' \
		--exclude='S.*' \
		--exclude='*.conf' \
		~/.gnupg/ {{NIXUSER}}@{{NIXADDR}}:~/.gnupg

# Rebuild VM (copy config and run nixos-rebuild)
vm-rebuild:
	rsync -av -e "ssh {{SSH_OPTIONS}} -p{{NIXPORT}}" \
		--exclude='.git/' \
		./ {{NIXUSER}}@{{NIXADDR}}:/nix-config
	ssh {{SSH_OPTIONS}} -p{{NIXPORT}} {{NIXUSER}}@{{NIXADDR}} "sudo nixos-rebuild switch --flake /nix-config/#{{NIXNAME}}"
