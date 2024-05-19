return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    autocmds = {
      -- disable alpha autostart
      alpha_autostart = false,
      restore_session = {
        {
          event = "VimEnter",
          desc = "Restore previous directory session if neovim opened with no arguments",
          nested = true, -- trigger other autocommands as buffers open
          callback = function()

            local astrocore = require('astrocore')

            -- Function to check if a path is a directory
            local function is_directory(path)
              local stat = vim.loop.fs_stat(path)
              return stat and stat.type == "directory"
            end

            -- Determine if we should try to load the first 
            -- arg to nvim since its a directory, or if we
            -- had no args, using the current directory.
            local args = vim.fn.argv()
            local folder_to_load = nil
            if #args > 0 then
              local first_arg = vim.loop.fs_realpath(args[1])
              if is_directory(first_arg) then
                -- Use an absolute path so the correct session gets loaded.
                folder_to_load = first_arg
                -- folder_to_load = vim.fn.fnamemodify(first_arg, ":p")
                -- Make sure it doesn't end with a `/`
                if folder_to_load:sub(-1) == "/" then
                  folder_to_load = folder_to_load:sub(1, -2)
                end
              end
            else
              folder_to_load = vim.fn.getcwd()
            end

            -- Only load the session if nvim was started with no args
            if folder_to_load ~= nil then

              astrocore.notify("Loading session for " .. folder_to_load)

              -- try to load a directory session
              require("resession").load(
                folder_to_load,
                { dir = "dirsession", silence_errors = true }
              )
            end
          end,
        },
      },
    },
  },
}
