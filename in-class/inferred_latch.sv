// # `in-class.sv` - skeleton code for in-class exercises
//
// See also the [test bench](tb_in-class.sv).
module inferred_latch(
    input logic clk,
    input logic reset,
    input logic [15:0] a,
    input logic [15:0] b,
    input logic [15:0] c,
    output logic [15:0] x,
    output logic [15:0] y,
    output logic [15:0] z
);

    always_comb begin
<<<<<<< HEAD
        case (a)
=======
        case (c)
>>>>>>> 575a3e30ac37f739fb38b00dd4c78501eb7f0df4
            2'b00: x = a & b;
            2'b01: x = a | b;
            2'b10: x = a ^ b;
            2'b11: x = ~(a & b);
<<<<<<< HEAD
            default: x = 2'b00;
=======
>>>>>>> 575a3e30ac37f739fb38b00dd4c78501eb7f0df4
        endcase
    end

endmodule
