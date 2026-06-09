# Sigma.js Anywidget

A super barebones [sigma.js](https://sigmajs.org) widget using
[anywidget](https://anywidget.dev) built for marimo or jupyter or whatever.

You probably don't want to use this. There are better graph widgets out there
like the one in
[wigglystuff](https://molab.marimo.io/github/koaning/wigglystuff/blob/main/demos/graphwidget.py/wasm).

## Installation

### Pypi

This is alive on [pypi](https://pypi.org/project/sigma-anywidget/), you can install it with:

```sh
pip install sigma_anywidget
```

or however python people manage their dependencies this month.

### Nix

A nixpkgs overlay is provided in `./nix/overlay.nix`. I can't cover all the
ways that one might consume this but here is an example using [npins](https://github.com/andir/npins).

First add the source to the pins:
```sh
npins add github erooke sigma-anywidget
```

From there you can consume it like any other pin. For example you could have
the following `shell.nix`.
```nix
{
  system ? builtins.currentSystem,
  pins ? import ./npins,
  nixpkgs ? import pins.nixpkgs { inherit system; },
}:
let
  pkgs = nixpkgs.appendOverlays [
    (import "${pins.sigma-anywidget}/nix/overlay.nix")
  ];
in
pkgs.mkShell {
  nativeBuildInputs = [
    (pkgs.python3.withPackages (ps: [ ps.sigma-anywidget ]))
  ];
}
```

## Docs

Another reason you probably don't want to use this. There are no docs. There is
a singular marimo notebook example in `examples/basic.py`.

## Development

If you want to hack on this, install nix and run `nix-shell`. Pull requests/issues are welcome.
