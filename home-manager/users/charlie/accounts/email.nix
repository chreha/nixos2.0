{ ... }:
{
  # setup email accounts for this user, the packages are enabled and configured in the feature sets
  # however the user specific account settings are managed here
  accounts.email.accounts = {
    "personal" = {
      primary = true;
      address = "charles.hreha@gmail.com";
      realName = "Charles Hreha";
      userName = "charles.hreha@gmail.com";
      imap.host = "imap.gmail.com";
      smtp.host = "smtp.gmail.com";
      imap.port = 993;
      smtp.port = 465;
      imap.tls.enable = true;
      smtp.tls.enable = true;

      # required because gmail does not follow normal imap folder conventions
      folders = {
        sent = "[Gmail]/Sent Mail";
        trash = "[Gmail]/Trash";
        drafts = "[Gmail]/Drafts";
      };

      # tie this account into thunderbird, if needed in other packages list them here as well
      thunderbird = {
        enable = true;
        profiles = [ "default" ];
        # require OAuth2
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

      # required because gmail does not follow normal imap folder conventions
      folders = {
        sent = "[Gmail]/Sent Mail";
        trash = "[Gmail]/Trash";
        drafts = "[Gmail]/Drafts";
      };

      thunderbird = {
        enable = true;
        profiles = [ "default" ];
        # require OAuth2
        settings = id: {
          "mail.server.server_${id}.authMethod" = 10; # 10 = OAuth2
          "mail.smtpserver.smtp_${id}.authMethod" = 10;
        };
      };
    };
  };
}
