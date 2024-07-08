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
    backupFileExtension = "backup";
  };
  programs.zsh.enable = true;
  users.users.stennsen.shell = pkgs.zsh;
}
