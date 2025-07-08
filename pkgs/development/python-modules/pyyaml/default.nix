{ lib, buildPythonPackage, fetchPypi, cython, libyaml, buildPackages }:

buildPythonPackage rec {
  pname = "PyYAML";
  version = "3.11";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-w2yTiocuX/SUk4szsUqqFWy0OexnVI/Ks1Nbt4sIRug=";
  };

  # force regeneration using Cython
  postPatch = ''
    rm ext/_yaml.c
  '';

  nativeBuildInputs = [ cython buildPackages.stdenv.cc ];

  buildInputs = [ libyaml ];

  meta = with lib; {
    description = "The next generation YAML parser and emitter for Python";
    homepage = https://github.com/yaml/pyyaml;
    license = licenses.mit;
    maintainers = with maintainers; [ dotlambda ];
  };
}
