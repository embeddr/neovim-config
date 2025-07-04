-- General options that don't belong in other files
local o = vim.opt

-- Indentation and tabs
o.tabstop = 2                          -- Number of spaces a <tab> is displayed as
o.softtabstop = 2                      -- Number of spaces to move when inserting/removing tabs
o.shiftwidth = 2                       -- Number of spaces to auto-indent (e.g. >>)
o.expandtab = true                     -- Insert spaces instead of a tab?
o.autoindent = true                    -- Maintain indentation on new lines?
o.copyindent = true                    -- Use the existing indentation characters?

-- Line wrap
o.wrap = true                          -- Wrap long lines by default?
o.linebreak = true                     -- Break lines on whitespace word boundaries
o.breakindent = true                   -- Indent wrapped lines to match the original line?
o.breakindentopt = 'sbr'               -- Options for wrapped line indentation (sbr = showbreak)
o.showbreak = '↪>'                     -- Character(s) to display before wrapped lines

-- Searching
-- Note: With both of these set, you can use \c to force a lower-case search
o.ignorecase = true                    -- Ignore the case of provided letters (unless \c appears)?
o.smartcase = true                     -- Ignore the case ONLY if all lower-case?

-- Files and buffers
o.autoread = true                      -- Automatically read files on external change?
o.swapfile = false                     -- Make a swap file when editing?
o.hidden = true                        -- Allow buffers to remain open in the background?

-- Mouse
o.mouse = 'a'                          -- Enable mouse in all modes

-- Note: install xclip (or similar) for local clipboard support
o.clipboard:append('unnamedplus')

-- Offsets
o.cmdheight = 1                        -- Number of extra rows to insert below the command line
o.scrolloff = 5                        -- Minimum number of lines to keep above/below cursor
o.sidescrolloff = 2                    -- Minimum number of columns to keep left/right of the cursor

-- Editor
o.showmode = false                     -- Show Insert/Replace/Visual mode display?
o.number = true                        -- Precede each line with its line number?
o.relativenumber = true                -- Use relative line numbers for all except the selected line
o.numberwidth = 5                      -- Minimum number of columns to use for the line number

-- Netrw
vim.g.netrw_banner = 0                 -- Enable/suppress banner (0 == disable)
vim.g.netrw_liststyle = 3              -- List style (3 == tree)

