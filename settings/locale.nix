{ config, lib, ... }:
let
  german = "de_DE.UTF-8";
  us_english = "en_US.UTF-8";
  ISO-8601 = "en_DK.UTF-8"; # for date format "YYYY-MM-DD"
in
{
  # Select internationalisation properties.
  # Mandatory
  i18n.defaultLocale = us_english;

  # Optionally (BEWARE: requires a different format with the added /UTF-8)
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "de_DE.UTF-8/UTF-8"
    "en_DK.UTF-8/UTF-8"
  ];

  # Optionally
  # https://wiki.archlinux.org/title/Locale
  # https://man.archlinux.org/man/locale.7
  i18n.extraLocaleSettings = {
    # LC_ALL = "en_US.UTF-8"; # This overrides all other LC_* settings.
    # LC_CTYPE = "en_US.UTF8";
    LC_ADDRESS = german;
    LC_MEASUREMENT = german;
    LC_MESSAGES = us_english;
    LC_MONETARY = german;
    # LC_NAME = "es_VE.UTF-8";
    LC_NUMERIC = german;
    LC_PAPER = german;
    LC_TELEPHONE = german;
    LC_TIME = ISO-8601;
    LC_COLLATE = german;
  };

}
