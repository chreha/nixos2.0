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
    enableDefaultConfig = false;
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
      };

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
      includes = [
        {
          condition = "gitdir:~/Documents/Work-Github/";
          contents = {
            core.sshCommand = "ssh -i /run/agenix/github-work -o IdentitiesOnly=yes";
            user.email = "charles@wearetripwire.com";
          };
        }
        {
          condition = "gitdir:~/Documents/Personal-Github/";
          contents = {
            core.sshCommand = "ssh -i /run/agenix/github-personal -o IdentitiesOnly=yes";
            user.email = "charles.hreha@gmail.com";
          };
        }
      ];
    };

  };
}
