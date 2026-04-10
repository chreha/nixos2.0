{ pkgs, ... }:
{
  # Set Fish as the default shell for all users
  users.defaultUserShell = pkgs.fish;

  programs.fish = {
    enable = true;
    shellAliases = {
      # Reverse Proxy / Tunneling
      allowBrian = "ssh ssh_reverse_proxy@100.76.100.18 -R 2222:localhost:22 -T -N";
      use-frankfurt-tunnel = "sudo tailscale set --exit-node=100.91.146.28";
      use-richmond-tunnel = "sudo tailscale set --exit-node=";

      # SSH Key Management
      use-personal-ssh = "ssh-add -D && ssh-add ~/.ssh/id_ed25519.personal";
      use-work-ssh = "ssh-add -D && ssh-add ~/.ssh/id_ed25519";

      # Dynamic Rebuilds (Works on any host)
      rebuild-system = "sudo nixos-rebuild switch --flake $HOME/dotfiles#$(hostname)";
      rebuild-user = "home-manager switch --flake $HOME/dotfiles#$(whoami)@$(hostname) -b backup-$(date +%Y%m%d-%H%M)";
    };
    interactiveShellInit = ''
      direnv hook fish | source
    '';
  };

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  # SSH Agent and Server settings
  programs.ssh.startAgent = true;

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false; # Opinionated: Keys only
    };
  };
}
