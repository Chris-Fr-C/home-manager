return {
  "letieu/jira.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  opts = {
    jira = {
      base = "https://your-domain.atlassian.net",
      email = "your-email@example.com",
      token = "your-api-token",
      type = "basic",
      limit = 200,
    },
  },

  keys = {
    {
      "<leader>jb",
      function()
        local pickers = require("telescope.pickers")
        local finders = require("telescope.finders")
        local conf = require("telescope.config").values
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")

        local env = vim.env.JIRA_BOARDS
        if not env or env == "" then
          vim.notify("JIRA_BOARDS env variable is not set", vim.log.levels.WARN)
          return
        end

        local boards = {}
        for board in env:gmatch("([^,]+)") do
          board = vim.trim(board)
          if board ~= "" then
            table.insert(boards, board)
          end
        end

        if #boards == 0 then
          return
        end

        pickers
          .new({}, {
            prompt_title = "Jira Boards",
            finder = finders.new_table({
              results = boards,
            }),
            sorter = conf.generic_sorter({}),
            attach_mappings = function(prompt_bufnr)
              actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                if not selection then
                  return
                end

                require("jira").open(selection.value)
              end)
              return true
            end,
          })
          :find()
      end,
      desc = "Jira: Pick board",
    },
  },
}
