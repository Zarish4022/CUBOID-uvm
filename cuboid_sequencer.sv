class cuboid_sequencer extends uvm_sequencer #(cuboid);
  
  `uvm_component_utils(cuboid_sequencer)
  
  function new (string name, uvm_component parent);
    super.new(name,parent);
    `uvm_info("cuboid_sequencer", "Building sequencer", UVM_LOW)
  endfunction
endclass: cuboid_sequencer