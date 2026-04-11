let
  charlie_the_toad = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH6qAH9JiDDDWzt9HZJ1s0VqUy0j8mme3A0NwH7kfhFc";
  charlie_the_frog = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAdfqOg31FOaLYFtR00JalRK/j7HRcHAYkXR3t3tnKcF";
  host_the_toad = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJfXOo/Au0+4KbqgAGntELPtiI6CPgirwB5qJo7RU4aZ";
  host_the_frog = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKUgFgT982NrCWiL9Rg8vd9Bes6GpqJpPuLnyHy2z4yM";

  all_hosts = [
    charlie_the_toad
    charlie_the_frog
    host_the_toad
    host_the_frog
  ];
in
{
  "nas-credentials.age".publicKeys = all_hosts;
  "frog_to_toad_key.age".publicKeys = all_hosts;
}
