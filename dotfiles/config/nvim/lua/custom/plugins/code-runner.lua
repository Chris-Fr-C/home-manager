local containers = require("custom.config.keymap-containers")
vim.pack.add({"https://github.com/CRAG666/code_runner.nvim"})

require("code_runner").setup(
  {
    filetype={
      python="uv run",
      rust = {
        "cd $dir &&",
        "rustc $fileName &&",
        "$dir/$fileNameWithoutExt"
      },
    }
  }
)

vim.keymap.set("n", containers.execute.key .. "f", "", {desc="[f]ile"})
vim.keymap.set("n", containers.execute.key .. "p", "", {desc="[p]roject"})



return {}
