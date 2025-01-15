class alu_seq extends uvm_sequence#(alu_seq_item);
  //Registers ahb_seq with the factory
  `uvm_object_utils(alu_seq)

  function new (string name = "alu_seq");
    super.new(name);
  endfunction

  virtual task body();
    //Create the req seq item
    repeat(10) begin
    req = alu_seq_item::type_id::create("req");
    wait_for_grant();
    assert(req.randomize());
    send_request(req);
    wait_for_item_done();
    end

  endtask
/*
  virtual task body();
    //Create the req seq item
    req = alu_seq_item::type_id::create(“req”);
    start_item(req);
    assert(req.randomize());
    finish_item(req)
  endtask

  virtual task body();
    `uvm_do (req);
  endtask
  */
endclass
