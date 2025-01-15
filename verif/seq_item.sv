//import uvm_pkg::*;

class alu_seq_item extends uvm_sequence_item;
  rand logic [4:0] in1;
  rand logic [4:0] in2;
  rand logic [2:0] opcode;
  logic [5:0]result;
  /*
  logic zero;
  logic cout;
  logic overflow;
  */
  constraint limit{
  opcode dist {[0:4]:=20, [5:7]:/6} ;
  (opcode == 7) -> (in2 <= 4);
  in1 > (in2*2);
   }
   
  `uvm_object_utils_begin(alu_seq_item)
    `uvm_field_int (in1, UVM_ALL_ON)
    `uvm_field_int (in2, UVM_ALL_ON)
    `uvm_field_int (opcode, UVM_ALL_ON)
  `uvm_object_utils_end

  function new (string name = "alu_seq_item");
    super.new(name);
  endfunction
endclass 
