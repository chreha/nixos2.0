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
        # require OAuth2
        settings = id: {
          "mail.server.server_${id}.authMethod" = 10; # 10 = OAuth2
          "mail.smtpserver.smtp_${id}.authMethod" = 10;
        };
      };

      # required because gmail does not follow normal imap folder conventions
      folders = {
        sent = "[Gmail]/Sent Mail";
        trash = "[Gmail]/Trash";
        drafts = "[Gmail]/Drafts";
      };
    };
  };

  accounts.calendar.accounts = {
    "Personal" = {
      primary = true;
      remote = {
        type = "caldav";
        # when setting up a google calendar connection the url structure is
        # https://apidata.googleusercontent.com/caldav/v2/[Calendar ID]/events
        # you can get the Calendar ID from google calendar settings
        url = "https://apidata.googleusercontent.com/caldav/v2/charles.hreha@gmail.com/events";
        userName = "charles.hreha@gmail.com";
      };
      thunderbird = {
        enable = true;
        profiles = [ "default" ];
        color = "#42253B";
      };
    };
    "Family" = {
      remote = {
        type = "caldav";
        url = "https://apidata.googleusercontent.com/caldav/v2/family09878188899936911630@group.calendar.google.com/events";
        userName = "charles.hreha@gmail.com";
      };
      thunderbird = {
        enable = true;
        profiles = [ "default" ];
        color = "#5C7457";
      };

    };
    "Work" = {
      remote = {
        type = "caldav";
        url = "https://apidata.googleusercontent.com/caldav/v2/charles@wearetripwire.com/events";
        userName = "charles@wearetripwire.com";
      };
      thunderbird = {
        enable = true;
        profiles = [ "default" ];
        color = "#934B00";
      };
    };
    "Tripwire" = {
      remote = {
        type = "caldav";
        url = "https://apidata.googleusercontent.com/caldav/v2/c_0b64ed978c01e4ee307c3994ab3a3e2b2ba7f7e1b5dd418396404554f3bd1deb@group.calendar.google.com/events";
        userName = "charles@wearetripwire.com";
      };
      thunderbird = {
        enable = true;
        profiles = [ "default" ];
        color = "#F0F3F5";
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
