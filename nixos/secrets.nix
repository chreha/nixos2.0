let
  # The unique public host key for each machine
  the-toad = "ssh-ed25519 AAAAC3Nza...";
  the-frog = "ssh-ed25519 AAAAC3Nza...";

  # Your own public key (so you can edit the secret later)
  my-laptop = "ssh-ed25519 AAAAC3Nza...";

  all-systems = [
    the-toad
    the-frog
    my-laptop
  ];
in
{
  "master_ssh_key.age".publicKeys = all-systems;
}
