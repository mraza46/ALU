interface aluif(input clk, input rst);
  logic [2:0]opcode;
  logic [4:0]in1;
  logic [4:0]in2;
  logic [5:0]result;
  //logic zero,cout,overflow;

  clocking icb @(posedge clk);
    //default input #1 output #1;
    //input zero;
    //input cout;
    //input overflow;
    input result;
    output opcode;
    output in1;
    output in2;
  endclocking

endinterface: aluif
