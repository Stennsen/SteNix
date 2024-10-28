
{ ... }:
{
  programs.zed-editor = {
    enable = true;
    
    # https://github.com/zed-industries/extensions/tree/main/extensions
    extensions = [
      "catpuccin-blur"
    ];
    
    userKeymaps = {};
    
    userSettings = {
      vim_mode = true;
    };
  };
}