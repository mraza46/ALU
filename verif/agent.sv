class alu_agent extends uvm_agent;
  alu_driver driver;
  alu_sequencer seqr;
  alu_monitor mon;
  //UVM automation macros for general components
  `uvm_component_utils(alu_agent)

  function new(string name ="alu_agent", uvm_component parent);
    super.new (name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    driver = alu_driver::type_id::create("driver", this);
    mon = alu_monitor::type_id::create("mon", this);
    seqr = alu_sequencer::type_id::create("seqr", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    if(get_is_active() == UVM_ACTIVE) begin
      driver.seq_item_port.connect(seqr.seq_item_export);
    end
  endfunction
endclass
