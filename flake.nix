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
            devShells.${system}.default = pkgs.mkShell {
                packages = [
                    (pkgs.python314.withPackages (ps: [
                        ps.setuptools
                        ps.wheel
                    ]))
                    pkgs.uv
                ];

                shellHook = ''
                    echo "Python version: $(python3 --version)"
                    export PYTHONDONTWRITEBYTECODE=1
                    export PIP_DISABLE_PIP_VERSION_CHECK=1
                '';
            };
    };
}
