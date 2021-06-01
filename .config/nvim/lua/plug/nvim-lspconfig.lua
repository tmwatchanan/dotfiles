--Show function signature
local function on_attach(client)
    local cfg = {
        use_lspsaga = false,
    }
    require'lsp_signature'.on_attach(cfg)
end

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true


--[[ Python -------------------------------------------------------------------
npm install -g pyright
--]]
require'lspconfig'.pyright.setup {
    on_attach = on_attach,
}

--[[ Lua ----------------------------------------------------------------------
sudo apt install -y ninja-build
cd /tmp
git clone https://github.com/sumneko/lua-language-server
cd lua-language-server
git submodule update --init --recursive
cd 3rd/luamake
compile/install.sh
cd ../..
./3rd/luamake/luamake rebuild
--]]
require'lspconfig'.sumneko_lua.setup {
    on_attach = on_attach,
}

--[[ HTML ---------------------------------------------------------------------
npm install -g vscode-html-languageserver-bin
--]]
require'lspconfig'.html.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

--[[ CSS ----------------------------------------------------------------------
npm install -g vscode-css-languageserver-bin
--]]
require'lspconfig'.cssls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

--[[ TypeScript/JavaScript ----------------------------------------------------
npm install -g typescript typescript-language-server
--]]
require'lspconfig'.tsserver.setup {
    on_attach = on_attach,
}

--[[ JSON ---------------------------------------------------------------------
npm install -g vscode-json-languageserver
--]]
require'lspconfig'.jsonls.setup {
    on_attach = on_attach,
}

--[[ YAML ---------------------------------------------------------------------
npm install -g yaml-language-server
]]
require'lspconfig'.yamlls.setup {
    on_attach = on_attach,
}

--[[ SQL ----------------------------------------------------------------------
go get github.com/lighttiger2505/sqls
--]]
require'lspconfig'.sqls.setup {
    on_attach = on_attach,
}

--[[ Docker -------------------------------------------------------------------
npm install -g dockerfile-language-server-nodejs
--]]
require'lspconfig'.dockerls.setup {
    on_attach = on_attach,
}
