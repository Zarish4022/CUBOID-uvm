interface cuboid_out_intf (input logic clk);

  // Declare output signals for area, volume, and validity
  logic [31:0] area;
  logic [31:0] volume;
  logic out_vld;

  // Clocking block to synchronize output sampling with the clock
  clocking cb @(posedge clk);
    output area, volume, out_vld;
  endclocking

endinterface
