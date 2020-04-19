
set_false_path -to [get_cells -hier -filter {name =~ *ld* && IS_SEQUENTIAL}]
set_false_path -to [get_cells -hier -filter {name =~ *refcnt* && IS_SEQUENTIAL}]
set_false_path -from [get_cells -hier -filter {name =~ *ref_is_10M* && IS_SEQUENTIAL}] -to [get_cells -hier -filter {name =~ *FSM_sequential_state* && IS_SEQUENTIAL}]
set_false_path -from [get_cells -hier -filter {name =~ *shift* && IS_SEQUENTIAL}] -to [get_cells -hier -filter {name =~ *adj* && IS_SEQUENTIAL}]

set_false_path -from [get_cells -hier -filter {name =~ *lead* && IS_SEQUENTIAL}] -to [get_cells -hier -filter {name =~ *FSM_sequential_state* && IS_SEQUENTIAL}]


