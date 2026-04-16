{ config, ... }:

let
  host = config.networking.hostName;
in
{
  age.secrets = {
    "personal-ssh-key" = {
      file = ../../secrets/charlie-personal-${host}.age;
      path = "/home/charlie/.ssh/charlie-personal-${host}";
      owner = "charlie";
      group = "users";
      mode = "600";
    };
    "work-ssh-key" = {
      file = ../../secrets/charlie-work-${host}.age;
      path = "/home/charlie/.ssh/charlie-work-${host}";
      owner = "charlie";
      group = "users";
      mode = "600";
    };
  };

  programs.fish.shellAliases = {
    use-personal-ssh = "ssh-add -D && ssh-add ~/.ssh/charlie-personal-${host}";
    use-work-ssh = "ssh-add -D && ssh-add ~/.ssh/charlie-work-${host}";
  };
}
