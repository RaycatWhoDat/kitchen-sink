local syntaxdefs = require 'nelua.syntaxdefs'
local aster = require 'nelua.aster'
local analyzer = require 'nelua.analyzer'
local grammar = syntaxdefs.grammar
local shaper = aster.shaper

grammar = grammar:gsub(
   "Assign / call /",
   "Assign / AddAssign / SubAssign / MulAssign / DivAssign / call /"
)

grammar = grammar:gsub(
   "Assign%s*<== vars `=` @exprs",
   "Assign <== vars `=` @exprs\nAddAssign <== var `+=` @expr\nSubAssign <== var `-=` @expr\nMulAssign <== var `*=` @expr\nDivAssign <== var `/=` @expr"
)

aster.register_syntax({
  extension = 'nelua',
  grammar = grammar,
  errors = syntaxdefs.errors,
  defs = syntaxdefs.defs,
})

local optypes = { 'Add', 'Sub', 'Mul', 'Div' }

for _, optype in ipairs(optypes) do
   aster.register(optype .. "Assign", { shaper.Node, shaper.Node })

   analyzer.visitors[optype .. "Assign"] = function (context, node)
    context:transform_and_traverse_node(node,
      aster.Assign{{node[1]:clone()}, {aster.BinaryOp{node[1], optype:lower(), node[2]}}}
    )
  end
end
