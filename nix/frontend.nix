{
  lib,
  buildNpmPackage,
}:
let
  fs = lib.fileset;
  baseSrc = fs.unions [
    ../package-lock.json
    ../package.json
    ../src/sigma_anywidget/js
  ];
in
buildNpmPackage {
  pname = "sigma-anywidget-frontend";
  version = "0.0.1";
  src = fs.toSource {
    root = ../.;
    fileset = baseSrc;
  };
  npmDepsHash = "sha256-J+2UJeueWKEgzsvNvGgdBJdfWcnBAIVN1mWhsnz1//8=";

  installPhase = ''
    mkdir -p $out
    cp -t $out src/sigma_anywidget/static/*
  '';
}
