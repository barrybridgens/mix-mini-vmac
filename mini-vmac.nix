# mini-vmac.nix
{
  stdenv,
  fetchzip,
  xorg,
}:

stdenv.mkDerivation {
  pname = "Mini vMac";
  version = "36.04";

  src = fetchzip {
    url = "https://www.gryphel.com/d/minivmac/minivmac-36.04/minivmac-36.04.src.tgz";
    sha256 = "sha256-XA/gNMOcN+PrMnQKIhCNsXIbZh8G59zCdhgAA3FWJ5o=";
  };

  configurePhase = ''
    echo "CONFIGURE PHASE"
    pwd
    gcc setup/tool.c -o setup_t
    ./setup_t -t lx64 > setup.sh
    chmod +x setup.sh
    patchShebangs --build setup.sh
    ./setup.sh
  '';
  
  buildInputs = [ xorg.libX11 ];
  
  installPhase = ''
    mkdir -p $out/bin
    cp minivmac $out/bin
  '';
}
