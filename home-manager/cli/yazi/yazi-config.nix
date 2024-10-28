
{ pkgs, ... }:
let
  max_preview = pkgs.stdenv.mkDerivation rec {
    name = "max_preview";
    src = pkgs.fetchurl{
      url = "https://raw.githubusercontent.com/yazi-rs/plugins/main/max-preview.yazi/init.lua";
      sha256 = "";
    };
  };
in
{
  programs.yazi = {
    enable = true;
    plugins = max_preview;
  };
}
