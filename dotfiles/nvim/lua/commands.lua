local notes_path = vim.env.NOTES_PATH or vim.env.HOME .. "/Documents/notes"
local normalize = require("utils").normalize
local command = vim.api.nvim_create_user_command
local telescope = require("telescope.builtin")

command("NewNote", function(args)
	local title = args.fargs[1] or vim.fn.input("Title: ")
	local id = os.date("%Y%m%d") .. os.time()
	local suffix = normalize(title)
	local file_name = id .. "-" .. suffix
	local file_path = notes_path .. "/" .. file_name .. ".md"

	vim.cmd("edit " .. file_path)

	vim.api.nvim_buf_set_lines(0, 0, -1, false, {
		"---",
		"id: " .. id,
		"tags: []",
		"aliases: []",
		"---",
		"",
		"# " .. title,
		"",
	})
end, { desc = "Create new note", nargs = "*" })

command("SearchNote", function()
	telescope.find_files({
		prompt_title = "Search note",
		cwd = notes_path,
	})
end, { desc = "Search note", nargs = 0 })

command("GrepNotes", function()
	telescope.live_grep({
		prompt_title = "Search in notes",
		cwd = notes_path,
	})
end, { desc = "Search in notes", nargs = 0 })

command("TodoTxt", function()
	vim.cmd("split " .. notes_path .. "/todo.txt")
end, { desc = "Open tasks", nargs = 0 })

command("Inbox", function()
	vim.cmd("split " .. notes_path .. "/inbox.md")
end, { desc = "Open inbox", nargs = 0 })

command("Sessions", function()
	require("mini.sessions").select()
end, { desc = "List sessions", nargs = 0 })
