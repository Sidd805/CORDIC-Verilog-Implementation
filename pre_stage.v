`timescale 1ns / 1ps

module pre_stage
#(parameter M=32,N=5)
(input signed [M-1:0] x_in,
 input signed [M-1:0] y_in,
 input signed [M-1:0] z_in,
 input [1:0] mode,
 input clk,
 output reg signed [M-1:0] x_0,
 output reg signed [M-1:0] y_0,
 output reg signed [M-1:0] z_0);
 
 localparam signed [M-1:0] pi_2       = 32'b00110010010000111111011010101001;
 localparam signed [M-1:0] minus_pi_2 = 32'b11001101101111000000100101010111;
 localparam signed [M-1:0] pi         = 32'b01100100100001111110110101010001;
 always @(posedge clk)
 begin
     case(mode)
        2'b00:
                begin
                x_0 <= (z_in>pi_2)?-y_in:(z_in<minus_pi_2)?y_in:x_in;
                y_0 <= (z_in>pi_2)?x_in:(z_in<minus_pi_2)?-x_in:y_in;
                z_0 <= (z_in>pi_2)?(z_in-pi_2):(z_in<minus_pi_2)?(z_in+pi_2):z_in;
                end
                
            
        2'b01:
                begin
                x_0 <= (x_in[M-1])? -x_in: x_in;
                y_0 <= (x_in[M-1])? -y_in: y_in;
                z_0 <= (x_in[M-1])? ((y_in[M-1])?(z_in-pi):(z_in+pi)): z_in;
                end
                
        2'b10:
                begin
                x_0 <= x_in;
                y_0 <= y_in;
                z_0 <= z_in;
                end
                
        2'b11:
                begin
                x_0 <= x_in;
                y_0 <= y_in;
                z_0 <= z_in;
                end               
     endcase
 end
endmodule
