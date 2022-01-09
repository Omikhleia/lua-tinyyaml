-- .vscode/settings.json <<
--   "Lua.workspace.library": {
--     "C:\\ProgramData\\chocolatey\\lib\\luarocks\\luarocks-2.4.4-win32\\systree\\share\\lua\\5.1": true
--   },
local busted = require 'busted'
local assert = require 'luassert'
local yaml = require 'tinyyaml'

busted.describe("seq", function()

  busted.it("nested seq:", function()
    assert.same(
      {
        vars = {{"scheme", "==", "http"}}
      },
      yaml.parse([[
            vars:
            -
              - "scheme"
              - "=="
              - "http"
      ]])
    )
  end)

  busted.it("inline nested seq:", function()
    assert.same(
      {
        vars = {{"scheme", "==", "http"}}
      },
      yaml.parse([[
            vars:
            - - "scheme"
              - "=="
              - "http"
      ]])
    )
  end)

  busted.it("seq bad alias syntax:", function()
    assert.has_error(
      function()
        yaml.parse([[
          anchor_value: &anchor "schema"
          vars:
          - *
        ]])
      end,
      "did not find expected alphabetic or numeric character"
    )
  end)
end)
