vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'romgrk/barbar.nvim'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use 'hrsh7th/cmp-path'
    use 'nvim-lua/lsp-status.nvim'
    use 'glepnir/lspsaga.nvim'
    use 'nvim-lualine/lualine.nvim'
    use 'williamboman/mason.nvim'
    use 'savq/melange-nvim'
    use 'neovim/nvim-lspconfig'
    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-tree/nvim-web-devicons'
    use 'nvim-lua/plenary.nvim'
    use 'simrat39/rust-tools.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'tpope/vim-commentary'
    use 'tpope/vim-surround'
    use 'hrsh7th/vim-vsnip'
    use 'm-demare/hlargs.nvim'
    use 'lewis6991/impatient.nvim'
    use 'j-hui/fidget.nvim'
    use 'phaazon/hop.nvim'
    use 'folke/trouble.nvim'
    use 'stevearc/dressing.nvim'
    use 'ziontee113/icon-picker.nvim'
    use 'tpope/vim-sleuth'
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use { 'zbirenbaum/copilot.lua' }

    use {
        'williamboman/mason-lspconfig.nvim',
        requires = {
            'williamboman/mason.nvim',
            'neovim/nvim-lspconfig'
        }
    }
    use {
        'zbirenbaum/copilot.lua',
        cmd = 'Copilot',
        event = 'InsertEnter',
    }
end)

require('impatient')

require('nvim-web-devicons').setup {
    color_icons = true,
    default = true,
}

require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_d = { "require'lsp-status'.status()" },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_d = {},
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}

local cmp = require('cmp')
cmp.setup({
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        -- ['<Space>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item()
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'nvim_lua' },
        { name = 'path' },
        { name = 'buffer' },
        { name = 'calc' },
    }),
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        end,
    },
    formatting = {
        format = function(_, item)
            local kind_icons = {
                File          = " File",
                Module        = " Module",
                Package       = " Package",
                Class         = " Class",
                Method        = " Method",
                Property      = " Property",
                Field         = " Field",
                Constructor   = " Constructor",
                Enum          = " Enum",
                Interface     = " Interface",
                Function      = " Function",
                Variable      = " Variable",
                Constant      = " Constant",
                String        = " String",
                Number        = " Number",
                Boolean       = " Boolean",
                Array         = " Array",
                Object        = " Object",
                Key           = " Key",
                Null          = " Null",
                EnumMember    = " Enum Member",
                Event         = " Event",
                Operator      = " Operator",
                TypeParameter = " Type Param",
                TypeAlias     = " Type Alias",
                Parameter     = " Parameter",
                Macro         = " Macro",
            }
            item.kind = kind_icons[item.kind]
            return item
        end,
    },
})
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, { {
        name = 'cmdline',
        option = {
            ignore_cmds = { 'Man', '!' }
        }
    } })
})

require('mason').setup()
require('mason-lspconfig').setup {
    automatic_installation = true,
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lsp_status = require('lsp-status')
lsp_status.register_progress()

require("mason-lspconfig").setup_handlers {
    function(server_name)
        if server_name == 'sumneko_lua' then
            require('lspconfig')[server_name].setup {
                settings = {
                    Lua = {
                        runtime = { version = 'LuaJIT' },
                        diagnostics = { globals = { 'vim' } },
                        workspace = {
                            -- Make the server aware of Neovim runtime files
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                        -- Do not send telemetry data containing a randomized but unique identifier
                        telemetry = { enable = false },
                    }
                }
            }
        else
            require('lspconfig')[server_name].setup {
                capabilities = vim.tbl_extend('keep', capabilities, lsp_status.capabilities),
                on_attach = lsp_status.on_attach
            }
        end
    end
}

vim.diagnostic.config({
    virtual_text = {
        prefix = '',
        severity = vim.diagnostic.severity.HINT
    },
    signs = true,
    underline = true,
    update_in_insert = true,
    severity_sort = true
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "lua", "rust", "toml", "vim", "markdown", "markdown_inline" },
    auto_install = true,
    highlight = {
        enable = true
    },
    ident = { enable = true },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
    }
}

local rt = require("rust-tools")
rt.setup({
    tools = {
        runnables = {
            use_telescope = true,
        },
        inlay_hints = {
            auto = true,
            only_current_line = false,
            show_parameter_hints = true,
            parameter_hints_prefix = " ",
            other_hints_prefix = " ",
            reload_workspace_from_cargo_toml = true
        },
    },
    server = {
        on_attach = function(_, _)
        end,
        settings = {
            ["rust-analyzer"] = {
                inlayHints = true,
                cargo = {
                    buildScripts = {
                        enable = true,
                    },
                },
                procMacro = {
                    enable = true,
                },
                checkOnSave = {
                    features = "all",
                    command = "check",
                },
            }
        }
    }
})
rt.inlay_hints.other_hints_prefix = " "
rt.inlay_hints.parameter_hints_prefix = " "

require('telescope').load_extension('fzf')
require('telescope').setup {
    defaults = {
        color_devicons = false,
        layout_config = {
            width = 0.7,
            horizontal = {
                preview_width = 0.6
            }
        }
    },
    pickers = {
        buffers = {
            ignore_current_buffer = true,
            sort_mru = true,
        },
    },
}

require('telescope.builtin')


require('lspsaga').setup({
    ui = {
        border = 'rounded',
        code_action = '',
    }
    -- code_action_icon = "",
    -- diagnostic_header = { " ", " ", " ", "ﴞ " },
})

require 'bufferline'.setup {
    animation = true,
    auto_hide = true,
    tabpages = true,
    closable = true,
    clickable = true,
    icons = {
        filetype = { enable = true },
        modified = { button = '●' },
        pinned = { button = '車' },
        separator = {
            left = '▎',
        },
        inactive = {
            separator = {
                left = '▎',
            }
        },
        button = '',
    },
}

require("trouble").setup {
    position = "right",
    auto_open = false,
    auto_close = true,
    auto_preview = true,
    use_diagnostic_signs = true,
    mode = "workspace_diagnostics",
    action_keys = {
        jump = { "<cr>", "<tap>", "<space>" },
    }
}

vim.opt.updatetime = 120
vim.wo.signcolumn = "yes"

-- Show diagnostic popup on cursor hover
local diag_float_grp = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true })
vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        vim.diagnostic.open_float(nil, { focusable = false })
    end,
    group = diag_float_grp,
})

require "fidget".setup {}

local hop = require('hop')
local hop_perm = require('hop.perm')
hop.setup()

local function make_me_hop(multi_window)
    hop.hint_words({
        perm_method = hop_perm.TrieBacktrackFilling,
        multi_windows = multi_window
    })
end

vim.keymap.set({ 'n', 'v' }, 'N', function() make_me_hop(false) end, { remap = false })
vim.keymap.set({ 'n', 'v' }, '<C-n>', function() make_me_hop(true) end, { remap = false })

vim.keymap.set({ 'v' }, 'R', function()
    local restore = vim.fn.getreg('a')
    vim.cmd('normal! "ay')
    local text = vim.fn.escape(vim.fn.getreg('a'), '^/\\.*[]~$')
    local idx, _ = text:find('\n', 1, true)
    if idx ~= nil then text = text:sub(1, idx - 1) end
    vim.api.nvim_input('<esc>:%s/' .. text .. '/')
    vim.fn.setreg('a', restore)
end, { remap = true })

require('hlargs').setup()

require('dressing').setup({})
require('icon-picker').setup({
    disable_legacy_commands = true
})


require('copilot').setup({
    panel = {
        enabled = true,
        auto_refresh = false,
        keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>"
        },
        layout = {
            position = "bottom", -- | top | left | right
            ratio = 0.4
        },
    },
    suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
            accept = "<M-t>",
            accept_word = false,
            accept_line = false,
            next = "<M-h>",
            prev = "<M-g>",
            dismiss = "<C-g>",
        },
    },
    filetypes = {
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,
    },
    copilot_node_command = 'node', -- Node.js version must be > 16.x
    server_opts_overrides = {},
})
