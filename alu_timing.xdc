
# 32-bit ALU - combinational FPGA timing analysis
# Virtual clock used only as an I/O timing reference.

create_clock -name virtual_clk -period 20.000

set_input_delay -clock virtual_clk -max 1.000 \
    [get_ports {a[*] b[*] opcode[*]}]

set_input_delay -clock virtual_clk -min 0.000 \
    [get_ports {a[*] b[*] opcode[*]}]

set_output_delay -clock virtual_clk -max 1.000 \
    [get_ports {result[*] zero carry negative overflow}]

set_output_delay -clock virtual_clk -min 0.000 \
    [get_ports {result[*] zero carry negative overflow}]
