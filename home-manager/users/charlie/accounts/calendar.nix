{ ... }:
{
  # setup calendar accounts for this user, the packages are enabled and configured in the feature sets
  # however the user specific account settings are managed here
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
        color = "#0a34f0ff";
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
}
