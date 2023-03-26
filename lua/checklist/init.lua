local default_unchecked_label = " ☐ "
local default_checked_label = " ☑ "

local unchecked_label = default_unchecked_label
local checked_label = default_checked_label

local function reset_default_labels()
    unchecked_label = default_unchecked_label
    checked_label = default_checked_label
end

local function set_labels(unchecked_str, checked_str)
    -- make sure labels are distinct, non-empty, and not a prefix of the other
    if string.sub(unchecked_str,1,string.len(checked_str)) ~= string.sub(checked_str,1,string.len(unchecked_str)) then
        unchecked_label = unchecked_str
        checked_label = checked_str
    end
end

local function toggle_line(line)
	if string.sub(line, 1, string.len(unchecked_label)) == unchecked_label then
		return checked_label .. string.sub(line, string.len(unchecked_label) + 1)
	elseif string.sub(line, 1, string.len(checked_label)) == checked_label then
		return unchecked_label .. string.sub(line, string.len(checked_label) + 1)
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
		vim.api.nvim_set_current_line(unchecked_label .. line);
	else
		local lines = vim.api.nvim_buf_get_lines(0,aline-1,bline,1)
		for i,line in pairs(lines) do
			if string.len(line) ~= 0 then
				lines[i] = unchecked_label .. line
			end
		end
		vim.api.nvim_buf_set_lines(0,aline-1,bline,1,lines);
	end
end

vim.api.nvim_create_user_command("ChecklistToggle","lua require('checklist').toggle(<line1>,<line2>)",{range=2})
vim.api.nvim_create_user_command("ChecklistMakeList","lua require('checklist').makelist(<line1>,<line2>)",{range=2})

return {
	toggle = toggle,
	makelist = makelist,
    set_labels = set_labels,
    reset_default_labels = reset_default_labels,
}
