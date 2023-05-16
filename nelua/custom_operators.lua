local syntaxdefs = require 'nelua.syntaxdefs'
local aster = require 'nelua.aster'
local grammar = syntaxdefs.grammar
local shaper = aster.shaper

-- grammar = grammar:gsub(
--    "chunk           <-- SHEBANG? SKIP Block (!.)%^UnexpectedSyntax",
--    "chunk           <-- SHEBANG? SKIP Block"
-- )

grammar = grammar:gsub(
   "Assign / call /",
   "Assign / AddAssign / call /"
)

grammar = grammar:gsub(
   "Assign%s*<== vars `=` @exprs",
   "Assign <== vars `=` @exprs\nAddAssign <== vars `+=` @exprs"
)

aster.register_syntax({
  extension = 'neluam',
  grammar = grammar,
  errors = syntaxdefs.errors,
  defs = syntaxdefs.defs,
})

-- aster.register('AddAssign', { shaper.Node, shaper.Node }, { is_operator = true })


-- aster.Block{
--    aster.Assign{
--       {aster.Id{"a"}},
--       {aster.BinaryOp{aster.Id{'a'}, 'add', aster.Id{'b'}}}
-- }}
