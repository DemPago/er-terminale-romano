-- =============================================================================
-- Er Terminale Romano — Neovim Integration
-- File: editors/neovim/opencode.lua
--
-- ISTRUZIONI:
--   Opzione A (file dedicato, consigliata):
--     cp editors/neovim/opencode.lua ~/.config/nvim/lua/opencode-romano.lua
--     Poi aggiungi in init.lua:  require('opencode-romano')
--
--   Opzione B (append diretto):
--     cat editors/neovim/opencode.lua >> ~/.config/nvim/init.lua
--
-- Prerequisiti:
--   - OpenCode CLI installato: https://opencode.ai
--   - Modello 'romano' creato: ollama create romano -f ./Modelfile
-- =============================================================================

local M = {}

-- =============================================================================
-- Configurazione
-- =============================================================================
local config = {
  model   = 'ollama/romano',
  command = 'opencode',
  -- Istruzioni inviate ad OpenCode (override locale)
  instructions = 'Rispondi sempre in dialetto romanesco verace. Vai dritto al punto.',
}

-- =============================================================================
-- Helpers
-- =============================================================================

--- Verifica se OpenCode CLI è disponibile nel PATH
local function opencode_available()
  return vim.fn.executable(config.command) == 1
end

--- Costruisce il comando da eseguire nel terminale
local function build_cmd()
  return string.format('%s --model %s', config.command, config.model)
end

-- =============================================================================
-- Keybindings
-- <leader>or  → split verticale   (pannello laterale)
-- <leader>oR  → split orizzontale (pannello sotto)
-- <leader>oo  → tab dedicata
-- =============================================================================
local function setup_keymaps()
  local opts = { noremap = true, silent = true }

  -- Split verticale (classico: editor a sinistra, AI a destra)
  vim.keymap.set('n', '<leader>or', function()
    if not opencode_available() then
      vim.notify('opencode non trovato nel PATH', vim.log.levels.ERROR)
      return
    end
    vim.cmd('vsplit | terminal ' .. build_cmd())
    vim.cmd('startinsert')
  end, vim.tbl_extend('force', opts, {
    desc = '[Romano] Apre OpenCode in split verticale',
  }))

  -- Split orizzontale (terminale sotto il codice)
  vim.keymap.set('n', '<leader>oR', function()
    if not opencode_available() then
      vim.notify('opencode non trovato nel PATH', vim.log.levels.ERROR)
      return
    end
    vim.cmd('split | terminal ' .. build_cmd())
    vim.cmd('startinsert')
  end, vim.tbl_extend('force', opts, {
    desc = '[Romano] Apre OpenCode in split orizzontale',
  }))

  -- Tab dedicata
  vim.keymap.set('n', '<leader>oo', function()
    if not opencode_available() then
      vim.notify('opencode non trovato nel PATH', vim.log.levels.ERROR)
      return
    end
    vim.cmd('tabnew | terminal ' .. build_cmd())
    vim.cmd('startinsert')
  end, vim.tbl_extend('force', opts, {
    desc = '[Romano] Apre OpenCode in nuova tab',
  }))
end

-- =============================================================================
-- Comando :RomanoSetup
-- Crea opencode.json nella CWD se non esiste già
-- =============================================================================
local function setup_commands()
  vim.api.nvim_create_user_command('RomanoSetup', function()
    local cwd         = vim.fn.getcwd()
    local config_path = cwd .. '/opencode.json'

    if vim.fn.filereadable(config_path) == 1 then
      vim.notify(
        'opencode.json già presente: ' .. config_path,
        vim.log.levels.WARN
      )
      return
    end

    local content = string.format(
      '{\n  "$schema": "https://opencode.ai/config.json",\n' ..
      '  "model": "%s",\n' ..
      '  "instructions": "%s"\n}\n',
      config.model,
      config.instructions
    )

    local f = io.open(config_path, 'w')
    if f then
      f:write(content)
      f:close()
      vim.notify('opencode.json creato in ' .. cwd .. ' — Daje! 🤌', vim.log.levels.INFO)
    else
      vim.notify('Errore: impossibile scrivere ' .. config_path, vim.log.levels.ERROR)
    end
  end, {
    desc = '[Romano] Crea opencode.json con er modello romano nel progetto corrente',
  })
end

-- =============================================================================
-- Funzione statusline (opzionale)
-- Restituisce "🤌 romano" se opencode.json nel progetto usa er modello romano
-- Uso con lualine: { romano_active_status }
-- =============================================================================
function M.status()
  local config_path = vim.fn.getcwd() .. '/opencode.json'
  if vim.fn.filereadable(config_path) ~= 1 then return '' end

  local ok, raw = pcall(vim.fn.readfile, config_path)
  if not ok then return '' end

  local ok2, data = pcall(vim.fn.json_decode, table.concat(raw, '\n'))
  if ok2 and data and type(data.model) == 'string' and data.model:find('romano') then
    return '🤌 romano'
  end
  return ''
end

-- =============================================================================
-- Setup principale
-- =============================================================================
function M.setup(opts)
  config = vim.tbl_deep_extend('force', config, opts or {})
  setup_keymaps()
  setup_commands()
end

-- Auto-setup con configurazione di default se il file è richiesto direttamente
M.setup()

return M
