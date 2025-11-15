{
    description = "Dev environment with Python 3.14";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    outputs = { self, nixpkgs }:
        let
            system = "aarch64-darwin";
            pkgs = nixpkgs.legacyPackages.${system};
        in {
            shell = pkgs.zsh;

            devShells.${system}.default = pkgs.mkShell {
                packages = [
                    pkgs.python314
                    pkgs.uv
                ];

                shellHook = ''
                    echo "Python version: $(python3 --version)"
                '';
            };
    };
}
