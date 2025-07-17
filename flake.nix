{
  description = "A very basic flake";

  inputs = {
        #nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
  };

  outputs = { self, nixpkgs }: 
  let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    hello = pkgs.hello.overrideAttrs (final: previous: {
        pname = "hello-bin";
        doInstallCheck = false;
    });
  in
  {
    packages.x86_64-linux.hello = hello;

    packages.x86_64-linux.default = hello;

  };
}
