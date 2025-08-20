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
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];
      # Small tool to iterate over each systems
      eachSystem = fn: inputs.nixpkgs.lib.genAttrs systems (sys: fn inputs.nixpkgs.legacyPackages.${sys});
      # pkgs = import inputs.nixpkgs {
      #   inherit system;
      #   config.allowUnfreePredicate =
      #     pkg: builtins.elem (inputs.nixpkgs.lib.getName pkg) [ "google-chrome" ];
      # };
    in
    {

      devShells = eachSystem (pkgs: {
        default = pkgs.mkShell {

          # env vars
          UV_PYTHON_DOWNLOADS = "never";
          packages = with pkgs; [
            ansible
            ansible-lint
            fzf
            just
            (python3.withPackages (
              python-pkgs: with python-pkgs; [
                cogapp
                argcomplete
                # add ansible here?
              ]
            ))
            # nix
            nixfmt-rfc-style
            nixd
          ];
          # inputsFrom = [
          #   # pkgs.hello
          #   # pkgs.gnutar
          # ];
          # shellHook = ''
          #   uv tree
          # '';

        };
      });

      # # nix.nixPath = [ "nixpkgs=${pkgs}" ];
      # devShells.${system}.default = pkgs.mkShell {
      #   # env vars
      #   UV_PYTHON_DOWNLOADS = "never";
      #   packages = with pkgs; [
      #     ansible
      #     ansible-lint
      #     fzf
      #     just
      #     (python3.withPackages (
      #       python-pkgs: with python-pkgs; [
      #         cogapp
      #         argcomplete
      #       ]
      #     ))
      #   ];
      #   # inputsFrom = [
      #   #   # pkgs.hello
      #   #   # pkgs.gnutar
      #   # ];
      #   # shellHook = ''
      #   #   uv tree
      #   # '';

      # };

      # packages.${system} = {
      #   inherit (self.devShells.${system}) default;
      # };
      #       packages = eachSystem (
      #         pkgs: {
      # default =

      #         }
      #       )

      apps = eachSystem (pkgs: rec {
        lint = {
          type = "app";
          # program = "${self.packages.${pkgs.system}.default}/bin/${pname}";
          program = "${pkgs.ansible-lint}/bin/ansible-lint";
        };
        default = lint;
      });

    };
}
