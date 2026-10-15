
`timescale 1ns / 1ps

module alu_tb;

    logic [31:0] a, b;
    logic [3:0] opcode;

    logic [31:0] result;
    logic zero, carry, negative, overflow;

    logic [31:0] expected_result;
    logic expected_zero, expected_carry;
    logic expected_negative, expected_overflow;

    logic [31:0] x, y;

    integer errors;
    integer i, op;

    alu_top dut (
        .a(a),
        .b(b),
        .opcode(opcode),
        .result(result),
        .zero(zero),
        .carry(carry),
        .negative(negative),
        .overflow(overflow)
    );

    alu_reference_model ref_model (
        .a(a),
        .b(b),
        .opcode(opcode),
        .expected_result(expected_result),
        .expected_zero(expected_zero),
        .expected_carry(expected_carry),
        .expected_negative(expected_negative),
        .expected_overflow(expected_overflow)
    );

    task automatic check_case(
        input logic [3:0] op_code,
        input logic [31:0] operand_a,
        input logic [31:0] operand_b
    );
        begin
            opcode = op_code;
            a = operand_a;
            b = operand_b;

            #1;

            if ((result !== expected_result) ||
                (zero !== expected_zero) ||
                (carry !== expected_carry) ||
                (negative !== expected_negative) ||
                (overflow !== expected_overflow)) begin

                $error(
                    "FAIL op=%h A=%h B=%h | R=%h expected=%h | flags ZCNO=%b%b%b%b expected=%b%b%b%b",
                    op_code, operand_a, operand_b,
                    result, expected_result,
                    zero, carry, negative, overflow,
                    expected_zero, expected_carry,
                    expected_negative, expected_overflow
                );

                errors = errors + 1;
            end
        end
    endtask

    initial begin
        errors = 0;
        a = 0;
        b = 0;
        opcode = 0;

        // Directed tests: every opcode
        check_case(4'h0, 32'd10, 32'd5);
        check_case(4'h1, 32'd10, 32'd5);
        check_case(4'h2, 32'hF0, 32'hCC);
        check_case(4'h3, 32'hF0, 32'hCC);
        check_case(4'h4, 32'hF0, 32'hCC);
        check_case(4'h5, 32'h0, 32'h0);
        check_case(4'h6, 32'hF0, 32'hCC);
        check_case(4'h7, 32'hF0, 32'hCC);
        check_case(4'h8, 32'd3, 32'd2);
        check_case(4'h9, 32'd12, 32'd2);
        check_case(4'hA, 32'h80000000, 32'd1);
        check_case(4'hB, 32'hFFFFFFFF, 32'd1);
        check_case(4'hC, 32'd2, 32'd3);
        check_case(4'hD, 32'hF0, 32'hCC);
        check_case(4'hE, 32'd99, 32'd0);
        check_case(4'hF, 32'd0, 32'h12345678);

        // Arithmetic boundary cases
        check_case(4'h0, 32'hFFFFFFFF, 32'd1);
        check_case(4'h0, 32'h7FFFFFFF, 32'd1);
        check_case(4'h1, 32'd0, 32'd1);
        check_case(4'h1, 32'h80000000, 32'd1);
        check_case(4'hE, 32'hFFFFFFFF, 32'd0);

        // Shift boundary cases
        check_case(4'h8, 32'd1, 32'd0);
        check_case(4'h8, 32'd1, 32'd31);
        check_case(4'h9, 32'h80000000, 32'd31);
        check_case(4'hA, 32'h80000000, 32'd31);

        // Randomized tests: 100 samples per opcode
        for (i = 0; i < 100; i = i + 1) begin
            x = $urandom;
            y = $urandom;

            for (op = 0; op < 16; op = op + 1) begin
                check_case(op[3:0], x, y);
            end
        end

        if (errors == 0) begin
            $display("PASS: All directed and randomized ALU tests passed.");
            $display("Randomized operation checks: 1600");
            $finish;
        end else begin
            $fatal(1, "FAIL: %0d comparison(s) failed.", errors);
        end
    end

endmodule
