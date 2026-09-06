local containers = require("custom.config.keymap-containers")

vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/epwalsh/obsidian.nvim",
})

-- 2. Setup obsidian.nvim
local obsidian = require("obsidian")

obsidian.setup({
  legacy_commands = false,
  workspaces = {
    {
      name = "personal",
      path = vim.fn.expand("~/vaults/personal"),
    },
    {
      name = "work",
      path = vim.fn.expand("~/vaults/work"),
    },
  },
  picker = {
    name = "fzf-lua",
    note_mappings = {
      new = "<C-x>",
      insert_link = "<C-l>",
    },
    tag_mappings = {
      tag_note = "<C-o>",
      insert_tag = "<C-g>",
    },
  },
  daily_notes = {
    folder = "dailies",
    date_format = "%Y-%m-%d",
    alias_format = "%B %d, %Y",
    template = "daily.md",
  },
  note_id_func = function(title)
    local suffix = ""
    if title ~= nil then
      suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
    else
      for _ = 1, 4 do
        suffix = suffix .. string.char(math.random(65, 90)):lower()
      end
    end
    return tostring(os.time()) .. "-" .. suffix
  end,
  frontmatter = {
    func = function(note)
      if note.title then
        note:add_alias(note.title)
      end

      local out = { id = note.id, aliases = note.aliases, tags = note.tags }

      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end

      return out
    end,
  },
  templates = {
    folder = "templates",
    date_format = "%Y-%m-%d",
    time_format = "%H:%M",
  },
})

-- 3. Keymaps
local map = vim.keymap.set
local opts = { noremap = true, silent = true, desc = "Obsidian: " }

map("n", containers.obsidian.key .. "n", "<cmd>Obsidian new<cr>", { desc = opts.desc .. "New Note" })
map("n", containers.obsidian.key .. "o", "<cmd>Obsidian quick_switch<cr>", { desc = opts.desc .. "Quick Switcher" })
map("n", containers.obsidian.key .. "s", "<cmd>Obsidian search<cr>", { desc = opts.desc .. "Search Vault" })
map("n", containers.obsidian.key .. "t", "<cmd>Obsidian template<cr>", { desc = opts.desc .. "Insert Template" })
map("n", containers.obsidian.key .. "d", "<cmd>Obsidian today<cr>", { desc = opts.desc .. "Today's Daily Note" })
map("n", containers.obsidian.key .. "b", "<cmd>Obsidian backlinks<cr>", { desc = opts.desc .. "Show Backlinks" })
map("n", containers.obsidian.key .. "l", "<cmd>Obsidian links<cr>", { desc = opts.desc .. "Show Links" })
map("n", containers.obsidian.key .. "g", "<cmd>Obsidian tags<cr>", { desc = opts.desc .. "Search Tags" })
