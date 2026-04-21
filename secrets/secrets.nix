# --- PUBLIC KEYS ---
# 1. Get these from /etc/ssh/ssh_host_ed25519_key.pub on each machine
# 2. Charlie's key is the public key from his personal device
let
  host-the-toad = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJfXOo/Au0+4KbqgAGntELPtiI6CPgirwB5qJo7RU4aZ root@the-toad";
  host-the-frog = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKUgFgT982NrCWiL9Rg8vd9Bes6GpqJpPuLnyHy2z4yM root@the-frog";
  host-the-zima = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINuVpmdcgKA8xx2Suvy8B6z7JrUu6/aWFeNd0myvGMBn root@the-zima";
  charlie = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC7uluRYzR8q758nMYwSJKriYPsfGziXIdLSDj/HSCrA charlie";

  # the-toad-github-personal = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFJkH8jsaaU4V0/+KETE1oTzgilMFq9Ka494e+xdZYAP github-personal@the-toad";
  # the-toad-github-work = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMu7qVwfdNcng9U2If/Dm2l5FNYdwOA55XbxwI0zEFz2 github-work@the-toad";
  # the-frog-github-personal = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILyWgDz2yH+tyu6Z7e+/kVtbY4iW8aNJte6y8wwlaUjR github-personal@the-frog";
  # the-frog-github-work = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICP3k/sJAHtpPm6X0WK1XvxOTi8q+V/pDwWfSzbAnxyS github-work@the-frog";
  # the-zima-github-personal = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB2ssoOZXTvcF355EWkYK0I3NLfPUU0F+ciLPKb3So0V github-personal@the-zima";
  # the-zima-github-work = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID2i8265PSGn4zpDRztZXGIYE2tD8OBJFiUAJj1bxO/R github-work@the-zima";

  # The "Manager" group (who can edit/read everything)
  manager = [
    charlie
    host-the-toad
  ];
in
{
  # --- GLOBAL SECRETS ---
  "the-pond-samba-credentials.age".publicKeys = manager ++ [
    host-the-frog
    host-the-zima
  ];
  "vaultwarden-credentials.age".publicKeys = manager ++ [
    host-the-frog
    host-the-zima
  ];

  # --- THE TOAD SECRETS ---
  "the-toad-github-personal.age".publicKeys = manager;
  "the-toad-github-work.age".publicKeys = manager;

  # --- THE FROG SECRETS ---
  "the-frog-github-personal.age".publicKeys = manager ++ [ host-the-frog ];
  "the-frog-github-work.age".publicKeys = manager ++ [ host-the-frog ];

  # --- THE ZIMA SECRETS ---
  "the-zima-github-personal.age".publicKeys = manager ++ [ host-the-zima ];
  "the-zima-github-work.age".publicKeys = manager ++ [ host-the-zima ];
}
