//`include "pkg.sv"
import uvm_pkg::*;
`include "uvm_macros.svh"

module tb_top;
   
  //clock and reset signal declaration
  bit clk;
  bit rst;
 
  //clock generation
  always #5 clk = ~clk;
   
  //reset Generation
  initial begin
    rst = 1;
    #5 rst =0;
  end
  
  aluif alif(clk,rst);
  
     ALU DUT(alif);
   			  /*.clk(clk),
    		  .rst(rst),
    		  .A(alif.in1),
    		  .B(alif.in2),
    		  .result(alif.result),
   			  .opcode(alif.opcode)); */
  
  initial begin
    uvm_config_db#(virtual aluif)::set(null,"*","alif",alif);
  end
   
  initial begin
    run_test("alu_test");
  end
  
  initial begin
    $dumpfile("top.fsdb");
    $dumpvars(0, tb_top);
  end
endmodule
