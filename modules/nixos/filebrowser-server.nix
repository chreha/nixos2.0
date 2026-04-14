{ ... }:
{
  virtualisation.oci-containers.containers."filebrowser" = {
    image = "filebrowser/filebrowser:latest";
    ports = [ "8080:80" ]; # Access via http://zimaboard-ip:8080
    volumes = [
      "/mnt/the-pond:/srv" # Point FileBrowser to your RAID
      "/var/lib/filebrowser/filebrowser.db:/database.db" # Persistent database
    ];
    cmd = [
      "--database"
      "/database/filebrowser.db"
    ];
    user = "1000:100"; # Run as 'charlie' (uid 1000) and group 'users' (gid 100)
  };

}
