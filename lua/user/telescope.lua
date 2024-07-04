-- Telescope setup and configuration
local telescope = require'telescope'
local actions = require'telescope.actions'
local fb_actions = telescope.extensions.file_browser.actions

telescope.setup {
 defaults = {
   mappings = {
     i = {
       -- Send selection (or everything, if no selection) to quickfix list and open it
       ['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
       ['<C-j>'] = actions.move_selection_next,
       ['<C-k>'] = actions.move_selection_previous,
     }
   }
 },
 extensions = {
   file_browser = {
     initial_mode = "normal",
     mappings = {
       -- Normal mode mappings
       ["n"] = {
         -- Navigation
         ["h"] = fb_actions.goto_parent_dir,
         ["l"] = actions.select_default,
         ["q"] = actions.close,
         -- Visibility
         ["v"] = fb_actions.toggle_hidden,
         -- Selection
         ["s"] = actions.toggle_selection,
         -- Manipulation
         ["c"] = fb_actions.copy,
         ["x"] = fb_actions.move,
         ["d"] = fb_actions.remove,
         ["n"] = fb_actions.create,
       }
     }
   }
 }
}

-- Note this must be called after the setup function
telescope.load_extension "file_browser"

-- Open file browser at current buffer directory 
vim.keymap.set('n', '<leader>v', ":Telescope file_browser path=%:p:h select_buffer=true<CR> --hidden")
-- Open file browser at current working directory
vim.keymap.set('n', '<leader>V', ":Telescope file_browser<CR> --hidden")

-- General Telescope keymappings
local builtin = require'telescope.builtin'
vim.keymap.set('n', '<leader>f', builtin.git_files, {})
vim.keymap.set('n', '<leader>F', builtin.find_files, {})
vim.keymap.set('n', '<leader>g', builtin.live_grep, {})

