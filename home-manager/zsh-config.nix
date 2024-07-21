{ config, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
        ll = "ls -l";
        rebuild = "sudo nixos-rebuild switch --flake ~/.config/nixos#t480";
	cat = "bat";
    };
    history = {
        size = 10000;
        path = "${config.xdg.dataHome}/zsh/history";
    };
  };
}
