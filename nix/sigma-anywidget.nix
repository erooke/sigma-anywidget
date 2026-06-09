{
  lib,
  buildPythonPackage,
  hatchling,
  anywidget,
  sigma-anywidget-frontend,
}:
let
  fs = lib.fileset;
  baseSrc = fs.unions [
    ../pyproject.toml
    ../readme.md
    ../src/sigma_anywidget
  ];
in
buildPythonPackage {
  pname = "sigma_anywidget";
  version = "0.0.1";
  pyproject = true;
  src = fs.toSource {
    root = ../.;
    fileset = baseSrc;
  };

  build-system = [
    hatchling
  ];

  dependencies = [
    anywidget
  ];

  postUnpack =
    let
      static_root = "source/src/sigma_anywidget/static/";
    in
    ''
      mkdir -p ${static_root}
      cp -t ${static_root} ${sigma-anywidget-frontend}/*
    '';
}
