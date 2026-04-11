{ pkgs, config, ... }:
{
  # Set Fish as the default shell for all users
  users.defaultUserShell = pkgs.fish;

  age.secrets.ssh-to-the-toad = {
    file = ../../secrets/ssh-to-the-toad.age;
    owner = "charlie"; # Ensure this matches your login username
  };

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
        IdentityFile ${config.age.secrets.ssh-to-the-toad.path}
    '';
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false; # Keys only
    };
  };
}

# { pkgs, ... }:
# {
#   # Set Fish as the default shell for all users
#   users.defaultUserShell = pkgs.fish;

#   programs.fish = {
#     enable = true;
#     shellAliases = {
#       # Reverse Proxy / Tunneling
#       allowBrian = "ssh ssh_reverse_proxy@100.76.100.18 -R 2222:localhost:22 -T -N";
#       use-frankfurt-tunnel = "sudo tailscale set --exit-node=100.91.146.28";
#       use-richmond-tunnel = "sudo tailscale set --exit-node=";

#       # SSH Key Management
#       use-personal-ssh = "ssh-add -D && ssh-add ~/.ssh/id_ed25519.personal";
#       use-work-ssh = "ssh-add -D && ssh-add ~/.ssh/id_ed25519";

#       # Dynamic Rebuilds (Works on any host)
#       rebuild-system = "sudo nixos-rebuild switch --flake $HOME/dotfiles#$(hostname)";
#       rebuild-user = "home-manager switch --flake $HOME/dotfiles#$(whoami)@$(hostname) -b backup-$(date +%Y%m%d-%H%M)";
#       remove-garbage = "nix-clean-deep";
#     };
#     interactiveShellInit = ''
#       direnv hook fish | source

#       function nix-clean-deep
#         echo "🧹 Starting deep Nix cleanup (keeping last 3 generations)..."

#         # 1. Clear User / Home Manager generations (keep last 3)
#         echo "-> Cleaning User generations..."
#         nix-env --delete-generations +3
#         nix-collect-garbage -d

#         # 2. Clear System generations (keep last 3)
#         echo "-> Cleaning System generations (requires sudo)..."
#         sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +3
#         sudo nix-collect-garbage -d

#         # 3. Deduplicate the store (hard-link identical files)
#         echo "-> Optimizing Nix store (this may take a moment)..."
#         sudo nix-store --optimise

#         echo "✅ Cleanup complete! Current /nix size:"
#         du -sh /nix
#       end
#     '';
#   };

#   programs.direnv.enable = true;
#   programs.direnv.nix-direnv.enable = true;

#   # SSH Agent and Server settings
#   programs.ssh.startAgent = true;

#   services.openssh = {
#     enable = true;
#     settings = {
#       PermitRootLogin = "no";
#       PasswordAuthentication = false; # Opinionated: Keys only
#     };
#   };
# }
