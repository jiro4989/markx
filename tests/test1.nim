import std/unittest

include markx

suite "filterMarkedLines":
  test "marked lines count is 2 / 3":
    let
      m = ["x a", "b", "x c"]
      s = ["a", "b", "c"]
      want = @["a", "c"]
      got = filterMarkedLines(m, s)
    check want == got
  test "marked lines count is 0 / 3":
    let
      m = ["a", "b", "c"]
      s = ["a", "b", "c"]
      want: seq[string] = @[]
      got = filterMarkedLines(m, s)
    check want == got
  test "marked lines count is 3 / 3":
    let
      m = ["x a", "x b", "x c"]
      s = ["a", "b", "c"]
      want: seq[string] = @["a", "b", "c"]
      got = filterMarkedLines(m, s)
    check want == got
  test "NG marks":
    let
      m = ["x  a", "x\tb", "x　c", "xd"]
      s = ["a", "b", "c", "d"]
      want: seq[string] = @[]
      got = filterMarkedLines(m, s)
    check want == got
  test "illegal marked and srcs count":
    let
      m = ["x a", "x b", "x c", ""]
      s = ["a", "b", "c"]
      want: seq[string] = @["a", "b", "c"]
      got = filterMarkedLines(m, s)
    check want == got
  test "illegal marked and srcs count (2)":
    let
      m = ["x a", "x b", "x c"]
      s = ["a", "b", "c", "d"]
      want: seq[string] = @["a", "b", "c"]
      got = filterMarkedLines(m, s)
    check want == got

suite "getEditor":
  test "use editor":
    check "nvim" == getEditor("nvim", "")
  test "use envEditor":
    check "nvim" == getEditor("", "nvim")
  test "use defaultEditor":
    check "vi" == getEditor("", "")
  test "use editor":
    check "nvim" == getEditor("nvim", "nano")
