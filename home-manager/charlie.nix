{ pkgs, ... }:
{
  imports = [
    ./common # Pulls in the overlays and basic apps
    ./so-you-want-to/be-a-developer
    ./so-you-want-to/be-a-communicator
  ];

  home = {
    username = "charlie";
    homeDirectory = "/home/charlie";
    stateVersion = "25.05";

    # Charlie-specific apps
    packages = with pkgs; [
      # i like bonsai's
      cbonsai
    ];
  };
  accounts.email.accounts = {
    "personal" = {
      primary = true;
      address = "charles.hreha@gmail.com";
      realName = "Charles Hreha";
      userName = "charles.hreha@gmail.com";
      imap.host = "imap.gmail.com";
      smtp.host = "smtp.gmail.com";
      # Standard ports for Google
      imap.port = 993;
      smtp.port = 465;
      # TLS is required for Gmail
      imap.tls.enable = true;
      smtp.tls.enable = true;

      thunderbird = {
        enable = true;
        profiles = [ "default" ];
        # Even personal Gmail accounts often require OAuth2 now
        settings = id: {
          "mail.server.server_${id}.authMethod" = 10;
          "mail.smtpserver.smtp_${id}.authMethod" = 10;
        };
      };
    };

    "work" = {
      primary = false;
      address = "charles@wearetripwire.com";
      realName = "Charles Hreha";
      userName = "charles@wearetripwire.com";
      imap.host = "imap.gmail.com";
      smtp.host = "smtp.gmail.com";
      imap.port = 993;
      smtp.port = 465;
      imap.tls.enable = true;
      smtp.tls.enable = true;

      thunderbird = {
        enable = true;
        profiles = [ "default" ];
        settings = id: {
          "mail.server.server_${id}.authMethod" = 10; # 10 = OAuth2
          "mail.smtpserver.smtp_${id}.authMethod" = 10;
        };
      };
    };
  };
  programs = {
    git = {
      enable = true;
      settings = {
        user = {
          email = "charles.hreha@gmail.com";
          name = "Charlie Hreha";
        };
        pull = {
          rebase = false;
        };
        push = {
          autoSetupRemote = true;
        };
        init = {
          defaultBranch = "main";
        };
      };
    };
  };
}
