{ pkgs, lib, ... }:
{
  programs.firefox = {
    enable = true;

    # https://mozilla.github.io/policy-templates/
    policies = {
      AutofillAddressEnabled = true;
      AutofillCreditCardEnabled = false;
      Bookmarks = [];
      Containers = {
      };
      DisableFirefoxAccounts = true;
      DisablePocket = true;
      DisableSetDesktopBackground = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      # https://mozilla.github.io/policy-templates/#policiesjson-53
      ExtensionSettings = {
        "*" = {
          installation_mode = "blocked"; # blocks all addons except the ones specified below
        };
        "uBlock0@raymondhill.net" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        };
      };
      ExtensionUpdate = true;
      HardwareAcceleration = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
    };
    # https://mozilla.github.io/policy-templates/#preferences
    preferences = {
      
    };
  };
}
