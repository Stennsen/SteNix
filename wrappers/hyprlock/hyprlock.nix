{ pkgs, lib, symlinkJoin, makeWrapper }:
symlinkJoin {
  name = "hyprlock wrapper";
  paths = with pkgs; [
    hyprlock
  ];
  buildInputs = [ makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/hyprlock \
      --add-flags "--config ${./hyprlock.conf}"
  '';
}

