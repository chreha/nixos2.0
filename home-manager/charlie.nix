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
      nil
      nixfmt-rfc-style
      codeium
    ];
  };
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
      package = pkgs.vscode; # "pure" nix way everything will be managed through the nix store
      #package = pkgs.vscode.fhs; # trial, emulates a traditional linux distro may be a better dev experience when dealing with dotnet
      # Allow extensions to write to ~/.vscode/extensions
      mutableExtensionsDir = true;

      profiles.default = {
        extensions =
          (with pkgs.vscode-extensions; [
            ms-dotnettools.vscode-dotnet-runtime
            ms-dotnettools.csharp
            ms-dotnettools.csdevkit
            # theme
            dracula-theme.theme-dracula
          ])
          ++ (with pkgs.vscode-marketplace; [
            # --- Marketplace-only Extensions (from overlay) ---
            ms-azuretools.vscode-azurefunctions
            ms-azuretools.vscode-azureresourcegroups
            codeium.codeium

            ms-azuretools.vscode-containers
            ms-azuretools.vscode-docker

            ms-vscode-remote.remote-containers
            # Git
            github.codespaces
            eamodio.gitlens

            # GraphQL devtools
            graphql.vscode-graphql
            graphql.vscode-graphql-syntax

            # nix devtools
            bbenoist.nix
            jnoortheen.nix-ide

            # svelte devtools
            svelte.svelte-vscode

            # general extensions
            ms-vsliveshare.vsliveshare
            esbenp.prettier-vscode
            yoavbls.pretty-ts-errors
            bradlc.vscode-tailwindcss

          ]);
        userSettings = {
          "editor.fontSize" = 18;
          "editor.formatOnSave" = true;
          "terminal.integrated.defaultProfile.linux" = "fish"; # Set Fish as default terminal
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "nil"; # or "nixd" if you have that installed
          "nix.formatterPath" = "nixfmt";
          "codeium.linux.languageServerPath" = "${pkgs.codeium}/bin/codeium_language_server";
        };
      };
    };
    firefox = {
      enable = true;
      profiles.charlie = {
        search.default = "ddg";
        settings = {
          "browser.startup.homepage" = "https://nixos.org";
        };
      };
    };

  };
}
