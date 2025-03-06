// # Lab 5
//
// Complete this Verilog module so that it implements the following schematic:
//
// <figure class="image"><img src="lab5datapath.png" alt="A 12x12 multiplier and summer"><figcaption>Figure 1: Schematic to implement.</figcaption></figure>
//
// Busses `k1`, `k2`, `k3` are the following constants:
//
// | Constant | 12-bit value in hex | Value in decimal (in 1.11 fixed point) |
// | -------- | ------------------- | -------------------------------------- |
// | `k1`     | C00                 | \-0.5                                  |
// | `k2`     | 500                 | 0.625                                  |
// | `k3`     | C00                 | \-0.5                                  |
module lab5dpath (
    input logic clk,
    input logic signed [9:0] x1, 
    input logic signed [9:0] x2,
    input logic signed [9:0] x3,
    output logic signed [9:0] y
);



// Constants in 1.11 fixed point representation
logic signed [11:0] k1 = 12'hC00;  // -0.5 in 1.11
logic signed [11:0] k2 = 12'h500;  // 0.625 in 1.11
logic signed [11:0] k3 = 12'hC00;  // -0.5 in 1.11

// Pipeline registers for input stage
logic signed [9:0] x1_reg, x2_reg, x3_reg;
always_ff @(posedge clk) begin
   
        x1_reg <= x1;
        x2_reg <= x2;
        x3_reg <= x3;
end


// Extend inputs to 12-bit (adding two LSbs of 00) - **Combinational Logic**
logic signed [11:0] v1, v2, v3;
assign v1 = {x1_reg, 2'b00};
assign v2 = {x2_reg, 2'b00};
assign v3 = {x3_reg, 2'b00};

// Multiply extended inputs by constants using Hardmacro Multipliers
logic signed [23:0] t1, t2, t3;
mult_gen_0 mult1 (.CLK(clk), .A(v3), .B(k3), .P(t1));
mult_gen_0 mult2 (.CLK(clk), .A(v2), .B(k2), .P(t2));
mult_gen_0 mult3 (.CLK(clk), .A(v1), .B(k1), .P(t3));

// Drop the most significant bits (keep bits 22:11 for 12-bit result) - **Combinational Logic**
logic signed [11:0] p1, p2, p3;
assign p1 = t1[22:11];
assign p2 = t2[22:11];
assign p3 = t3[22:11];

// Sum the products - **Combinational Logic**
logic signed [11:0] s1, s2;
assign s1 = p2 + p3;
assign s2 = s1 + p1;

// Drop the two least significant bits and pipeline output (Latency Stage 2)
logic signed [9:0] y_reg;
always_ff @(posedge clk) begin

        y_reg <= s2[11:2];
end

// Assign final output
assign y = y_reg;

endmodule

