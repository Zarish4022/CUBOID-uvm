//passive agent for output 

class out_agent extends uvm_agent;
  `uvm_component_utils(out_agent);
  //constructor
  function new(string name="out_agent",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  out_monitor monitor;
  
  //build phase
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    //instantiate monitor
    monitor = out_monitor::type_id::create("monitor",this);
  endfunction
  
  //connect phase
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction
endclass
