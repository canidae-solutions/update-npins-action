let
  pins = import ./npins;
  nixpkgs = import pins.nixpkgs {
    config = { };
    overlays = [ ];
  };
in

{
  pkgs ? nixpkgs,
}:

let
  appliedOverlay = (import ./nix/overlay.nix) pkgs pkgs;
in
{
  inherit (appliedOverlay) rust-build update-npins-action;
}
