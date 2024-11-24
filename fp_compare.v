module fp_compare( input [15:0] a1,
                  input [15:0] b1,
                  input [1:0] opcode,
                  input clk,
    
                  output reg [15:0] c_out
                 );
  wire lt_80,gt_80,eq_80;
  wire [15:0] c_1;
  
  compare fp_comp ( a1,b1,lt_80,gt_80,eq_80 );
  
  compare_out comp_out ( lt_80,gt_80,eq_80,opcode,c_1);


 always @(posedge clk) begin
  c_out <= c_1;
  
 end
  
endmodule



module compare( input [15:0]in1,
               input [15:0]in2,
               output reg lt,
               output reg eq,
               output reg gt
              );
  
  reg s1, s2;
  reg [5:0] exp1, exp2;  
  reg [8:0] mant1, mant2;
  
  always @(*) begin
    
    s1 = in1[15];
    s2 = in2[15];
    exp1 = in1[14:9];
    exp2 = in2[14:9];
    mant1 = in1[8:0];
    mant2 = in2[8:0];
    lt=0;
    gt=0;
    eq=0;
    
    if(s1 != s2) begin
      if(s1) begin
        lt = 1;
      end else begin
        gt = 1;
      end
    end 
    else begin
      if(exp1 > exp2) begin
         gt = !s1;
         lt = s1;
      end
      else if (exp1 < exp2) begin
        lt = !s1;
        gt = s1;
      end
      else begin
        if(mant1 > mant2) begin
          gt = !s1;
          lt = s1;
        end 
        else if (mant1 < mant2) begin
          lt = !s1;
          gt = s1;
        end
        else begin
          eq = 1;
        end
      end
    end
  end
    
endmodule
    
module compare_out ( 
      input lt,gt,eq,
      input [1:0] opcode,
      output reg [15:0] out 
    );
      
      always @(*) begin
        case (opcode)
          2'b00: out = {16{lt}}; 
          2'b01: out = {16{gt}};
          2'b10: out = {16{eq}};
          default: out = 16'b0;
        endcase
      end
endmodule
    
