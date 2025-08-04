{ lib, pkgs, config, inputs, ... }:

{
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  fonts.packages = builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts)
  ++ (with pkgs; [
    # google-fonts
    dejavu_fonts
    noto-fonts-color-emoji
  ]);

  stylix = {
    enable = true;
    autoEnable = true;

    image = pkgs.fetchurl {
      url = "https://cdna.artstation.com/p/assets/images/images/061/675/990/large/eugene-siryk-deezerroom1-night1-2160.jpg";
        sha256 = "xve3FnuLqW9DHAhCjNp3Zr/eEzVzMTx10Zqo+iPf/QE=";
      };
    polarity = "dark";

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
      serif = config.stylix.fonts.monospace;
      sansSerif = config.stylix.fonts.monospace;
      emoji = config.stylix.fonts.monospace;
      # sansSerif = {
      #   package = pkgs.dejavu_fonts;
      #   name = "DejaVu Sans";
      # };
      # serif = {
      #   package = pkgs.dejavu_fonts;
      #   name = "DejaVu Serif";
      # };
      # emoji = {
      #   package = pkgs.noto-fonts-color-emoji;
      #   name = "Noto Color Emoji";
      # };
    };
  };
}
