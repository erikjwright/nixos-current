{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
 
  };
  outputs = inputs@{ self, nixpkgs,
      neovim-nightly-overlay,
    zen-browser}: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
./configuration.nix
{
          nix = {
            settings.experimental-features = [ "nix-command" "flakes" ];
          };
        }
];
specialArgs = { inherit inputs; };
    };
  };
}
