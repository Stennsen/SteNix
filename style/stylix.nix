{ pkgs, config, ... }:

{
  fonts.packages = with pkgs; [
    nerdfonts
  ];

  stylix = {
    enable = true;
    autoEnable = true;
    homeManagerIntegration.autoImport = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    image = pkgs.fetchurl {
      url = "https://cdna.artstation.com/p/assets/images/images/061/675/990/large/eugene-siryk-deezerroom1-night1-2160.jpg";
        sha256 = "xve3FnuLqW9DHAhCjNp3Zr/eEzVzMTx10Zqo+iPf/QE=";
      };

    cursor = {
      package = (pkgs.fuchsia-cursor.override {
        themeVariants = ["Fuchsia-Pop"];
        sizeVariants = ["32"];
        platformVariants = ["x11"];
      });
      name = "Fuchsia-Pop";
      size = 32;
    };



    fonts = {
      monospace = {
        package = pkgs.jetbrains-mono;
        name = "JetBrains Mono";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };

    opacity = {
      applications = 0.7;
      popups = 0.7;
      terminal = 0.7;
      desktop = 0.7;
    };

    polarity = "dark";
  };
}
