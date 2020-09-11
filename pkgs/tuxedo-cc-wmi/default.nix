{ stdenv, fetchFromGitHub, linuxPackages, kmod}:

stdenv.mkDerivation rec {
  name = "tuxedo-cc-wmi-${linuxPackages.kernel.version}-${version}";
  version = "0.1";

  src = fetchFromGitHub {
    owner = "tuxedocomputers";
    repo = "tuxedo-cc-wmi";
    rev = "897285bf1d17b2bbdd26c9da5f57850e4efa1ab0";
    sha256 = "1vmbmxf1p1g9fx0z8h3s7h8l14rzafjq2jlvmhxfgzz3zf3jg36k";
  };
  

  NIX_DEBUG = 1;

  unpackPhase = ''
    mkdir -p $out/build/src
    cp -r $src/* $out/build
  '';

  patchPhase = ''
    substituteInPlace $out/build/Makefile --replace /lib/modules/ "${linuxPackages.kernel.dev}/lib/modules/"
    substituteInPlace $out/build/Makefile --replace '$(shell uname -r)' "${linuxPackages.kernel.modDirVersion}"
    substituteInPlace $out/build/Makefile --replace './src' 'src'
  '';

  buildPhase = ''
    make -C $out/build
  '';

  installPhase = ''
    mkdir -p "$out/lib/modules/${linuxPackages.kernel.modDirVersion}"
    cp $out/build/src/tuxedo_cc_wmi.ko $out/lib/modules/${linuxPackages.kernel.modDirVersion}
  '';

  meta = {
      description = "horrific world of tuxedo computers laptops this is fine meme";
      homepage = "https://example.com";
      platforms = stdenv.lib.platforms.linux;
      maintainer = "clushie";
  };
}
