{
  system ? builtins.currentSystem,
  pins ? import ./nix/npins,
  pkgs ? import pins.nixpkgs { inherit system; },
}:
pkgs.mkShell {
  nativeBuildInputs = [
    pkgs.npins
    pkgs.just
    pkgs.nixfmt
  ];

  NPINS_DIRECTORY = "./nix/npins/";
}
