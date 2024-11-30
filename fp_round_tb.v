module fp_round_tb ();
  reg [19:0]in1;
  reg clk,rst_n;
  reg [2:0] rm;
  wire [15:0] out;
  
  fp_round_unit dut ( .in1(in1),
                     .clk(clk),
                     .rst_n(rst_n),
                     .rm(rm),
                     .out(out) );
  initial begin
    clk=0;
    forever #5 clk = ~clk;
  end
  
  initial begin
    rst_n=0;
    rm =3'b0;
    in1 =16'b0;
    
    #5 rst_n=1;
    
    #5 in1=20'b01011101111111111111;//65535 using truncation
       rm= 3'b011;
    #10; 
    $display("Input: %d, Output: %b", in1, out);
    
    $finish;
  end
endmodule
