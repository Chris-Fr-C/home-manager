return { {
  "neovim/nvim-lspconfig",
  config = function()
    require "configs.lspconfig"
  end,
},

  -- C++
  --
  {
    "civitasv/cmake-tools.nvim",

    config = function()
      require("cmake-tools").setup({
        cmake_generate_options = {
          "-DCMAKE_EXPORT_COMPILE_COMMANDS=1",
        },
      })
    end

  },
}
