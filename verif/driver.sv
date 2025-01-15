class alu_driver extends uvm_driver #(alu_seq_item);
  virtual aluif alif;
  alu_seq_item trans;
  `uvm_component_utils(alu_driver)

  function new(string name ="alu_driver", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    //trans = alu_seq_item::type_id::create("trans",this);
    if(!uvm_config_db#(virtual aluif)::get(this,"","alif",alif))
      `uvm_fatal("Driver : ALU",{"virtual if must be set for:",get_full_name(),".alif"});
  endfunction

  virtual task run_phase(uvm_phase phase);
    while(1) begin
      //alu_seq_item trans;
      seq_item_port.get_next_item(trans);
       @(alif.icb);
      drive();
      seq_item_port.item_done();
    end
  endtask

  extern virtual task drive();

endclass

task alu_driver::drive();
  wait(!alif.rst);
  alif.in1 <= trans.in1;
  alif.in2 <= trans.in2;
  alif.opcode <= trans.opcode;
  @(posedge alif.clk);
  `uvm_info(get_type_name() ,$sformatf("in1=%0d .. in2=%0d .. opcode=%0d",alif.in1, alif.in2, alif.opcode),UVM_LOW);

endtask
