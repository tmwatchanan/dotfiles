# Zed

## References

Useful Zed Hidden Gems references to revisit before changing
`.config/zed/tasks.json`, `.config/zed/keymap.json`, or related editor workflow
config:

- [Hidden Gems: Part 1 - Lazygit as a Task](https://zed.dev/blog/hidden-gems-part-1#lazygit-as-a-task)
- [Hidden Gems: Part 2 - Emulate Vim's Telescope via Television](https://zed.dev/blog/hidden-gems-part-2#emulate-vims-telescope-via-television)
- [Hidden Gems: Community Edition](https://github.com/zed-industries/zed/discussions/39680)

Stow note: this file lives under `docs/`, which `.stow-local-ignore` excludes
from the symlink farm.

## OS-Specific Keybindings

Zed keymap contexts can include OS checks, for example:

- `Workspace && os == macos`
- `Workspace && os == windows`
- `Workspace && os == linux`

Use these to keep macOS bindings on `cmd-*` while Windows and Linux use
`secondary-*`, which maps to the platform's primary shortcut modifier.

## Windows Sync

Zed stores user config on Windows in `%APPDATA%\Zed`, including:

- `%APPDATA%\Zed\settings.json`
- `%APPDATA%\Zed\keymap.json`
- `%APPDATA%\Zed\tasks.json`

Prefer linking these files individually to `D:\dev\dotfiles\.config\zed\...`
instead of linking the whole `%APPDATA%\Zed` directory. The AppData directory
can contain local Zed data that should not necessarily be synced.

If file symlink creation fails without Administrator privileges, use a directory
junction instead:

```cmd
move "%APPDATA%\Zed" "%APPDATA%\Zed.backup"
mklink /J "%APPDATA%\Zed" "D:\dev\dotfiles\.config\zed"
```
