module testbench;
  reg signed [31:0] in;    
    wire [15:0] out;

    fp_int2float dut (
      .in_int(in),
      .float_out(out)
    );

    initial begin
        
        in = -5;
        #10; 
      $display("Input: %d, Output: %b", in, out);
      
        in = 5;
        #10; 
      $display("Input: %d, Output: %b", in, out);
      
       in = -10;
        #10; 
      $display("Input: %d, Output: %b", in, out);
     
       in = 0;
        #10; 
      $display("Input: %d, Output: %b", in, out);
      
       in = 65535;
        #10; 
      $display("Input: %d, Output: %b", in, out);

       
        $finish;
    end
endmodule
