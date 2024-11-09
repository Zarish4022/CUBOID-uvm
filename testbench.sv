
`include "cuboid_inp_intf.sv"
`include "cuboid_out_intf.sv"

`include "cuboid_pkg.sv"

module tb_cuboid_prcr;
//   import example_pkg::*;

  
  
  //declare clock signals
  bit clk;
  bit rst;
  
  //instantiate inpout and output interfaces
  cuboid_inp_intf cuboid_inp_if(clk);
  cuboid_out_intf cuboid_out_if(clk);
  
  //instantiate the DUT and coonect t interfce
  
  
  cuboid_prcr u_dut(
    .clk(cuboid_inp_if.clk),
    .rst(1),
    .length(cuboid_inp_if.length),
    .width(cuboid_inp_if.width),
    .height(cuboid_inp_if.height),
    .in_valid(cuboid_inp_if.in_vld),
    .area(cuboid_out_if.area),
    .volume(cuboid_out_if.volume),
    .out_valid(cuboid_out_if.out_vld)
    
  );
  
  //clock generation
  
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end
  
  //reset generation
  
  initial begin
    rst = 0;
    #20 rst= 1;
  end
  
  
  //setting interface in uvm config db
  
  initial begin
    uvm_config_db#(virtual cuboid_inp_intf):: set (null, "uvm_test_top*","vif_in",cuboid_inp_if);
    uvm_config_db#(virtual cuboid_out_intf)::set(null,"uvm_test_top.env.out_agnt*","vif",cuboid_out_if);
  end
  
  //start the uvm test
   initial begin
      $dumpfile("dump.vcd"); $dumpvars;
     run_test("cuboid_base_test");
    end
  
  
  
endmodule :  tb_cuboid_prcr