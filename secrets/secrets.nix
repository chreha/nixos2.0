let
  charlie = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH6qAH9JiDDDWzt9HZJ1s0VqUy0j8mme3A0NwH7kfhFc";
  the_toad = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJfXOo/Au0+4KbqgAGntELPtiI6CPgirwB5qJo7RU4aZ";
in
{
  "nas-credentials.age".publicKeys = [
    charlie
    the_toad
  ];
}
