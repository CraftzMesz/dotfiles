local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  s(
    "fn",
    fmt("func {}({}) {} {{\n\t{}\n}}", {
      i(1, "FuncName"),
      i(2, "params"),
      i(3, "returnType"),
      i(4, "// body"),
    })
  ),
  s(
    "struct",
    fmt("type {} struct {{\n\t{}\n}}", {
      i(1, "StructName"),
      i(2, "// fields"),
    })
  ),
  s(
    "iferr",
    fmt("if err != nil {{\n\treturn {}\n}}", {
      i(1, "err"),
    })
  ),
  s(
    "print",
    fmt('fmt.Println("{}")', {
      i(1, "message"),
    })
  ),
  s("main", t({ "func main() {", '\tfmt.Println("Hello, World")', "}" })),
}
