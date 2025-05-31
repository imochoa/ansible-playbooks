{
  description = "ansiblePull";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
  outputs =
    inputs@{
      self,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfreePredicate =
          pkg: builtins.elem (inputs.nixpkgs.lib.getName pkg) [ "google-chrome" ];
      };
    in
    {

      # nix.nixPath = [ "nixpkgs=${pkgs}" ];
      devShells.${system}.default = pkgs.mkShell {
        # env vars
        UV_PYTHON_DOWNLOADS = "never";
        packages = with pkgs; [
          ansible
          ansible-lint
          just
          (python3.withPackages (
            python-pkgs: with python-pkgs; [
              cogapp
              argcomplete
            ]
          ))
        ];
        # inputsFrom = [
        #   # pkgs.hello
        #   # pkgs.gnutar
        # ];
        # shellHook = ''
        #   uv tree
        # '';

      };

      packages.${system} = {
        inherit (self.devShells.${system}) default;
      };
    };
}
