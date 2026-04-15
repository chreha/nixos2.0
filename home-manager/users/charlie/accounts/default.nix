{ ... }:
{
  # pull in the feature sets used on this user
  imports = [
    ./email.nix
    ./calendar.nix
  ];
}
