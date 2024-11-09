class cuboid_base_test extends uvm_test;
  `uvm_component_utils(cuboid_base_test)

 
  // Constructor Method
  function new(string name = "cuboid_base_test", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  // component handles

  cuboid_env env; // Environment handle
  cuboid_sequence inp_sequence_i;

  // Virtual Interfaces
 
  virtual cuboid_inp_intf inp_vif;
  virtual cuboid_out_intf out_vif;
  
  // Build Phase Method
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Creating environment instance
    env = cuboid_env::type_id::create("env", this);

    // Getting virtual interfaces from UVM config database
    if (!uvm_config_db#(virtual cuboid_inp_intf)::get(this, "", "vif_in", inp_vif))
      `uvm_fatal("cuboid_base_test", "Input virtual interface not found")

//     if (!uvm_config_db#(virtual cuboid_out_intf)::get(this, "", "out_vif", out_vif))
//       `uvm_fatal("cuboid_base_test", "Output virtual interface not found")
  endfunction


  // Reset Phase Method

  virtual task reset_phase(uvm_phase phase);
    phase.raise_objection(this);
    super.reset_phase(phase);

    `uvm_info("cuboid_base_test", "Starting reset_phase..", UVM_MEDIUM)

    // Initialize interfaces with zeros
    vif_init_zero(); 

    // Wait 100 clock cycles as idle time
    repeat (10) @(posedge inp_vif.clk);

    `uvm_info("cuboid_base_test", "reset_phase done..", UVM_MEDIUM)
    phase.drop_objection(this);
  endtask // reset_phase

    
    virtual task main_phase(uvm_phase phase);
    phase.raise_objection(this);
    super.reset_phase(phase);

      `uvm_info("cuboid_base_test", "Starting main..", UVM_MEDIUM)
      inp_sequence_i = new();
      inp_sequence_i.start(env.inp_agnt.sequencer);
    phase.drop_objection(this);
    `uvm_info("cuboid_base_test", "main done..", UVM_MEDIUM)

  endtask // reset_phase  

  // Initialize all interfaces with zeros
  task vif_init_zero();
    inp_vif.length = 0;
    inp_vif.width = 0;
    inp_vif.height = 0;
    inp_vif.in_vld = 0;
  endtask
  
endclass
