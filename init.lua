-- ~/.config/nvim/lua/custom/typewriter/init.lua

local api = vim.api

-- Variable to track if typewriter mode is active
local typewriter_active = false

-- Function to center the cursor on the screen
local function center_cursor()
  -- Check if typewriter mode is active; if not, exit the function
  if not typewriter_active then
    return
  end

  -- Get the height of the current window
  local win_height = api.nvim_win_get_height(0)
  -- Get the current cursor position
  local cursor = api.nvim_win_get_cursor(0)

  -- Calculate the new row position to center the cursor vertically
  local new_row = math.floor(win_height / 2)
  -- Keep the current column position
  local new_col = cursor[2]

  -- Set the cursor to the new position
  api.nvim_win_set_cursor(0, { new_row, new_col })
  -- Center the cursor line in the window
  api.nvim_command 'normal! zz'
end

-- Function to enable typewriter mode
local function enable_typewriter_mode()
  -- Check if typewriter mode is not already active
  if not typewriter_active then
    -- Set typewriter mode to active
    typewriter_active = true
    -- Add an autocommand to center the cursor on CursorMoved event
    api.nvim_command 'autocmd CursorMoved * lua require("typewriter").center_cursor()'
    -- Print a message to notify the user
    print 'Typewriter mode enabled'
  end
end

-- Function to disable typewriter mode
local function disable_typewriter_mode()
  -- Check if typewriter mode is active
  if typewriter_active then
    -- Set typewriter mode to inactive
    typewriter_active = false
    -- Remove the autocommand for CursorMoved event
    api.nvim_command 'autocmd! TypewriterMode'
    -- Print a message to notify the user
    print 'Typewriter mode disabled'
  end
end

-- Function to toggle typewriter mode
local function toggle_typewriter_mode()
  -- If typewriter mode is active, disable it; otherwise, enable it
  if typewriter_active then
    disable_typewriter_mode()
  else
    enable_typewriter_mode()
  end
end

-- Function to set up the typewriter mode commands and autocommands
local function setup()
  -- Create an autocommand group named TypewriterMode
  api.nvim_command 'augroup TypewriterMode'
  -- Clear any existing autocommands in the group
  api.nvim_command 'autocmd!'
  -- End the autocommand group definition
  api.nvim_command 'augroup END'

  -- Create user commands to enable, disable, and toggle typewriter mode
  api.nvim_create_user_command('EnableTypewriter', enable_typewriter_mode, {})
  api.nvim_create_user_command('DisableTypewriter', disable_typewriter_mode, {})
  api.nvim_create_user_command('ToggleTypewriter', toggle_typewriter_mode, {})
end

-- Return the setup and mode control functions for use in Neovim configuration
return {
  setup = setup,
  center_cursor = center_cursor,
  enable = enable_typewriter_mode,
  disable = disable_typewriter_mode,
  toggle = toggle_typewriter_mode,
}
