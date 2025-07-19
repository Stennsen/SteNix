{ pkgs, lib, symlinkJoin, makeWrapper }:
symlinkJoin {
  name = "hypridle";
  paths = with pkgs; [
    hypridle
    hyprlock
    # niri
    brightnessctl
  ];
  buildInputs = [ makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/hypridle \
      --add-flags "--config ${./hypridle.conf}"
  '';
}

