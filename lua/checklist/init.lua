local function toggle_line(line)
	if string.len(line) <= 6 then
		return line
	elseif string.sub(line,1,5) == " ☐ " then
		return " ☑ " .. string.sub(line,6)
	elseif string.sub(line,1,5) == " ☑ " then
		return " ☐ " .. string.sub(line,6)
	else
		return line
	end
end

local function toggle(aline,bline)
	if aline == bline then
		local line = vim.api.nvim_get_current_line()
		vim.api.nvim_set_current_line(toggle_line(line));
	else
		local lines = vim.api.nvim_buf_get_lines(0,aline-1,bline,1)
		for i,line in pairs(lines) do
			lines[i] = toggle_line(line)
		end
		vim.api.nvim_buf_set_lines(0,aline-1,bline,1,lines);
	end
end

local function makelist(aline,bline)
	if aline == bline then
		local line = vim.api.nvim_get_current_line()
		vim.api.nvim_set_current_line(' ☐ ' .. line);
	else
		local lines = vim.api.nvim_buf_get_lines(0,aline-1,bline,1)
		for i,line in pairs(lines) do
			if string.len(line) ~= 0 then
				lines[i] = ' ☐ ' .. line
			end
		end
		vim.api.nvim_buf_set_lines(0,aline-1,bline,1,lines);
	end
end

vim.api.nvim_create_user_command("ChecklistToggle","lua require('checklist').toggle(<line1>,<line2>)",{})
vim.api.nvim_create_user_command("ChecklistMakeList","lua require('checklist').makelist(<line1>,<line2>)",{})

return {
	toggle = toggle,
	makelist = makelist
}
