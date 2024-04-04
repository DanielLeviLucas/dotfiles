return {
  {
    -- https://github.com/numToStr/Comment.nvim
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup({
        ignore = "^$",
        toggler = {
          line = "<leader>cc",
          block = "<leader>bc",
        },
        opleader = {
          line = "<leader>c",
          block = "<leader>b",
        },
      })
    end,
  },
}
