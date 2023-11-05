local root_dir = require("jdtls.setup").find_root({ "packageInfo" }, "Config")
local home = os.getenv("HOME")
local eclipse_workspace = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

local ws_folders_jdtls = {}
if root_dir then
 local file = io.open(root_dir .. "/.bemol/ws_root_folders")
 if file then
  for line in file:lines() do
   table.insert(ws_folders_jdtls, "file://" .. line)
  end
  file:close()
 end
end

local config = {
    settings = {
        java = {
            configuration = {
                runtimes = {
                    {
                        name = "JavaSE-1.8",
                        path = "/Library/Java/JavaVirtualMachines/jdk1.8.0_351.jdk/Contents/Home"
                    },
                    {
                        name = "JavaSE-11",
                        path = "/Library/Java/JavaVirtualMachines/jdk-11.0.17.jdk/Contents/Home"
                    },
                    {
                        name = "JavaSE-17",
                        path = "/Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home"
                    },
                }
            }
        }
    },
    cmd = {
        home .. '/Development/jdtls/jdt-language-server-1.9.0-202203031534/bin/jdtls',
        '--jvm-arg=-javaagent:' .. home .. '/Development/jdtls/lombok.jar',
        '-data', eclipse_workspace,
    },
    root_dir = root_dir,
    init_options = {
        workspaceFolders = ws_folders_jdtls,
    },
}

require('jdtls').start_or_attach(config)

--[[
--        '/Library/Java/JavaVirtualMachines/amazon-corretto-17.jdk/Contents/Home/bin/java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx4g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-jar', home .. '/Development/jdtls/jdt-language-server-1.9.0-202203031534/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
        '-configuration', home .. '/Development/jdtls/jdt-language-server-1.9.0-202203031534/config_mac',
        '--jvm-arg=-javaagent:' .. home .. '/Development/jdtls/lombok.jar',
        '-data', eclipse_workspace,

--
--]]
