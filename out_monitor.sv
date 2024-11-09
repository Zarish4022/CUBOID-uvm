class out_monitor extends uvm_monitor;
  `uvm_component_utils(out_monitor)
  
  //constructor
  function new (string name= "out_monitor", uvm_component parent=null);
    super.new(name , parent);
  endfunction
  
  //uvm_analusis_port handle
  uvm_analysis_port#(cuboid) ap;
  
  //virtual interface handle for output signas
  virtual cuboid_out_intf  vif;
  
  //sequence item handle to hold observed transctin
  cuboid trans;
  
  //build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    //get interface from config db
    if(!uvm_config_db#(virtual cuboid_out_intf)::get(this,"","vif",vif))
      begin
        `uvm_fatal("OUTPUT_MONITOR","Virtual interface not found fro otu monitor.")
      end
    
    //instantiate the analysis port
    ap=new("ap",this);
  endfunction
  
  //main phase
  virtual task main_phase(uvm_phase phase);
    super.main_phase(phase);
    collect_data();
  endtask
  
  //collecting data
  task collect_data;
    forever begin
      //wait for valid output
      @(posedge vif.clk iff vif.out_vld);
      
      //create new transaction
      trans = cuboid::type_id::create("trans");
      
      //collect data from interface
      trans.area = vif.area;
      trans.volume = vif.volume;
      
      //publish the tramsaction through the analysis port
      ap.write(trans);
    end
  endtask
endclass
    