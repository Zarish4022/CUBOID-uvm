interface cuboid_inp_intf (input clk);
 logic  [31:0] length;
  logic  [31:0] width;
  logic  [31:0] height;
  logic in_vld;
  
  
   clocking cb @(posedge clk);
    input length, width, height, in_vld;
  endclocking

endinterface