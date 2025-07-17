{
  description = "A very basic flake";

  inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
        #nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
  };

  outputs = { self, nixpkgs }: 
  let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    test = pkgs.stdenv.mkDerivation rec {
        name = "test-bin";
        pname = name;
        version = "2.0";
        src = ./.;
        buildInputs = [pkgs.wrap];
        buildPhase = ''
            mkdir -p $out/bin
            substituteAllInPlace test.sh 
            chmod +x test.sh
        '';
        installPhase = ''
            mv test.sh $out/bin/test-bin
        '';
    };
    hello = pkgs.hello.overrideAttrs (final: previous: {
        pname = "hello-bin";
        doInstallCheck = false;
    });
  in
  {
    packages.x86_64-linux.test = test;
    packages.x86_64-linux.hello = hello;

    packages.x86_64-linux.default = test;

  };
}
