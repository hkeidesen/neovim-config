---@param config {args?:string[]|fun():string[]?}
local function get_args(config)
  local args = type(config.args) == 'function' and (config.args() or {}) or config.args or {}
  config = vim.deepcopy(config)
  ---@cast args string[]
  config.args = function()
    local new_args = vim.fn.input('Run with args: ', table.concat(args, ' ')) --[[@as string]]
    return vim.split(vim.fn.expand(new_args) --[[@as string]], ' ')
  end
  return config
end

return {
  {
    'mfussenegger/nvim-dap',

    dependencies = {

      -- fancy UI for the debugger
      {
        'rcarriga/nvim-dap-ui',
        dependencies = { 'nvim-neotest/nvim-nio' },
        keys = {
          {
            '<leader>du',
            function()
              require('dapui').toggle({})
            end,
            desc = 'Dap UI',
          },
          {
            '<leader>de',
            function()
              require('dapui').eval()
            end,
            desc = 'Eval',
            mode = { 'n', 'v' },
          },
        },
        opts = {},
        config = function(_, opts)
          -- setup dap config by VsCode launch.json file
          -- require("dap.ext.vscode").load_launchjs()
          local dap = require('dap')
          local dapui = require('dapui')
          dapui.setup(opts)
          dap.listeners.after.event_initialized['dapui_config'] = function()
            dapui.open({})
          end
          dap.listeners.before.event_terminated['dapui_config'] = function()
            dapui.close({})
          end
          dap.listeners.before.event_exited['dapui_config'] = function()
            dapui.close({})
          end
        end,
      },

      -- virtual text for the debugger
      {
        'theHamsta/nvim-dap-virtual-text',
        opts = {},
      },

      -- mason.nvim integration
      {
        'jay-babu/mason-nvim-dap.nvim',
        dependencies = 'mason.nvim',
        cmd = { 'DapInstall', 'DapUninstall' },
        opts = {
          -- Makes a best effort to setup the various debuggers with
          -- reasonable debug configurations
          automatic_installation = true,

          -- You can provide additional configuration to the handlers,
          -- see mason-nvim-dap README for more information
          handlers = {},

          -- You'll need to check that you have the required things installed
          -- online, please don't ask me how to install them :)
          ensure_installed = {
            -- Update this to ensure that you have the debuggers for the langs you want
          },
        },
      },
    },

    keys = {
      {
        '<leader>dB',
        function()
          require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
        end,
        desc = 'Breakpoint Condition',
      },
      {
        '<leader>db',
        function()
          require('dap').toggle_breakpoint()
        end,
        desc = 'Toggle Breakpoint',
      },
      {
        '<leader>dc',
        function()
          require('dap').continue()
        end,
        desc = 'Continue',
      },
      {
        '<leader>da',
        function()
          require('dap').continue({ before = get_args })
        end,
        desc = 'Run with Args',
      },
      {
        '<leader>dC',
        function()
          require('dap').run_to_cursor()
        end,
        desc = 'Run to Cursor',
      },
      {
        '<leader>dg',
        function()
          require('dap').goto_()
        end,
        desc = 'Go to line (no execute)',
      },
      {
        '<leader>di',
        function()
          require('dap').step_into()
        end,
        desc = 'Step Into',
      },
      {
        '<leader>dj',
        function()
          require('dap').down()
        end,
        desc = 'Down',
      },
      {
        '<leader>dk',
        function()
          require('dap').up()
        end,
        desc = 'Up',
      },
      {
        '<leader>dl',
        function()
          require('dap').run_last()
        end,
        desc = 'Run Last',
      },
      {
        '<leader>do',
        function()
          require('dap').step_out()
        end,
        desc = 'Step Out',
      },
      {
        '<leader>dO',
        function()
          require('dap').step_over()
        end,
        desc = 'Step Over',
      },
      {
        '<leader>dp',
        function()
          require('dap').pause()
        end,
        desc = 'Pause',
      },
      {
        '<leader>dr',
        function()
          require('dap').repl.toggle()
        end,
        desc = 'Toggle REPL',
      },
      {
        '<leader>ds',
        function()
          require('dap').session()
        end,
        desc = 'Session',
      },
      {
        '<leader>dt',
        function()
          require('dap').terminate()
        end,
        desc = 'Terminate',
      },
      {
        '<leader>dw',
        function()
          require('dap.ui.widgets').hover()
        end,
        desc = 'Widgets',
      },
    },

    config = function()
      local icons = require('ergou.util.icons')
      vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })

      for name, sign in pairs(icons.dap) do
        sign = type(sign) == 'table' and sign or { sign }
        vim.fn.sign_define(
          'Dap' .. name,
          { text = sign[1], texthl = sign[2] or 'DiagnosticInfo', linehl = sign[3], numhl = sign[3] }
        )
      end
    end,
  },
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      {
        'jbyuki/one-small-step-for-vimkind',
        config = function()
          local dap = require('dap')
          dap.adapters.nlua = function(callback, conf)
            local adapter = {
              type = 'server',
              host = conf.host or '127.0.0.1',
              port = conf.port or 8086,
            }
            if conf.start_neovim then
              local dap_run = dap.run
              dap.run = function(c)
                adapter.port = c.port
                adapter.host = c.host
              end
              require('osv').run_this()
              dap.run = dap_run
            end
            callback(adapter)
          end
          dap.configurations.lua = {
            {
              type = 'nlua',
              request = 'attach',
              name = 'Run this file',
              start_neovim = {},
            },
            {
              type = 'nlua',
              request = 'attach',
              name = 'Attach to running Neovim instance (port = 8086)',
              port = 8086,
            },
          }
        end,
      },
    },
  },
}