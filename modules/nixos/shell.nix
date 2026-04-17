{ pkgs, config, ... }:
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

      # Dynamic Rebuilds
      rebuild-system = "sudo nixos-rebuild switch --flake $HOME/dotfiles#$(hostname)";
      rebuild-user = "home-manager switch --flake $HOME/dotfiles#$(whoami)@$(hostname) -b backup-$(date +%Y%m%d-%H%M)";
      remove-garbage = "nix-deep-clean";
    };
    interactiveShellInit = ''
      direnv hook fish | source

      function nix-deep-clean
        echo "🧹 Starting deep Nix cleanup (keeping last 3 generations)..."
        nix-env --delete-generations +3
        nix-collect-garbage -d
        sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +3
        sudo nix-collect-garbage -d
        sudo nix-store --optimise
        echo "✅ Cleanup complete! Current /nix size:"
        du -sh /nix
      end
    '';
  };

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  programs.ssh = {
    startAgent = true;
    # This automatically uses the decrypted agenix key for 'the-toad'
    extraConfig = ''
      Host the-toad
        Hostname the-toad
        User charlie

      Host the-frog
        Hostname the-frog
        User charlie

      Host the-zima
        Hostname the-zima
        User charlie
    '';
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "yes";
      PasswordAuthentication = true; # Keys only
    };
  };
}
