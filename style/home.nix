{ pkgs, ... }:
{
  home-manager.users."stennsen".imports = [
    {
      home = {
        pointerCursor = {
          name = "Fuchsia-Pop";
          package = (pkgs.fuchsia-cursor.override {
            themeVariants = ["Fuchsia-Pop"];
            sizeVariants = ["32"];
            platformVariants = ["x11"];
          });
          size = 32;
          x11.enable = true;
          gtk.enable = true;
        };
      };
    }
  ];
}