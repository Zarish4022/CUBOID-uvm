class inp_agent extends uvm_agent;
  `uvm_component_utils(inp_agent)
  
  //constructor
  function new (string name="inp_agent", uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  //montior handle
  inp_monitor monitor;
  
  //driver handle
  inp_driver driver;
  
  //sequence handle 
  uvm_sequencer#(cuboid) sequencer;
  
  //build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    //instatntiate monitor
    monitor = inp_monitor::type_id::create("monitor", this);
    
    //driver intantiaion
    driver = inp_driver::type_id::create("driver",this);
    
    //sequencer intantiation
    sequencer = uvm_sequencer#(cuboid)::type_id::create("sequencer",this);
    endfunction
  
  //connect phase
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    
    //connect drivers seq_item_port to sequencer seq_item_export 
    driver.seq_item_port.connect(sequencer.seq_item_export);
  endfunction
endclass
    
    