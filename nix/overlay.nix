final: prev:
let
  frontend = final.callPackage ./frontend.nix { };
in
{
  pythonPackagesExtensions = (prev.pythonPackagesExtensions or [ ]) ++ [
    (python-final: python-prev: {
      sigma-anywidget = python-final.callPackage ./sigma-anywidget.nix {
        sigma-anywidget-frontend = frontend;
      };
    })
  ];
}
