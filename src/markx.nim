import os, osproc, strutils, logging
from sequtils import mapIt

const
  version = """markx version 1.0.0
Copyright (c) 2020 jiro4989
Released under the MIT License.
https://github.com/jiro4989/markx"""

proc markLines(lines: openArray[string], editor: string): seq[string] =
  discard

proc execMarked(marked, srcs: openArray[string], shell: string) =
  discard

proc readLinesFromStdin: seq[string] =
  for line in stdin.lines:
    result.add(line)

proc markx(srcs: seq[string]): int =
  addHandler(newConsoleLogger(lvlInfo, fmtStr = verboseFmtStr, useStderr = true))
  let
    editor = "vim"
    shell = "echo <{}>"
    lines = readLinesFromStdin()
    marked = lines.markLines(editor)
  execMarked(marked, lines, shell)

when isMainModule and not defined modeTest:
  import cligen
  clCfg.version = version
  dispatch(markx)
