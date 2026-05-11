return { 

-- Already in the init but just to be sure.
  {
  "neovim/nvim-lspconfig",
  lazy = false,
},

  -- C++
  --
  {
    "civitasv/cmake-tools.nvim",
    ft = { "cpp", "c", "objc", "objcpp", "cuda", "proto" },
    config = function()
      require("cmake-tools").setup({
        cmake_generate_options = {
          "-DCMAKE_EXPORT_COMPILE_COMMANDS=1",
        },
      })
    end

  },
}
