{ pkgs, inputs, ... }:
{
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "stennsen" =  {
        imports = [
          ./home.nix
        ];
      };
    };
    backupFileExtension = "home-manager.backup";
  };
  users.users.stennsen.shell = pkgs.zsh;
  programs.zsh.enable = true;
}
