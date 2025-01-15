class alu_env extends uvm_env;
  //This is my environment class
  alu_agent agt;
  alu_scoreboard scbd;
  `uvm_component_utils (alu_env)
  function new(string name = "alu_env", uvm_component parent);
    super.new(name, parent);
  endfunction
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    agt = alu_agent::type_id::create("agt", this);
    //build scoreboard
    scbd =alu_scoreboard::type_id::create("scbd", this);
  endfunction
  function void connect_phase (uvm_phase phase);
    //connect analysis port to scoreboard
    super.connect_phase(phase);
    agt.mon.alu_mon_port.connect(scbd.alu_imp);
  endfunction
endclass
