// Code your design here
module invert_sign(
  input [15:0] in1, 
  input [15:0] in2,  
  input [1:0] sel,
    output [15:0] out 
);
  always@(*)
    begin
      case(sel)
        begin
          2'b00: out = {~in1[15],in1[14:0]}; // invert
          2'b01: out = {in1[15],in2[14:0]}; // sign injection normalized
          2'b10: out = {~in1[15], in2[14:0]}; // sign injection inverse
          2'b11: out = {(in1[15] ^ in2[15),in2[14:0]}; //sign injection xor
        endcase
      end
endmodule
