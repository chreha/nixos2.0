let
  charlie_the_toad = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAZTtndZISLL/CWmMauXvGvRDUXrRiwpMkmPuK5WzpV/";
  charlie_the_frog = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAdfqOg31FOaLYFtR00JalRK/j7HRcHAYkXR3t3tnKcF";
  charlie_the_zima = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKzceb1zrugZVJqtKd5u6rCVWB5KfJCa6+2DgiqvVUX5";
  host_the_toad = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJfXOo/Au0+4KbqgAGntELPtiI6CPgirwB5qJo7RU4aZ";
  host_the_frog = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKUgFgT982NrCWiL9Rg8vd9Bes6GpqJpPuLnyHy2z4yM";
  host_the_zima = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINuVpmdcgKA8xx2Suvy8B6z7JrUu6/aWFeNd0myvGMBn";

  all_hosts = [
    charlie_the_toad
    charlie_the_frog
    charlie_the_zima
    host_the_toad
    host_the_frog
    host_the_zima
  ];
in
{
  "nas-credentials.age".publicKeys = all_hosts;
  "ssh-to-the-toad.age".publicKeys = all_hosts;
  "ssh-to-the-zima.age".publicKeys = all_hosts;
}
