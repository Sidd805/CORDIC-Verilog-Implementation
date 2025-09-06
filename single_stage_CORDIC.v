`timescale 1ns / 1ps


module Cordic_stage
#(parameter M=32,N=5)
(input signed [M-1:0] x_in,
 input signed [M-1:0] y_in,
 input signed [M-1:0] z_in,
 input [1:0] mode,
 input rst,
 input signed [M-1:0] atanj,
 input [31:0] j,
 input clk,
 output reg signed [M-1:0] x_out,
 output reg signed [M-1:0] y_out,
 output reg signed [M-1:0] z_out);
 
 
 always @(posedge clk)
 begin
 
     if(rst)
         begin
             x_out <= 32'b0;
             y_out <= 32'b0;
             z_out <= 32'b0;
         end
 
     else
         begin
             case(mode)
                2'b00:
                 begin
                 
                     if(z_in[M-1])
                         begin
                             x_out <= x_in + (y_in >>>j);
                             y_out <= y_in - (x_in >>>j);
                             z_out <= z_in + atanj;
                         end
                 
                     else
                         begin
                             x_out <= x_in - (y_in >>>j);
                             y_out <= y_in + (x_in >>>j);
                             z_out <= z_in - atanj;
                         end
                 end
                 
                2'b01:
                 begin
                     if(y_in[M-1])
                         begin
                             x_out <= x_in - (y_in >>>j);
                             y_out <= y_in + (x_in >>>j);
                             z_out <= z_in - atanj;
                         end
                     
                     else
                         begin
                             x_out <= x_in + (y_in >>>j);
                             y_out <= y_in - (x_in >>>j);
                             z_out <= z_in + atanj;
                         end
                 end
                 
                 2'b10:
                 begin
                    
                     if(z_in[M-1])
                         begin
                             x_out <= x_in - (y_in >>>(j+1));
                             y_out <= y_in - (x_in >>>(j+1));
                             z_out <= z_in + atanj;
                         end
                 
                     else
                         begin
                             x_out <= x_in + (y_in >>>(j+1));
                             y_out <= y_in + (x_in >>>(j+1));
                             z_out <= z_in - atanj;
                         end
                 end
                 
                2'b11:
                 begin
                    
                     if(y_in[M-1])
                         begin
                             x_out <= x_in + (y_in >>>(j+1));
                             y_out <= y_in + (x_in >>>(j+1));
                             z_out <= z_in - atanj;
                         end
                     
                     else
                         begin
                             x_out <= x_in - (y_in >>>(j+1));
                             y_out <= y_in - (x_in >>>(j+1));
                             z_out <= z_in + atanj;
                         end
                 end
                 
             endcase    
         end
 end
endmodule
