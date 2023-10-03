local obsidian = require("obsidian")
local notes = os.getenv("NOTES") or vim.fn.expand("~/Documents/notes")

obsidian.setup({
	dir = notes,
	finder = "telescope.nvim",
	open_notes_in = "current",
	overwrite_mappings = true,
	sort_by = "modified",
	sort_reversed = true,
	disable_frontmatter = false,
	note_frontmatter_func = function(note)
		local out = { aliases = note.aliases, tags = note.tags }
		if note.metadata ~= nil and obsidian.util.table_length(note.metadata) > 0 then
			for k, v in pairs(note.metadata) do
				out[k] = v
			end
		end
		return out
	end,
	daily_notes = {
		alias_format = "%a, %d %b %Y",
		date_format = "%d-%m-%Y",
		folder = "daily",
	},
	templates = {
		date_format = "%d-%m-%Y",
		subdir = "templates",
		time_format = "%d%m%Y%H%M",
	},
	completion = {
		min_chars = 2,
		new_notes_location = "notes_subdir",
		nvim_cmp = true,
		prepend_note_id = false,
	},
	mappings = {
		["gf"] = {
			action = function()
				return obsidian.util.gf_passthrough()
			end,
			opts = { noremap = false, expr = true, buffer = true },
		},
	},
})
