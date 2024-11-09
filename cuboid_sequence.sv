class cuboid_sequence extends uvm_sequence#(cuboid);
   `uvm_object_utils(cuboid_sequence)
  
  //1. creating constructor
  function new(string name = "cuboid_sequence");
    super.new(name);
    `uvm_info("cuboid_sequence", "Building sequence", UVM_LOW)
  endfunction
  
  
  //sequence item handel
  cuboid req;
  
  
  virtual task body();
    req= cuboid::type_id::create("req");
    `uvm_do(req)
  endtask
  
endclass