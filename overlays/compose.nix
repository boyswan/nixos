(final: prev: {
    docker-compose = prev.buildGo121Module rec {
      pname = "docker-compose";
      version = "2.22.0";

      src = prev.fetchFromGitHub {
        owner = "docker";
        repo = "compose";
        rev = "v${version}";
        hash = "sha256-4ewRvPnclh6LlQ+tVWVbG3zQvUtm38LxcklLTZNKxHs=";
      };

      postPatch = ''
        # entirely separate package that breaks the build
        rm -rf e2e/
      '';

      vendorHash = "sha256-XDMU6vHCFgefN6v8KmyeAvzmX672ICQdG9qU7195ArE=";

      ldflags = [ "-X github.com/docker/compose/v2/internal.Version=${version}" "-s" "-w" ];

      doCheck = false;
      installPhase = ''
        runHook preInstall
        install -D $GOPATH/bin/cmd $out/libexec/docker/cli-plugins/docker-compose

        mkdir -p $out/bin
        ln -s $out/libexec/docker/cli-plugins/docker-compose $out/bin/docker-compose
        runHook postInstall
      '';

      meta = with prev.lib; {
        description = "Docker CLI plugin to define and run multi-container applications with Docker";
        homepage = "https://github.com/docker/compose";
        license = licenses.asl20;
        maintainers = with maintainers; [ babariviere ];
      };
    };
  })
