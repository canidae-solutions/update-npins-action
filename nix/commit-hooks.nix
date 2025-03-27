let
  pins = import ../npins;
in

{
  lib,
  crate2nix,
  nixfmt-rfc-style,
  rustToolchain,

  git-hooks ? import pins.git-hooks,
}:

git-hooks.run {
  src = ./.;
  hooks = {
    clippy.enable = true;
    rustfmt.enable = true;

    nixfmt-rfc-style = {
      enable = true;
      excludes = [
        "nix/rust-build\\.nix$"
        "npins/default\\.nix$"
      ];
    };

    regen-rust-build = {
      enable = true;
      name = "Regen nix/rust-build.nix";
      entry = "${lib.getExe crate2nix} generate -o nix/rust-build.nix";
      files = "Cargo\\.lock$";
      pass_filenames = false;
    };
  };

  tools = {
    inherit nixfmt-rfc-style;
    inherit (rustToolchain) cargo clippy rustfmt;
  };
}
