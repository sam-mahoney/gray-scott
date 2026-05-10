{
  description = "Gray-Scott reaction-diffusion simulation";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
      python = pkgs.python3;
      pythonEnv = python.withPackages (ps: with ps; [
        numpy
        scipy
        matplotlib
        jupyter
        ipykernel
      ]);
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = [ pythonEnv ];

        shellHook = ''
          echo "gray-scott dev shell"
          echo "Python: $(python --version)"
        '';
      };
    };
}
