vlib work 
vlog -f source.txt
vsim -voptargs=+accs work.debouncer_tb
add wave *
run -all
