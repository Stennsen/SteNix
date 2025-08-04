{ config, pkgs, lib, symlinkJoin, makeWrapper }:
let
  background-image = pkgs.fetchurl {
     url = "https://cdna.artstation.com/p/assets/images/images/061/675/990/large/eugene-siryk-deezerroom1-night1-2160.jpg";
     sha256 = "xve3FnuLqW9DHAhCjNp3Zr/eEzVzMTx10Zqo+iPf/QE=";
   };
  config-file = pkgs.replaceVars ./hyprlock.conf {
    inherit background-image;
  };
in
symlinkJoin {
  name = "hyprlock wrapper";
  paths = with pkgs; [
    hyprlock
  ];
  buildInputs = [ makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/hyprlock \
      --add-flags "--config ${config-file}"
  '';
}

