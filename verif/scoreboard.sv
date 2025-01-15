class alu_scoreboard extends uvm_scoreboard;

  `uvm_component_utils(alu_scoreboard)
  uvm_analysis_imp#(alu_seq_item, alu_scoreboard) alu_imp;

  logic [5:0]result;

  function new (string name ="alu_scoreboard", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    alu_imp = new("alu_imp", this);
  endfunction

  virtual function void write(alu_seq_item trans);
    //`uvm_info("SCB" , "Transaction recived",UVM_LOW);
    //trans.print();
    if(trans.opcode== 3'b000)
    begin
      if(trans.in1+trans.in2 == trans.result) begin
	`uvm_info(get_type_name(),$sformatf(" TEST PASS "),UVM_LOW)
	`uvm_info(get_type_name(),$sformatf(" Value of SUM = %0d", trans.result),UVM_LOW)
	$display("-----------------------------------------------------------------------------");
      end
      else begin
	`uvm_info(get_type_name(),$sformatf(" TEST FAILED  "),UVM_LOW)
      end
    end

    else if(trans.opcode==3'b001)
    begin
      if(trans.in1+(~trans.in2+1) == trans.result) begin
	`uvm_info(get_type_name(),$sformatf(" TEST PASS "),UVM_LOW)
	`uvm_info(get_type_name(),$sformatf(" Value of DIFFERENCE = %0d", trans.result),UVM_LOW)
	$display("-----------------------------------------------------------------------------");
      end
      else begin
	`uvm_info(get_type_name(),$sformatf(" TEST FAILED  "),UVM_LOW)
      end
    end

    else if(trans.opcode==3'b010)
    begin
      if(trans.in1 & trans.in2 == trans.result) begin
	`uvm_info(get_type_name(),$sformatf(" TEST PASS "),UVM_LOW)
	`uvm_info(get_type_name(),$sformatf(" Value of A & B = %0d", trans.result),UVM_LOW)
	$display("-----------------------------------------------------------------------------");
      end
      else begin
	`uvm_info(get_type_name(),$sformatf(" TEST FAILED  "),UVM_LOW)
      end
    end

    else if(trans.opcode==3'b011)
    begin
      if(trans.in1 | trans.in2 == trans.result) begin
	`uvm_info(get_type_name(),$sformatf(" TEST PASS "),UVM_LOW)
	`uvm_info(get_type_name(),$sformatf(" Value of A | B = %0d", trans.result),UVM_LOW)
	$display("-----------------------------------------------------------------------------");
      end
      else begin
	`uvm_info(get_type_name(),$sformatf(" TEST FAILED  "),UVM_LOW)
      end
    end

    else if(trans.opcode== 3'b100)
    begin
      if(trans.in1 ^ trans.in2 == trans.result) begin
	`uvm_info(get_type_name(),$sformatf(" TEST PASS "),UVM_LOW)
	`uvm_info(get_type_name(),$sformatf(" Value of A ^ B = %0d", trans.result),UVM_LOW)
	$display("-----------------------------------------------------------------------------");
      end
      else begin
	`uvm_info(get_type_name(),$sformatf(" TEST FAILED  "),UVM_LOW)
      end
    end

    else if(trans.opcode== 3'b101)
    begin
      if(trans.in1 << trans.in2 == trans.result) begin
	`uvm_info(get_type_name(),$sformatf(" TEST PASS "),UVM_LOW)
	`uvm_info(get_type_name(),$sformatf(" Value of A sll B = %0d", trans.result),UVM_LOW)
	$display("-----------------------------------------------------------------------------");
      end
      else begin
	`uvm_info(get_type_name(),$sformatf(" TEST FAILED  "),UVM_LOW)
      end
    end

    else if(trans.opcode== 3'b110)
    begin
      if((trans.in1 >> trans.in2) == trans.result) begin
	`uvm_info(get_type_name(),$sformatf(" TEST PASS "),UVM_LOW)
	`uvm_info(get_type_name(),$sformatf(" Value of A srl B = %0d", trans.result),UVM_LOW)
	$display("-----------------------------------------------------------------------------");
      end
      else begin
	`uvm_info(get_type_name(),$sformatf(" TEST FAILED  "),UVM_LOW)
      end
    end

    else if(trans.opcode== 3'b111)
    begin
      //circular_shift();
      if(trans.result) begin
	`uvm_info(get_type_name(),$sformatf(" TEST PASS "),UVM_LOW)
	`uvm_info(get_type_name(),$sformatf(" Value after circular shift = %0d", trans.result),UVM_LOW)
	$display("-----------------------------------------------------------------------------");
      end
      else begin
	`uvm_info(get_type_name(),$sformatf(" TEST FAILED  "),UVM_LOW)
      end
    end

    else begin
      `uvm_info(get_type_name(),$sformatf(" DEFAULT VALUE IS INITIATED  "),UVM_LOW)
    end

  endfunction
  /*task circular_shift();
  logic [4:0]temp1;
  temp1 = trans.in1;

  for (int i = 0; i < trans.in2; i = i + 1) begin
    temp1 = {temp1[3:0], trans.in1[4-i]};
  end
  result = temp1;
  endtask*/
endclass
