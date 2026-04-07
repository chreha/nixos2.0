{ inputs, pkgs, ... }:
{
  imports = [
    ./common # Pulls in the overlays and basic apps
  ];

  home = {
    username = "charlie";
    homeDirectory = "/home/charlie";
    stateVersion = "25.05";

    # Charlie-specific apps
    packages = with pkgs; [
      # i like bonsai's
      cbonsai

      # dev related packages
      nodejs_20
      bun
      dotnet-sdk
      dotnet-repl
      dotnet-runtime
      postman

      # general system applications
      google-chrome
      slack
      discord
    ];
    programs = {
      home-manager = {
        enable = true;
      };
      git = {
        enable = true;
        settings = {
          user = {
            email = "charles.hreha@gmail.com";
            name = "Charlie Hreha";
          };
          pull = {
            rebase = false;
          };
          push = {
            autoSetupRemote = true;
          };
          init = {
            defaultBranch = "main";
          };
        };
      };
      fish = {
        enable = true;
        shellAliases = with pkgs; {
          allowBrian = "ssh ssh_reverse_proxy@100.76.100.18 -R 2222:localhost:22 -T -N";
          use-frankfurt-tunnel = "sudo tailscale set --exit-node=100.91.146.28";
          use-richmond-tunnel = "sudo tailscale set --exit-node=";
          system-rebuild = "sudo nixos-rebuild switch --show-trace --flake /home/charlie/dotfiles";
        };
      };
      vscode = {
        enable = true;
        #package = pkgs.vscode; # "pure" nix way everything will be managed through the nix store
        package = pkgs.vscode.fhs; # trial, emulates a traditional linux distro may be a better dev experience when dealing with dotnet
        extensions = with pkgs.vscode-extensions; [
          # dotnet azure devtools
          ms-dotnettools.vscode-dotnet-runtime
          ms-azuretools.vscode-azurefunctions
          ms-azuretools.vscode-azureresourcegroups
          ms-dotnettools.csharp
          ms-dotnettools.csdevkit
          ms-azuretools.vscode-containers
          ms-vscode-remote.remote-containers
          ms-azuretools.vscode-docker

          # Git
          github.codespaces
          eamodio.gitlens

          # GraphQL devtools
          graphql.vscode-graphql
          graphql.vscode-graphql-syntax

          # nix devtools
          bbenoist.nix
          jnoortheen.nix-ide

          #svelte devtools
          svelte.svelte-vscode

          # ai
          codeium.codeium

          # general extensions
          ms-vsliveshare.vsliveshare
          esbenp.prettier-vscode
          yoavbls.pretty-ts-errors
          bradlc.vscode-tailwindcss

          # theme
          dracula-theme.theme-dracula
        ];
        userSettings = {
          "editor.fontSize" = 18;
          "editor.formatOnSave" = true;
          "terminal.integrated.defaultProfile.linux" = "fish"; # Set Fish as default terminal
        };
      };
      firefox = {
        enable = true;
        profiles.charlie = {
          search.default = "DuckDuckGo";
          settings = {
            "browser.startup.homepage" = "https://nixos.org";
          };
        };
      };

    };
  };
}
