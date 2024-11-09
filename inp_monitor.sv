class inp_monitor extends uvm_monitor;
  `uvm_component_utils(inp_monitor)
  
  //constructor
  function new (string name = "inp_monitor", uvm_component parent);
    super.new(name,parent);
  endfunction
  
  //uvm_analysis_Port handle
  uvm_analysis_port#(cuboid) ap;
  
  //virtual interface handle to observe the DUT inout
  virtual cuboid_inp_intf vif;
  
  //sequence item handle to hold observed transaction
  cuboid trans;
  
  //build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    //get interface from config DB
    if(!uvm_config_db#(virtual cuboid_inp_intf)::get(this,"","vif_in",vif)) begin
      `uvm_fatal("INPUT_MONITOR", "Virtual interface not found for monitor.")
    end
    
    //instantiate analysis port 
    ap = new ("ap",this);
  endfunction
  
  //main phase
  virtual task main_phase(uvm_phase phase);
    super.main_phase(phase);
    collect_data();
  endtask
  
  //collecting data
  task collect_data;
    forever begin
      //wait for transactioin to be valid 
      @(posedge vif.clk iff vif.in_vld);
      
      //create a new transaction
      trans = cuboid::type_id::create("trans");
      
      //colleting data from interface and store it in transaction
      trans.length = vif.length;
      trans.width = vif.width;
      trans.height = vif.height;
      
      //send transcaction to analysis port
      ap.write(trans);
    end
  endtask
endclass

      
  
  