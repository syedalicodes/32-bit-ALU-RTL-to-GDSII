
module alu_flags (
    input  logic [31:0] result,
    output logic        zero,
    output logic        negative
);

    always_comb begin
        zero     = (result == 32'b0);
        negative = result[31];
    end

endmodule
