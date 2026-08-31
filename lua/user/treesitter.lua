local parsers = {
  "c",
  "cpp",
  "json",
  "lua",
  "python",
  "vim",
  "vimdoc",
}

local max_filesize = 256 * 1024 -- 256 KiB

local ok, ts = pcall(require, "nvim-treesitter")
if not ok then
  vim.notify("failed to load nvim-treesitter", vim.log.levels.ERROR)
  return
end

ts.install(parsers)

local parser_by_filetype = {
  c = true,
  cpp = true,
  json = true,
  lua = true,
  python = true,
  vim = true,
  help = true, -- vimdoc files usually have filetype=help
}

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    if not parser_by_filetype[vim.bo[args.buf].filetype] then
      return
    end

    local file = vim.api.nvim_buf_get_name(args.buf)
    if file ~= "" then
      local stat_ok, stat = pcall(vim.uv.fs_stat, file)
      if stat_ok and stat and stat.size > max_filesize then
        return
      end
    end

    pcall(vim.treesitter.start, args.buf)
  end,
})
