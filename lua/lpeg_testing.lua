local lpeg = require("lpeg")
local V, S, R, P, C, Cc, Ct = lpeg.V, lpeg.S, lpeg.R, lpeg.P, lpeg.C, lpeg.Cc, lpeg.Ct

local patt = P {
   "TOP";
   TOP = P("a") * C(P("b") ^ 1) * P("c")
}

local test_cases = { "a", "abc", "ac", "abbbbbbbbc" }

for _, test_case in ipairs(test_cases) do
   print(lpeg.match(patt, test_case))
end

         
