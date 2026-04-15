{ ... }:
{
  imports = [
    # users
    ../../users/charlie
    ../../users/guest

    # core + gui desktop
    ../../common/core.nix
    ../../common/desktop.nix
  ];

}
