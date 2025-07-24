local java_version = "21" -- Adjust this to your installed Java version

-- FIND AND ADJUST ALL THE 'TODOS' BELOW

-- JDTLS (Java LSP) configuration
local home = vim.env.HOME -- Get the home directory

local jdtls = require("jdtls")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = home .. "/jdtls-workspace/" .. project_name

local system_os = ""

-- Determine OS
if vim.fn.has("mac") == 1 then
	system_os = "mac"
elseif vim.fn.has("unix") == 1 then
	system_os = "linux"
elseif vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
	system_os = "win"
	vim.opt.shellslash = false -- Enable shellslash for Windows compatibility
	vim.defer_fn(function()
		vim.opt.shellslash = false
	end, 5000)
else
	print("OS not found, defaulting to 'linux'")
	system_os = "linux"
end

-- unix paths
-- local java_test_path = home .. "\\AppData\\Local\\nvim-data\\mason\\share\\java-test\\*.jar"
-- local java_bundles_path = home .. "/.local/share/nvim/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar"
-- local java_agent_path = home .. "/.local/share/nvim/mason/share/jdtls/lombok.jar"
-- local java_equinox_path = home .. "/.local/share/nvim/mason/share/jdtls/plugins/org.eclipse.equinox.launcher.jar"
-- local java_config_path = home .. "/.local/share/nvim/mason/packages/jdtls/config_" .. system_os

-- windows paths
local java_test_path = home .. "/.local/share/nvim/mason/share/java-test/*.jar"
local java_bundles_path = home
	.. "\\AppData\\Local\\nvim-data\\mason\\share\\java-debug-adapter\\com.microsoft.java.debug.plugin.jar"
local java_agent_path = home .. "\\AppData\\Local\\nvim-data\\mason\\share\\jdtls\\lombok.jar"
local java_equinox_path = home
	.. "\\AppData\\Local\\nvim-data\\mason\\share\\jdtls\\plugins\\org.eclipse.equinox.launcher.jar"
local java_config_path = home .. "\\AppData\\Local\\nvim-data\\mason\\packages\\jdtls\\config_" .. system_os
-- Check vscode-java-test installation in junit testing. Install it and move it to extensions folder
-- like below
local java_vscode_test_path = home .. "\\.vscode\\extensions\\vscode-java-test\\server\\*.jar"

-- Needed for debugging
local bundles = {
	vim.fn.glob(java_bundles_path),
}
-- Needed for running/debugging unit tests
vim.list_extend(bundles, vim.split(vim.fn.glob(java_vscode_test_path, 1), "\n"))
vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_path, 1), "\n"))

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
	-- The command that starts the language server
	-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
	cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-javaagent:" .. java_agent_path,
		"-Xmx4g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		-- Eclipse jdtls location
		"-jar",
		-- select jar path based on OS
		java_equinox_path,
		"-configuration",
		java_config_path,
		"-data",
		workspace_dir,
	},

	-- This is the default if not provided, you can remove it. Or adjust as needed.
	-- One dedicated LSP server & client will be started per unique root_dir
	root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "pom.xml", "build.gradle" }),

	-- Here you can configure eclipse.jdt.ls specific settings
	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	settings = {
		java = {
			-- TODO Replace this with the absolute path to your main java version (JDTLS requires JDK 21 or higher)
			home = "C:\\Program Files\\Java\\jdk-" .. java_version,
			eclipse = {
				downloadSources = true,
			},
			configuration = {
				updateBuildConfiguration = "interactive",
				-- TODO Update this by adding any runtimes that you need to support your Java projects and removing any that you don't have installed
				-- The runtimes' name parameter needs to match a specific Java execution environments.  See https://github.com/eclipse-jdtls/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request and search "ExecutionEnvironment".
				runtimes = {
					{
						name = "JavaSE-" .. java_version,
						path = "C:\\Program Files\\Java\\jdk-" .. java_version,
					},
				},
			},
			maven = {
				downloadSources = true,
			},
			implementationsCodeLens = {
				enabled = true,
			},
			referencesCodeLens = {
				enabled = true,
			},
			references = {
				includeDecompiledSources = true,
			},
			signatureHelp = { enabled = true },
			format = {
				enabled = true,
				-- Formatting works by default, but you can refer to a specific file/URL if you choose
				-- settings = {
				--   url = "https://github.com/google/styleguide/blob/gh-pages/intellij-java-google-style.xml",
				--   profile = "GoogleStyle",
				-- },
			},
			completion = {
				favoriteStaticMembers = {
					"org.hamcrest.MatcherAssert.assertThat",
					"org.hamcrest.Matchers.*",
					"org.hamcrest.CoreMatchers.*",
					"org.junit.jupiter.api.Assertions.*",
					"java.util.Objects.requireNonNull",
					"java.util.Objects.requireNonNullElse",
					"org.mockito.Mockito.*",
				},
				importOrder = {
					"java",
					"javax",
					"com",
					"org",
				},
			},
			stepFilters = {
				skipClasses = {

					-- Filters out the following packages from the debugging stack trace
					-- This is useful to avoid stepping into library code
					-- TODO Adjust these filters based on your needs
					"java.*",
					"javax.*",
					"sun.*",
					"com.sun.*",
					"org.mockito.*",
					"org.springframework.*",
					"org.junit.*",
					"jdk.internal.*",
				},
				skipSynthetics = true,
				skipStaticInitializers = true,
				skipConstructors = true,
			},
			sources = {
				organizeImports = {
					starThreshold = 9999,
					staticStarThreshold = 9999,
				},
			},
			codeGeneration = {
				toString = {
					template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
				},
				useBlocks = true,
			},
		},
	},
	-- Needed for auto-completion with method signatures and placeholders
	capabilities = require("blink.cmp").get_lsp_capabilities(),
	flags = {
		allow_incremental_sync = true,
	},
	init_options = {
		-- References the bundles defined above to support Debugging and Unit Testing
		bundles = bundles,
		extendedClientCapabilities = jdtls.extendedClientCapabilities,
	},
}

-- Needed for debugging
config["on_attach"] = function(client, bufnr)
	jdtls.setup_dap({ hotcodereplace = "auto" })
	require("jdtls.dap").setup_dap_main_class_configs()
end

-- This starts a new client & server, or attaches to an existing client & server based on the `root_dir`.
jdtls.start_or_attach(config)
