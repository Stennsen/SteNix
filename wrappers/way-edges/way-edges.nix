{ pkgs, lib, symlinkJoin, makeWrapper }:
let
  config-file = ./way-edges.jsonc;
in
symlinkJoin {
  name = "way-edges";
  paths = with pkgs; [
    inputs.way-edges."${pkgs.system}.packages.way-edges"
  ];
  buildInputs = [ makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/way-edges \
      --add-flags "-c ${config-file}"
  '';
}

