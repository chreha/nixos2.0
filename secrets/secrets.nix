let
  host_the_toad = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJfXOo/Au0+4KbqgAGntELPtiI6CPgirwB5qJo7RU4aZ root@the-toad";
  host_the_frog = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKUgFgT982NrCWiL9Rg8vd9Bes6GpqJpPuLnyHy2z4yM root@the-frog";
  host_the_zima = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINuVpmdcgKA8xx2Suvy8B6z7JrUu6/aWFeNd0myvGMBn root@the-zima";
  systems = [
    host_the_toad
    host_the_frog
    host_the_zima
  ];
  charlie-personal-the-toad = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMaacHJjPYdZ80axr8I/qRQ1hxWhHaxZWGKtpQemAnRY charlie.personal@the-toad";
  charlie-work-the-toad = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM6srDSxyR/4ab4G/QaaFfJur8E1PIdOEXjo99Jo60la charlie.work@the-toad";
  charlie-personal-the-frog = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMGMm2KocGx8sbJY3pItCpNONmFG7JnjyKk9fszY/8n/ charlie.personal@the-frog";
  charlie-work-the-frog = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN8nrc+DcZ0sSepeCCNERvvBtSEEOd9SDscqMNSM7DP1 charlie.work@the-frog";
  charlie-personal-the-zima = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHByWzY5B/aLzXZnpOEPTTh/dP/+kVnMvKXaJrV/3Zh6 charlie.personal@the-zima";
  charlie-work-the-zima = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINSeadxxHS8bLy7aCciKSjv3dN4Qh+WFaZE+adH4xrv8 charlie.work@the-zima";
  users = [
    charlie-personal-the-toad
    charlie-work-the-toad
    charlie-personal-the-frog
    charlie-work-the-frog
    charlie-personal-the-zima
    charlie-work-the-zima
  ];
in
{
  "charlie-personal-the-toad.age".publicKeys = [
    host_the_toad
    charlie-personal-the-toad
  ];
  "charlie-work-the-toad.age".publicKeys = [
    host_the_toad
    charlie-work-the-toad
  ];
  "charlie-personal-the-frog.age".publicKeys = [
    host_the_toad
    host_the_frog
    charlie-personal-the-frog
  ];
  "charlie-work-the-frog.age".publicKeys = [
    host_the_toad
    host_the_frog
    charlie-work-the-frog
  ];
  "charlie-personal-the-zima.age".publicKeys = [
    host_the_toad
    host_the_zima
    charlie-personal-the-zima
  ];
  "charlie-work-the-zima.age".publicKeys = [
    host_the_toad
    host_the_zima
    charlie-work-the-zima
  ];
}
