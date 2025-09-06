`timescale 1ns / 1ps

module phase_acc
#(parameter M=32,N=5)
(input clk,
input rst, 
input signed [M-1:0] p_step,
output reg signed [M-1:0] phase);

localparam signed [M-1:0] pi=32'b01100100100001111110110101010001;
wire signed [M-1:0] phase_0 = phase - pi ;

always @(posedge clk)
begin
if(rst)
    begin
        phase <= 0;
    end

else
    begin
        phase <= (phase>pi)?phase_0 - pi: phase + p_step;           
    end
end
endmodule
