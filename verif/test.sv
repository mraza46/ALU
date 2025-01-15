class alu_test extends uvm_test;
  //This is my base test class
    `uvm_component_utils(alu_test)
    alu_env env;
    alu_seq seq;
    function new(string name = "alu_test",uvm_component parent=null);
      super.new(name,parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      env = alu_env::type_id::create("env", this);
      seq = alu_seq::type_id::create("seq",this);
    endfunction : build_phase

    task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      seq.start(env.agt.seqr);
      #10 phase.drop_objection(this);
    endtask : run_phase
endclass
