package cuboid_pkg;
`include "uvm_macros.svh"
import uvm_pkg::*;


//including all files

`include "cuboid.sv";
`include "inp_driver.sv";
`include "inp_monitor.sv";
`include "out_monitor.sv";
`include "inp_agent.sv";
`include "out_agent.sv";
`include "scoreboard.sv";
`include "cuboid_sequence.sv";

`include "cuboid_sequencer.sv";

`include "inp_sequence.sv";

`include "env.sv";
`include "cuboid_base_test.sv";

endpackage : cuboid_pkg