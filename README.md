# LSH-Project

To compile and run:
cd to project path
vlogan -kdb -sverilog -full64 work/stats.sv work/hash_table.sv work/hasher.sv work/window_hasher.sv work/main.sv work/top_level.sv
vcs -kdb -debug_access+all -full64 main
simv
