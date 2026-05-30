{
  pkgs,
  treefmt-nix,
}:
treefmt-nix.mkWrapper pkgs {
  projectRootFile = ".git/config";

  programs = {
    just.enable = true;
    nixfmt.enable = true;
    ruff-format.enable = true;
    prettier = {
      enable = true;
      excludes = [
        "*.md"
        "*.json"
      ];
    };
  };

  # The built in ruff-check runs the whole lint. This just runs the import order fixer
  settings.formatter = {
    "python-imports" = {
      command = "${pkgs.ruff}/bin/ruff";
      options = [
        "check"
        "--select"
        "I"
        "--fix"
      ];
      includes = [ "*.py" ];
    };
  };
}
