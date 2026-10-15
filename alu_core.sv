
module alu_core (
    input  logic [31:0] a,
    input  logic [31:0] b,
    input  logic [3:0]  opcode,
    output logic [31:0] result,
    output logic        carry,
    output logic        overflow
);

    logic [32:0] wide_result;

    always_comb begin
        result      = 32'b0;
        carry       = 1'b0;
        overflow    = 1'b0;
        wide_result = 33'b0;

        case (opcode)

            // 0: Addition
            4'h0: begin
                wide_result = {1'b0, a} + {1'b0, b};
                result      = wide_result[31:0];
                carry       = wide_result[32];
                overflow    = (~(a[31] ^ b[31])) &
                              (result[31] ^ a[31]);
            end

            // 1: Subtraction
            4'h1: begin
                result   = a - b;
                carry    = (a >= b); // 1 = no unsigned borrow
                overflow = (a[31] ^ b[31]) &
                           (result[31] ^ a[31]);
            end

            // 2-7: Logic operations
            4'h2: result = a & b;
            4'h3: result = a | b;
            4'h4: result = a ^ b;
            4'h5: result = ~a;
            4'h6: result = ~(a & b);
            4'h7: result = ~(a | b);

            // 8-A: Shift operations
            4'h8: result = a << b[4:0];
            4'h9: result = a >> b[4:0];
            4'hA: result = $signed(a) >>> b[4:0];

            // B-C: Comparisons
            4'hB: result = {
                31'b0, ($signed(a) < $signed(b))
            };

            4'hC: result = {
                31'b0, (a < b)
            };

            // D: XNOR
            4'hD: result = ~(a ^ b);

            // E: Increment A
            4'hE: begin
                wide_result = {1'b0, a} + 33'd1;
                result      = wide_result[31:0];
                carry       = wide_result[32];
                overflow    = (~a[31]) & result[31];
            end

            // F: Pass B
            4'hF: result = b;

            default: begin
                result   = 32'b0;
                carry    = 1'b0;
                overflow = 1'b0;
            end

        endcase
    end

endmodule
