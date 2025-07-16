local M = {}

M.diagnostics = {
  Error = " ",
  Warn = " ",
  Hint = "󰌵 ",
  Info = " ",
}

M.git = {
  added = " ",
  modified = " ",
  removed = " ",
  renamed = "󰁕 ",
  untracked = "󰞋 ",
  ignored = " ",
  unstaged = "󰄱 ",
  staged = " ",
  conflict = " ",
  branch = " ",
}

M.kinds = {
  Array = " ",
  Boolean = "󰨙 ",
  Class = " ",
  Constant = "󰏿 ",
  Constructor = " ",
  Enum = " ",
  EnumMember = " ",
  Event = " ",
  Field = " ",
  File = "󰈙 ",
  Function = "󰊕 ",
  Interface = " ",
  Key = "󰌋 ",
  Keyword = "󰌋 ",
  Method = "󰆧 ",
  Module = " ",
  Namespace = "󰌗 ",
  Null = "󰟢 ",
  Number = "󰎠 ",
  Object = "󰅩 ",
  Operator = "󰆕 ",
  Package = " ",
  Property = " ",
  Reference = "󰈇 ",
  Snippet = " ",
  String = "󰀬 ",
  Struct = "󰙅 ",
  Text = " ",
  TypeParameter = "󰊄 ",
  Unit = " ",
  Value = "󰎠 ",
  Variable = "󰀫 ",
}

return M 