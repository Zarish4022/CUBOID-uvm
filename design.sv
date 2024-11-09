module cuboid_prcr(
  input clk,
  input rst,
  //input interface
  input [15:0] length,
  input [15:0] width,
  input [15: 0] height,
  input in_valid,
  
  //output interface
  
  output reg out_valid,
  output reg [31:0] area,
  output reg [31:0] volume
);
  
  always@ (posedge clk)
    begin
      volume <= length * width *height ;
      area <= 2* (length*width + width*height + height*length);
      out_valid <= in_valid;
    end
  
endmodule
  