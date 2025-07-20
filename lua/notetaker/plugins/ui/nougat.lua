return {
  "MunifTanjim/nougat.nvim",
  lazy = false,
  config = function()
    local nougat = require("nougat")
    local Bar = require("nougat.bar")

    -- Minimal statusline: mode | filename | filetype | ruler
    local stl = Bar("statusline")
    stl:add_item({
      content = function()
        return vim.fn.mode()
      end,
    })
    stl:add_item({ content = " | " })
    stl:add_item({
      content = function()
        return vim.fn.expand("%:t")
      end,
    })
    stl:add_item({ content = " | " })
    stl:add_item({
      content = function()
        return vim.bo.filetype
      end,
    })
    stl:add_item({ content = " | " })
    stl:add_item({
      content = function()
        return string.format("%d:%d", vim.fn.line("."), vim.fn.col("."))
      end,
    })

    nougat.set_statusline(stl)

    -- Disable tabline since we're using bufferline
    -- local tal = Bar("tabline")
    -- tal:add_item({
    --   content = function()
    --     local tabs = {}
    --     for i = 1, vim.fn.tabpagenr('$') do
    --       if i == vim.fn.tabpagenr() then
    --         table.insert(tabs, '[' .. i .. ']')
    --       else
    --         table.insert(tabs, tostring(i))
    --       end
    --     end
    --     return table.concat(tabs, ' ')
    --   end,
    -- })
    -- nougat.set_tabline(tal)
  end,
} 