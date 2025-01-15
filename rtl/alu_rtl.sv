module ALU(aluif alif);//(clk, rst,opcode,A,B,result);
/*  input clk, rst;
  input [2:0]opcode;
  input [4:0]A,B;
  output reg [5:0]result;
//  output reg zero,cout;
//  output reg overflow;
  */
  reg [4:0]temp1;
  integer i;

  always @(posedge alif.clk) begin
    if(alif.rst) begin
      alif.result <= 6'b0;
    end
    else begin
      case(alif.opcode)
        3'b000: alif.result <= alif.in1 + alif.in2;
        3'b001: alif.result <= alif.in1 - alif.in2;
        3'b010: alif.result <= alif.in1 & alif.in2;
        3'b011: alif.result <= alif.in1 | alif.in2;
        3'b100: alif.result <= alif.in1 ^ alif.in2;
        3'b101: alif.result <= alif.in1 << alif.in2;
        3'b110: alif.result <= alif.in1 >> alif.in2;
        3'b111: begin
          temp1=alif.in1;
          for(i=0; i<alif.in2; i++) begin
            temp1=temp1<<1;
            temp1[0]=alif.in1[4-i];
          end
          alif.result <= temp1;
        end
        default: alif.result<=6'b0;
      endcase
      
    end
  end
  
endmodule
