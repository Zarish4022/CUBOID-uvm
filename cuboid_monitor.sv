class exmp_monitor extends uvm_monitor;
  
  uvm_analysis_port #(exmp_item) exmp_out;
    
  exmp_item collected_packet;
  `uvm_component_utils(exmp_monitor)
  
  function new (string name , uvm_component parent);
    super.new(name, parent);
    `uvm_info("exmp_monitor", "Building monitor", UVM_LOW)
    exmp_out = new ("exmp_out" , this);
  endfunction : new

  virtual task run_phase(uvm_phase phase);
    collect_packet();
  endtask
  
  task collect_packet();
    // collect Header {Length, Addr}
    //Collect the Payload
    //Collect Parity and set Parity Type
    exmp_out.write(collected_packet);
    
  endtask
endclass: exmp_monitor