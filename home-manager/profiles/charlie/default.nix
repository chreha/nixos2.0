{ pkgs, ... }:
{
  imports = [
    # common settings
    (inputs.self + /home-manager/common)
    # this user profile's accounts
    ./accounts
    # pull in the feature sets used on this user
    (inputs.self + /home-manager/so-you-want-to/be-a-developer)
    (inputs.self + /home-manager/so-you-want-to/be-a-communicator)
  ];

  # setup the home directory and user specific packages
  home = {
    username = "charlie";
    homeDirectory = "/home/charlie";
    stateVersion = "25.05";
    # create a new feature in the so-you-want-to directory for larger package configurations
    packages = with pkgs; [
      cbonsai
    ];
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
