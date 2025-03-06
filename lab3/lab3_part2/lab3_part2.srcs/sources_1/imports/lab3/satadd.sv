// # `satadd.v` - A Verilog module implementing lab 3, an (optionally) saturating adder.
module satadd(
    // The [addends](https://en.wiktionary.org/wiki/addend).
    input logic [11:0] a,
    input logic [11:0] b,
    // Adder mode:
    //
    // | Mode Input     | Output function                 |
    // | -------------- | ------------------------------- |
    // | `mode = 2'b00` | y = a + b (unsigned saturation) |
    // | `mode = 2'b01` | y = a + b (signed saturation)   |
    // | `mode = 2'b10` | y = a + b (normal addition)     |
    // | `mode = 2'b11` | y = a + b (normal addition)     |
    input logic [1:0] mode,
    // The resulting sum.
    output logic [11:0] y
);



logic [12:0] r_1;
//assign r_1 = a + b; 
ip_addsub u1 (.A(a), .B(b), .S(r_1));

// 2's Compliment code 

logic and_1;
logic and_2; 
logic vFlag; 

assign and_1 = ~a[11] & ~b[11] & r_1[11]; 

assign and_2 = a[11] & b[11] & ~r_1[11]; 

assign vFlag = and_1 | and_2; 

// Determine the Max Positive or Nevagtive Signed R_1 value

logic [11:0] if_pos_neg_sign;
assign if_pos_neg_sign = r_1[11] ? 12'h7FF : 12'h800;

// Detailing if the inputs are signed or unassigned

logic [11:0] is_signed_sum; 
logic [11:0] not_signed_sum; 

// Saturation setp 

assign not_signed_sum = r_1[12] ? 12'hFFF : r_1[11:0]; 

assign is_signed_sum = vFlag ? if_pos_neg_sign : r_1[11:0];

// Final Result Determine True OutPut 

logic [11:0] t1_out; 

//assign mode[0] = vFlag ? 1 : 0; 
//aassign mode[1] = r_1[12] ? 

assign t1_out = mode[0] ? is_signed_sum : not_signed_sum; 
assign y = mode[1] ? r_1[11:0] : t1_out; 

//assign y = mode[1] ? r_1[11:0] : (mode[0] ? is_signed_sum : not_signed_sum);



// ## Implementation Guidance
//
// 1.  <span style="color: red;">All of this logic must be implemented using
//     assign statements; you may not use <code>always</code> blocks/sequential
//     statements.</span>
// 2.  Note the inputs of the adder are 12 bits wide, while the output is 13
//     bits wide. Bit `r[11]` of the adder output is the sign of the output
//     value, while bit `r[12]` is the carry out (Cout). If the carry out is 1,
//     then unsigned overflow occurred.
// 3.  The `vFlag` internal signal is 1 if a two's complement overflow occurs.
//     This is true if the sum of two positive numbers produces a negative
//     number or if the sum of two negative numbers produces a positive number.
//     The signs of the two inputs (`a[11]`, `b[11]`) are represented by the
//     signals `aSign`, `bSign` and the sign of the result (`r[11]`) by `rSign`.
//
// <figure class="image"><img title="Figure 1. Suggested architecture" src="suggested-architecture.png" alt="A schematic showing the suggested architecture for this module."><figcaption>Figure 1: Suggested architecture.</figcaption></figure>

endmodule
