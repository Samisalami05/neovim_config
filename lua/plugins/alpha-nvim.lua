return {
    'goolord/alpha-nvim',
    config = function ()
		local status_ok, alpha = pcall(require, "alpha")
		if not status_ok then
			return
		end

		local dashboard = require("alpha.themes.dashboard")

		local width = vim.api.nvim_win_get_width(0)
		local height = vim.api.nvim_win_get_height(0)

		local function center(text, width)
			local padding = math.max(0, math.floor((width - #text) / 2))
			return string.rep(" ", padding) .. text
		end

		local v = vim.version()
		local version_string = string.format("%d.%d.%d", v.major, v.minor, v.patch)

		local header = {
			"                                                     ",
			"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
			"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
			"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
			"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
			"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
			"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
			"                                                     ",
			center("v" .. version_string, 53),
			"                                                     ",
			"     Nvim is open source and freely distributale     ",
			"               https://neovim.io/#chat               ",
			"                                                     ",
			"     type  :help nvim<Enter>     if you are new!     ",
			"     type  :checkhealth<Enter>   to optimize Nvim    ",
			"     type  :q<Enter>             to exit             ",
			"     type  :help<Enter>          for help            ",
			"                                                     ",
			"     type  :help news<Enter> to see changes in v".. v.major .. "." .. v.minor .. " ",
			"                                                     ",
			"             Help poor children in Uganda!           ",
			"     type  :help Kuwasha<Enter>  for information     ",
			"                                                     ",
		}

		---- Settings ----
		local snowAmount <const> = 0.1
		local padding	 <const> = 5

		local randomRow = function ()
			local line = ""
			for x = 1, width do
				local rand = math.random()
				if rand < snowAmount then
					line = line .. "*"
				else
					line = line .. " "
				end
			end
			return line
		end

		local randomImage = function ()
			local lines = {}
			for y = 1, height do
				lines[y] = randomRow()
			end
			return lines
		end

		local generateImage = function(previous, time)
			local lines = {}

			lines[1] = randomRow()

			for y = 2, height do
				local row = {}
				for x = 1, width do
					row[x] = " "
				end
				lines[y] = row
			end

			if previous then
				for y = 1, #previous do
					local row_str = previous[y]
					for x = 1, #row_str do
						if string.sub(row_str, x, x) == "*" then
							-- move down randomly 1–3 rows
							local dy = math.random(1, 3)
							local new_y = y + dy
							if new_y <= height then
								-- optional horizontal shift
								local dx = math.random(-1, 1)
								local new_x = x + dx
								if new_x >= 1 and new_x <= width then
									lines[new_y][new_x] = "*"
								end
							end
						end
					end
				end
			end

			for y = 2, height do
				lines[y] = table.concat(lines[y])
			end

			return lines
		end

		local addHeader = function (image, header)
			local hwidth = #header[1]
			local hheight = #header

			local startx = 1 + math.floor((width - hwidth) / 2)
			local starty = 1 + padding

			local endx = startx + hwidth
			local endy = starty + hheight

			local result = {}

			for y = 1, height do
				if y >= starty and y <= endy then
					local headerLine = header[y - starty + 1] or ""
					result[y] = string.sub(image[y], 1, startx - 1) .. headerLine .. string.sub(image[y], endx + 1)
				else
					result[y] = image[y]
				end
			end

			return result
		end

		local time = 0
		local background = randomImage()

		dashboard.section.header.val = addHeader(background, header)
		dashboard.section.buttons.val = {
			dashboard.button( "e", "  > New file" , ":ene <BAR> startinsert <CR>"),
			dashboard.button( "f", "  > Find file", ":cd $HOME/Workspace | Telescope find_files<CR>"),
			dashboard.button( "r", "  > Recent"   , ":Telescope oldfiles<CR>"),
			dashboard.button( "s", "  > Settings" , ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
			dashboard.button( "q", "  > Quit NVIM", ":qa<CR>"),
		}
		dashboard.section.footer.val = {}
		alpha.setup({
			layout = {
				dashboard.section.header,
				--dashboard.section.buttons,
			}
		})

		_G.paused = false

		local timer = vim.loop.new_timer()
		timer:start(1000, 1000, function()
			if _G.paused then return end
			time = time + 1

			local prev = dashboard.section.header.val
			background = generateImage(background, time)
			dashboard.section.header.val = addHeader(background, header)

			vim.schedule(function()
				pcall(alpha.redraw)
			end)
		end)

		--vim.api.nvim_create_autocmd({"BufEnter","BufLeave"}, {
		--	pattern = "*",
		--	callback = function()
		--		--_G.paused = vim.bo.filetype ~= "alpha"
		--		vim.notify(vim.bo.filetype, vim.log.levels.INFO)
		--	end
		--})

    end
};
