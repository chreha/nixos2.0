{ config, ... }:
{
  age.secrets."github-personal" = {
    # This looks for "the-toad-github-personal.age" if the hostname is "the-toad"
    file = ../../secrets/${config.networking.hostName}-github-personal.age;
    path = "/run/agenix/github-personal";
    owner = "charlie";
  };

  age.secrets."github-work" = {
    file = ../../secrets/${config.networking.hostName}-github-work.age;
    path = "/run/agenix/github-work";
    owner = "charlie";
  };
}
