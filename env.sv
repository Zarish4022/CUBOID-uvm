class cuboid_env extends uvm_env;
  `uvm_component_utils(cuboid_env)

  // Constructor Method
  function new(string name="cuboid_env", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  // Internal Signals and Handles Declaration
  inp_agent      inp_agnt;
  out_agent      out_agnt;
  scoreboard     scb;

  // UVM event for synchronization
  uvm_event      in_scb_event;

  // Watchdog timer variable
  int            watch_dog_timer;

  // Build Phase Method
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Creating Agents and Scoreboard
    inp_agnt = inp_agent::type_id::create("inp_agnt", this);
    out_agnt = out_agent::type_id::create("out_agnt", this);
    scb      = scoreboard::type_id::create("scb", this);

    // Initialize UVM event
    in_scb_event = new();

    // Implicit call to sequence in main phase
    // Could be linked here, depending on test requirements
  endfunction  // build_phase

 
  // Connect Phase Method

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    // Connect analysis ports from agents to scoreboard
    inp_agnt.monitor.ap.connect(scb.exp_port);

  endfunction  // connect_phase


  // Main Phase Task
  virtual task main_phase(uvm_phase phase);
    phase.raise_objection(this);
    `uvm_info("cuboid_env", "Starting main_phase.. ", UVM_MEDIUM)
    super.main_phase(phase);

    // Initialize watchdog timer value
    watch_dog_timer = 1000; // Example value; adjust based on simulation needs

    fork
      begin
        // Watchdog timer to prevent simulation hang
        #watch_dog_timer;
        `uvm_error("cuboid_env", "Simulation terminated by watchdog timer.")
//         phase.drop_objection(this);
      end

      begin
        // Wait for the event from scoreboard or end of main phase
        in_scb_event.wait_trigger();
      end
    join_any
    disable fork;

    `uvm_info("cuboid_env", "main_phase done.. ", UVM_MEDIUM)
    phase.drop_objection(this);
  endtask // main_phase

endclass
