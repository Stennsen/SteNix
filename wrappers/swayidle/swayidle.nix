{ pkgs, lib, symlinkJoin, makeWrapper }:
let
  # Lock command
  hyprlock = "${ (pkgs.callPackage ../hyprlock/hyprlock.nix {}) }/bin/hyprlock";
  lock = "${pkgs.procps}/bin/pidof || ${hyprlock}";

  # brightness control
  brillo = "${pkgs.brillo}/bin/brillo";
  dim-screen = "${brillo} -O && ${brillo} -S 5 -u 500000";
  undim-screen = "${brillo} -I -u 300000";
  display = status: "${pkgs.niri}/bin/niri msg action power-${status}-monitors";

  # config
  config-file = pkgs.writeText "swayidle.conf" ''
    lock "${lock}"
    before-sleep "${(display "off")}"
    after-resume "${(display "on")} & ${undim-screen}"
    idlehint 120
    timeout 150 "${dim-screen}"
    timeout 180 "loginctl lock-session & ${(display "off")}"
    timeout 600 "${pkgs.systemd}/bin/systemctl suspend"
  '';
in
symlinkJoin {
  name = "swayidle wrapper for niri";
  paths = with pkgs; [
    swayidle
  ];
  buildInputs = [ makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/swayidle \
      --add-flags "-C ${config-file}"
  '';
}

