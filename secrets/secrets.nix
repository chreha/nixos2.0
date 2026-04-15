let
  host_the_toad = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJfXOo/Au0+4KbqgAGntELPtiI6CPgirwB5qJo7RU4aZ root@the-toad";
  host_the_frog = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKUgFgT982NrCWiL9Rg8vd9Bes6GpqJpPuLnyHy2z4yM root@the-frog";
  host_the_zima = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINuVpmdcgKA8xx2Suvy8B6z7JrUu6/aWFeNd0myvGMBn root@the-zima";
  systems = [
    host_the_toad
    host_the_frog
    host_the_zima
  ];
in
{
  "frog_personal.age".publicKeys = [ host_the_frog ];
  "frog_work.age".publicKeys = [ host_the_frog ];
  "toad_personal.age".publicKeys = [ host_the_toad ];
  "toad_work.age".publicKeys = [ host_the_toad ];
  "zima_personal.age".publicKeys = [ host_the_zima ];
  "zima_work.age".publicKeys = [ host_the_zima ];

  "nas-credentials.age".publicKeys = systems;
}
