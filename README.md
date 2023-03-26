# checklist.nvim

A short and sweet plugin for neovim for making and managing simple checklists.

## Exported Lua Functions:

### set_labels(unchecked_str, checked_str)
Allows for setting custom unchecked/checked labels. Labels cannot be the empty string, cannot be the same, and one cannot be a prefix of the other.

### reset_default_labels()
Resets unchecked/checked labels back to `" ☐ "` and `" ☑ "`.

## Exported Vim Commands:

### :ChecklistMakeList 
Adds the unchecked label (default `" ☐ "`) to the beginning of either the current line or all selected lines.

### :ChecklistToggle
Changes the unchecked label to the checked label or vice-versa at the beginning of either the current line or all selected lines.

TODO: \
 ☑ Allow for customized checkbox characters \
 ☐ Allow for indented checklists with leading whitespace \
 ☐ Allow for auto-extending checklist when moving to new line \
 ☐ Allow for checklists behind comments
