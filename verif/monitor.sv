enum {ADD, SUB, AND, OR, XOR, SLL, SRL, SRA} e_op;

class alu_monitor extends uvm_monitor;
  //Handle for interface to monitor
  virtual aluif alif;
  //logic [4:0]t_in1=0;
  //logic [4:0]t_in2=0;
  //Handle to capture transaction information.
  alu_seq_item trans;
  uvm_analysis_port #(alu_seq_item) alu_mon_port;
  `uvm_component_utils(alu_monitor)
  
  function new (string name ="alu_monitor", uvm_component parent);
    super.new(name, parent);
    //trans = new();
    alu_mon_port = new("alu_mon_port", this); 
  endfunction
  //Get the virtual interface from config_db
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    //trans = alu_seq_item::type_id::create("trans",this);
    if(!uvm_config_db#(virtual aluif)::get(this,"", "alif", alif))
      `uvm_fatal("Monitor : ALU",{"virtual if must be set for:",get_full_name(),".alif"});
  endfunction
  //Run phase
  virtual task run_phase(uvm_phase phase);
   super.run_phase(phase);
   trans = alu_seq_item::type_id::create("trans",this);
   wait(!alif.rst);
   #1;
   forever begin
    //Sample aluif and store in trans
    @(alif.icb);
     //if((t_in1 != alif.in1) && (t_in2 != alif.in2))begin
      monitor_alu_if(trans);
      //Send monitored transaction to scoreboard
      alu_mon_port.write(trans);
     //end
    end
  endtask
  //Sample alu if
  extern virtual task monitor_alu_if(alu_seq_item trans);
endclass

task alu_monitor::monitor_alu_if(alu_seq_item trans);
  //t_in1 = alif.in1;
  //t_in2 = alif.in2;
  trans.in1 = alif.in1;
  trans.in2 = alif.in2;
  trans.opcode = alif.opcode;
  e_op = alif.opcode;
  @(posedge alif.clk);
  trans.result = alif.result;
  `uvm_info(get_type_name() , "Transaction recived",UVM_LOW);
  `uvm_info(get_type_name(),$sformatf("in1=%0d..in2=%0d..operation=%s..result=%0d",trans.in1, trans.in2, e_op, trans.result),UVM_LOW);
  //trans.print();
  //sem.put(1);

endtask
