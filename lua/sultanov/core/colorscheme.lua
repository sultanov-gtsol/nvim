local status, _ = pcall(vim.cmd, "colorscheme nightfly")
if not status then
    pring("Colorscheme not found")
    return
end
