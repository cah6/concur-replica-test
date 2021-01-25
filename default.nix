{ mkDerivation, async, base, bytestring, concur-core
, concur-replica, containers, directory, filepath, gitrev, hashable
, hpack, lens, mtl, random, safe-exceptions, servant-server, stdenv
, stm, text, time, transformers, unordered-containers, wai
, wai-middleware-static, websockets
}:
mkDerivation {
  pname = "concur-replica-template";
  version = "0.0.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    async base bytestring concur-core concur-replica containers
    directory filepath gitrev hashable lens mtl random safe-exceptions
    servant-server stm text time transformers unordered-containers wai
    wai-middleware-static websockets
  ];
  libraryToolDepends = [ hpack ];
  executableHaskellDepends = [
    async base bytestring concur-core concur-replica containers
    directory filepath gitrev hashable lens mtl random safe-exceptions
    servant-server stm text time transformers unordered-containers wai
    wai-middleware-static websockets
  ];
  prePatch = "hpack";
  license = stdenv.lib.licenses.bsd3;
}
