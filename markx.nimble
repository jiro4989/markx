# Package

version       = "1.0.2"
author        = "jiro4989"
description   = "markx selects execution targets with editor and executes commands."
license       = "MIT"
srcDir        = "src"
bin           = @["markx"]
binDir        = "bin"


# Dependencies

requires "nim >= 1.0.6"
requires "cligen >= 0.9.47"

import os, strformat

task archive, "Create archived assets":
  let app = "markx"
  let assets = &"{app}_{buildOS}"
  let dir = "dist"/assets
  mkDir dir
  cpDir "bin", dir/"bin"
  cpFile "LICENSE", dir/"LICENSE"
  cpFile "README.rst", dir/"README.rst"
  withDir "dist":
    when buildOS == "windows":
      exec &"7z a {assets}.zip {assets}"
    else:
      exec &"tar czf {assets}.tar.gz {assets}"
