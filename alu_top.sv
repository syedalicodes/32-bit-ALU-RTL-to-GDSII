
module alu_top (
    input  logic [31:0] a,
    input  logic [31:0] b,
    input  logic [3:0]  opcode,

    output logic [31:0] result,
    output logic        zero,
    output logic        carry,
    output logic        negative,
    output logic        overflow
);

    alu_core u_alu_core (
        .a        (a),
        .b        (b),
        .opcode   (opcode),
        .result   (result),
        .carry    (carry),
        .overflow (overflow)
    );

    alu_flags u_alu_flags (
        .result   (result),
        .zero     (zero),
        .negative (negative)
    );

endmodule
