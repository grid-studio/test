{
  description = "A test flake";

  inputs.nixpkgs.url = github:NixOS/nixpkgs?ref=23.05-pre;

  outputs = {self, nixpkgs} :
  let
    system = "x86_64-linux";
    pkg_prefix = "workflows";
    pkg_version = "0.3.0";
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    packages.${system} = {
      full = pkgs.stdenvNoCC.mkDerivation {
        pname = pkg_prefix;
        version = "v${pkg_version}";

        meta = {
          description = "A test flake.  tag:foo,bar";
        };
      };

      default = self.packages.${system}.full;
    };

    devShells.${system}.default = pkgs.mkShell {
      package = [];
      shellHook = ''
        echo Welcome to the '${pkg_prefix}-shell'
      '';
    };
  };
}
