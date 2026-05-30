{
  system ? builtins.currentSystem,
  pins ? import ./nix/npins,
  pkgs ? import pins.nixpkgs { inherit system; },
  treefmt-nix ? import pins.treefmt-nix,
}:
let
  formatter = import ./nix/format.nix { inherit treefmt-nix pkgs; };
  python = import ./nix/python.nix { inherit pkgs; };
in
pkgs.mkShell {
  nativeBuildInputs = [
    pkgs.npins
    pkgs.just
    pkgs.nodejs

    formatter
    python
  ];

  NPINS_DIRECTORY = "./nix/npins/";
  ANYWIDGET_HMR = "1"; # Enable hot module reloading for anywidget

  shellHook = ''
    if [ -z "$PYTHONPATH" ]
      then export PYTHONPATH=$(realpath ./src)
      else export PYTHONPATH=$(realpath ./src):$PYTHONPATH
    fi

    just --list-heading $'Some Commands:\n' --list-prefix "just " --list
  '';
}
