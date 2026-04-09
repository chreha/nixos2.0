{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      nodejs_20
      bun
      dotnet-sdk
      dotnet-repl
      dotnet-runtime
      postman
      nil
      codeium
      google-chrome
    ];
  };
  programs.vscode = {
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

        # formatters
        "[nix]" = {
          "enableLanguageServer" = true;
          "serverPath" = "nil";
          "formatterPath" = "nixfmt";
        };
        "[svelte]" = {
          "editor.defaultFormatter" = "svelte.svelte-vscode";
        };
        "[javascript]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[typescript]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[css]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[html]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[json]" = {
          "editor.defaultFormatter" = "vscode.json-language-features";
        };
        "[tailwindCSS]" = {
          "emmetCompletions" = true;
          "tailwindCSS.includeLanguages" = {
            "svelte" = "html";
          };
        };

        "codeium.linux.languageServerPath" = "${pkgs.codeium}/bin/codeium_language_server";
        "codeium.enableConfig" = {
          "*" = true;
          "nix" = true;
        };
        "svelte.enable-ts-plugin" = true;
      };
    };
  };
}
