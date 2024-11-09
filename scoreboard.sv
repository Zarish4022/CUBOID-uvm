class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)

  // Count variables
  int match_count = 0;
  int mismatch_count = 0;

  // Constructor function
  function new(string name = "scoreboard", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Implementation port handle for expected data
  uvm_analysis_port #(cuboid) exp_port;

  // Queue of sequence items for expected data
  cuboid expected_queue[$];
  cuboid exp_item;
  cuboid act_item;

  // UVM event to synchronize processes
  uvm_event in_scb_event;

  // Create implementation ports in the build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Instantiate the implementation port
    exp_port = new("exp_port", this);

    // Initialize UVM event
    in_scb_event = uvm_event_pool::get_global("in_scb_event");
  endfunction

  // Write function to push expected data into the queue
  virtual function void write_exp(cuboid trans);
    // Push expected item to the queue
    expected_queue.push_back(trans);
  endfunction

  // Write function to compare actual data with expected data
  virtual function void write_act(cuboid trans);
    // Pop data from queue if available
    if (expected_queue.size() > 0) begin
      exp_item = expected_queue.pop_front();
      act_item = trans;

      // Compare expected and actual data
      if ((exp_item.area == act_item.area) && (exp_item.volume == act_item.volume)) begin
        match_count++;
      end else begin
        mismatch_count++;
        `uvm_error("SCOREBOARD", $sformatf("Mismatch: Expected area=%0d, volume=%0d; Got area=%0d, volume=%0d", exp_item.area, exp_item.volume, act_item.area, act_item.volume))
      end
    end else begin
      `uvm_error("SCOREBOARD", "Expected queue is empty, but an actual item was received.")
    end
  endfunction

  // Main Phase Task
  virtual task main_phase(uvm_phase phase);
    super.main_phase(phase);
    
    // Wait until match and mismatch counts equal the number of expected packets sent
    // Trigger UVM event for synchronization
    in_scb_event.trigger();
  endtask // main_phase

  // Report Phase
  virtual function void report_phase(uvm_phase phase);
    // Display the count of matches and mismatches
    `uvm_info("SCOREBOARD", $sformatf("Total Matches: %0d, Total Mismatches: %0d", match_count, mismatch_count), UVM_LOW)
  endfunction // report_phase

endclass // scoreboard
