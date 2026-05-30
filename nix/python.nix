{ pkgs }:
pkgs.python3.withPackages (ps: [
  ps.anywidget
  ps.watchfiles # This is needed for hmr
])
