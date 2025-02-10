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
  programs.nix-ld.enable = true;
  programs.ssh.startAgent = true;
}
