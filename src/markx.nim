import os, osproc, strutils, random

const
  version = """markx version 1.0.0
Copyright (c) 2020 jiro4989
Released under the MIT License.
https://github.com/jiro4989/markx"""

proc filterMarkedLines(marked, srcs: openArray[string]): seq[string] =
  for i, markedLine in marked:
    if srcs.len <= i: return
    let line = srcs[i]
    if not markedLine.startsWith("x "): continue
    if markedLine.len - line.len != 2: continue
    if markedLine[2..^1] != line: continue
    result.add(line)

proc execMarked(marked, srcs: openArray[string], command: string) =
  var args = filterMarkedLines(marked, srcs)
  for arg in args:
    let s = command.replace("{}", arg)
    discard execCmd(s)

proc readLinesFromStdinOrArgs(args: seq[string]): seq[string] =
  if 0 < args.len:
    return args
  for line in stdin.lines:
    result.add(line)

proc getRandomFile: string =
  let dir = getTempDir()
  var filename: string
  for i in 1..100:
    let ch = sample(IdentChars)
    filename.add(ch)
    let path = dir / filename
    if not path.existsFile():
      return path

proc editTmpFile*(srcs: seq[string], editor, tmpfile: string): seq[string] =
  defer: removeFile(tmpfile)
  writeFile(tmpfile, srcs.join("\n"))

  discard execCmd(editor & " " & tmpfile)
  result = readFile(tmpfile).split("\n")

proc markx(editor = "vi", command: string, args: seq[string]): int =
  randomize()

  let tmpfile = getRandomFile()
  if tmpfile == "":
    stderr.writeLine("markx: couldn't create tmp file. please retry.")
    return

  let
    editor = getEnv("EDITOR", default = editor)
    lines = readLinesFromStdinOrArgs(args)
    marked = editTmpFile(lines, editor, tmpfile)
  execMarked(marked, lines, command)

when isMainModule and not defined modeTest:
  import cligen
  clCfg.version = version
  dispatch(markx)
