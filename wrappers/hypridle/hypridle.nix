{ symlinkJoin, makeWrapper, pkgs }:
let
  lock-bin = "${pkgs.hyprlock}/bin/hyprlock";
  lock-sh = pkgs.writeShellScriptBin "lock-sh" ''
    pidof hyprlock || ${lock-bin}
  '';
in
symlinkJoin {
  name = "hypridle";
  paths = with pkgs; [ hypridle lock-sh brightnessctl systemd ];
  buildInputs = [ makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/hypridle \
      --add-flags "--config ${./hypridle.conf}"
  '';
}

