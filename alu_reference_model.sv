
module alu_reference_model (
    input  logic [31:0] a,
    input  logic [31:0] b,
    input  logic [3:0]  opcode,
    output logic [31:0] expected_result,
    output logic        expected_zero,
    output logic        expected_carry,
    output logic        expected_negative,
    output logic        expected_overflow
);

    logic [32:0] temp;

    always_comb begin
        expected_result   = 32'b0;
        expected_carry    = 1'b0;
        expected_overflow = 1'b0;
        temp              = 33'b0;

        case (opcode)
            4'h0: begin
                temp = {1'b0, a} + {1'b0, b};
                expected_result = temp[31:0];
                expected_carry = temp[32];
                expected_overflow =
                    (~(a[31] ^ b[31])) &
                    (expected_result[31] ^ a[31]);
            end

            4'h1: begin
                expected_result = a - b;
                expected_carry = (a >= b);
                expected_overflow =
                    (a[31] ^ b[31]) &
                    (expected_result[31] ^ a[31]);
            end

            4'h2: expected_result = a & b;
            4'h3: expected_result = a | b;
            4'h4: expected_result = a ^ b;
            4'h5: expected_result = ~a;
            4'h6: expected_result = ~(a & b);
            4'h7: expected_result = ~(a | b);
            4'h8: expected_result = a << b[4:0];
            4'h9: expected_result = a >> b[4:0];
            4'hA: expected_result = $signed(a) >>> b[4:0];

            4'hB: expected_result =
                {31'b0, ($signed(a) < $signed(b))};

            4'hC: expected_result = {31'b0, (a < b)};
            4'hD: expected_result = ~(a ^ b);

            4'hE: begin
                temp = {1'b0, a} + 33'd1;
                expected_result = temp[31:0];
                expected_carry = temp[32];
                expected_overflow = (~a[31]) &
                                    expected_result[31];
            end

            4'hF: expected_result = b;

            default: expected_result = 32'b0;
        endcase

        expected_zero = (expected_result == 32'b0);
        expected_negative = expected_result[31];
    end

endmodule
