// .. Copyright (C) 2022 Bryan A. Jones
//
// *****************************************************************
// |docname| -- Finite state machines template
// *****************************************************************
// This demonstrates the recommended structure used to implement a finite state machine. The FSM implemented here is:
//
// .. digraph:: state_diagram
//
//  rankdir="LR"
//  STATE_0 [peripheries=2, label="STATE_0\noutput_1=1"]
//  STATE_0 -> STATE_1
//  STATE_1 -> STATE_2 [label="input_1:\loutput_1=1"]
//  STATE_2 -> STATE_0
module fsm_template (
    input  logic clk,
    input  logic reset,
    input  logic [23:1] address,
    input  logic [15:0] data_in,
    output logic [15:0] data_out,
    input  logic read_enable,
    input  logic write_enable,
    input  logic [15:0] switches,
    output logic [15:0] led
);
 
    // Sequential state update logic.
    logic load;
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            // Statements assigning a reset value to state variables go
            // here. Don't assign to combinational-only values! Put your
            // reset code from here...
            led = 0;
            // ...to here.
        end else begin
            // Statements assigning a next state value to state variables
            // go here. Don't assign to combinational-only values! Put your
            // state update code from here...
            led = load ? data_in : led;
            // ...to here.
        end
    end
 
    // Combinational next state and output logic.
    always_comb begin
       load = address == 24'h123456 && write_enable;
    end
 
endmodule