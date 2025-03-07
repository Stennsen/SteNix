{ config, pkgs, ... }:

  let
    lock-false = {
      Value = false;
      Status = "locked";
    };
    lock-true = {
      Value = true;
      Status = "locked";
    };
  in
{
  programs = {
    firefox = {
      enable = true;
      package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
        extraPolicies = {
          DisableTelemetry = true;
          pipewireSupport = true;
          Homepage = {
            StartPage = "previous-session";
          };
          OfferToSaveLogins = false;

          /* ---- EXTENSIONS ---- */
          ExtensionSettings = {
            "*".installation_mode = "allowed"; # blocks all addons except the ones specified below
            # uBlock Origin:
            "uBlock0@raymondhill.net" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
              installation_mode = "force_installed";
            };
            "@testpilot-containers" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/multi-account-containers/latest.xpi";
              installation_mode = "force_installed";
            };
            "7esoorv3@alefvanoon.anonaddy.me" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/libredirect/latest.xpi";
              installation_mode = "force_installed";
            };
          };

          /* ---- PREFERENCES ---- */
          # Set preferences shared by all profiles.
          Preferences = {
            "browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
            "extensions.pocket.enabled" = lock-false;
            "extensions.screenshots.disabled" = lock-true;
            "toolkit.legacyUserProfileCustomizations.stylesheets" = lock-true;
            "widget.use-xdg-desktop-portal.file-picker" = 1;
          };
        };
      };

      /* ---- PROFILES ---- */
      # Switch profiles via about:profiles page.
      # For options that are available in Home-Manager see
      # https://nix-community.github.io/home-manager/options.html#opt-programs.firefox.profiles
      profiles ={
        stennsen = {           # choose a profile name; directory is /home/<user>/.mozilla/firefox/profile_0
          id = 0;               # 0 is the default profile; see also option "isDefault"
          isDefault = true;     # can be omitted; true if profile ID is 0
          name = "Stennsen";   # name as listed in about:profiles
          settings = {          # specify profile-specific preferences here; check about:config for options
            "browser.newtabpage.activity-stream.feeds.section.highlights" = false;
            #"browser.startup.homepage" = "https://nixos.org";
            "browser.newtabpage.pinned" = [{
              title = "NixOS";
              url = "https://nixos.org";
            }];
            # add preferences for profile_0 here...
          };
          userChrome = builtins.readFile ./userChrome.css;
        };
      };
    };
  };
}
