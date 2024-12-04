// Code your design here
module dl_decoder();
  input [31:0] instr;
  output [3:0] ena;
  output [2:0] rm;
  output [2:0] sel2;
  output op;
  output [1:0] sel1;
  
  wire [4:0] fun5;
  wire [6:0] opcode;
  
  assign opcode = instr[6:0];
  assign fun5 = instr[31:27];
  always@(*)
    
    begin
      rm = instr[14:12];
      ena = 4'b0000;
      op = 1'b0;
      sel = 2'b00;
      sel2 = 3'b000;
      if (opcode == 7'b1011011)
        begin
          case({fun5,rm})
            8'b00000xxx: begin op = 1'b0;
              ena = 4'b0001; end
            8'b00001xxx:begin op = 1'b1;
              ena = 4'b0001; end
            8'b00010xxx:begin ena = 4'b0010;
            end
            8'b00011xxx:begin ena = 4'b0011;
            end
            8'b01011xxx:begin ena = 4'b0100;
            end
            8'b00100000:begin ena = 4'b0101;
              sel = 2'b01;
            end
            8'b00100001: begin ena = 4'b0101;
              sel = 2'b10; end
            8'b00100010:begin ena = 4'b0101;
              sel = 2'b11; end
            8'b00101000: begin ena = 4'b0110;
              sel2 = 3'b001;//min
            end
            8'b00101001: begin ena = 4'b0110;
              sel2 = 3'b010;//max
            end
            8'b01000xxx:begin ena = 4'b0111;
            end
            8'b01001xxx:begin ena = 4'b1000;end
            8'b10100010: begin ena = 4'b0110;
              sel2 = 3'b011; end
            8'b10100001: begin ena = 4'b0110;
            sel2 = 3'b100;end
            8'b10100000: begin ena = 4'b0110;
              sel2 = 3'b101; end
          endcase
        end
      else(opcode ==7'bxxxxxxx)//fma
        begin
          ena = 4'b1001;
          op = 1'b0;
        end
      else(opcode == 7'bxxxxxxx)//fms
        begin 
          ena = 4'b1001;
          op = 1'b1;
        end
    end
endmodule
       
            
          
          
      
