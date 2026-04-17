{ pkgs, ... }:
{
  imports = [
    ./accounts

    # feature sets
    ../../features/communication
    ../../features/developer
  ];
  home = {
    username = "charlie";
    homeDirectory = "/home/charlie";
    stateVersion = "25.05";
    # create a new feature in the so-you-want-to directory for larger package configurations
    packages = with pkgs; [
      cbonsai
      dracula-theme
      nixfmt-rfc-style
      gopass

    ];
  };
  programs.ssh = {
    enable = true;

    matchBlocks = {
      # When Charlie talks to GitHub, use the agenix-decrypted keys
      "github.com" = {
        hostname = "github.com";
        # try personal then try work
        identityFile = [
          "/run/agenix/github-personal"
          "/run/agenix/github-work"
        ];
      };

      # ssh commands for the Toad, Frog, and Zima
      "the-frog" = {
        hostname = "the-frog"; # Replace with actual IP or tailscale address
        user = "charlie";
      };

      "the-zima" = {
        hostname = "the-zima"; # Replace with actual IP
        user = "charlie";
      };
      "the-toad" = {
        hostname = "the-toad"; # Replace with actual IP
        user = "charlie";
      };
    };
  };

  programs = {
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
  };
}
