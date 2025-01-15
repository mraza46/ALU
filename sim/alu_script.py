import os
Path = "/remote/usrhome/otusbimp20/ALI/UVM/ALU_Project/verif"
# Define your project files
project_files = [
    f"{Path}/Interface.sv",
    f"{Path} ../rtl/alu_rtl.sv",
    f"{Path}/pkg.sv",
    f"{Path}/top.sv"
]

# Combine project files into a single string
project_files_str = " ".join(project_files)

# VCS compile command
vcs_command = f"vcs -full64 -sverilog +incdir+{Path} -ntb_opts uvm-1.2 {project_files_str} -l log"

os.system(vcs_command)

# Run command
run_command = "./simv"

os.system(run_command)
