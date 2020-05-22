import os, osproc, strutils

const
  version = """markx version 1.0.0
Copyright (c) 2020 jiro4989
Released under the MIT License.
https://github.com/jiro4989/markx"""

proc filterMarkedLines(marked, srcs: openArray[string]): seq[string] =
  for i, markedLine in marked:
    let line = srcs[i]
    if not markedLine.startsWith("x "): continue
    if markedLine.len - line.len != 2: continue
    if markedLine[2..^1] != line: continue
    result.add(line)

proc execMarked(marked, srcs: openArray[string], shell: string) =
  var shellArgs = filterMarkedLines(marked, srcs)
  for arg in shellArgs:
    let s = shell.replace("{}", arg)
    discard execCmd(s)

proc readLinesFromStdin: seq[string] =
  for line in stdin.lines:
    result.add(line)

proc editTmpFile*(srcs: seq[string], editor: string): seq[string] =
  let tmpfile = getTempDir() / "tmp.txt"
  defer: removeFile(tmpfile)
  writeFile(tmpfile, srcs.join("\n"))

  discard execCmd(editor & " " & tmpfile)
  result = readFile(tmpfile).split("\n")

proc markx(srcs: seq[string]): int =
  let
    editor = "vim"
    shell = "echo <{}>"
    lines = readLinesFromStdin()
    marked = editTmpFile(lines, editor)
  execMarked(marked, lines, shell)

when isMainModule and not defined modeTest:
  import cligen
  clCfg.version = version
  dispatch(markx)
