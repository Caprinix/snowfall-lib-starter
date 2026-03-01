{ pkgs, lib, config, inputs, ... }:

{
  languages.nix.enable = true;
  languages.nix.lsp.enable = true;
  languages.nix.lsp.package = pkgs.nixd;

  git-hooks.hooks.nix-flake-check = {
    enable = true;
    entry = "nix flake check --all-systems";
    pass_filenames = false;
  };
}
