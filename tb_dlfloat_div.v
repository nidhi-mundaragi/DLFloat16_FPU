`timescale 1ns/1ps

module tb_dlfloat_div;
    reg [15:0] a, b;
    reg clk, rst_n;
  wire [19:0] c_div;
  
    wire [4:0] exception_flags;

    // Instantiate the DUT
    dlfloat_div uut (
        .a(a),
        .b(b),
       .clk(clk),
        .rst_n(rst_n),
      .c_div(c_div),
      
       .exception_flags(exception_flags)
    );

    // Clock generation
  initial clk = 1;
    always #5 clk = ~clk;

    // Testbench logic
    initial begin
      $monitor("Time=%0t | a=%h | b=%h | c_div=%h | exceptions=%b ", 
                 $time, a, b, c_div, exception_flags);

        // Reset sequence
        rst_n = 0;
        #10 rst_n = 1;

        // Test Cases
        #20 a = 16'h3e00; b = 16'h0000;   // 1: +normal num /+0
        #20 a = 16'h3e00; b = 16'h8000;   // 2: +normal num /-0
        #20 a = 16'hbe00; b = 16'h0000;   // 3:-normal num /+0
        #20 a = 16'hbe00; b = 16'h8000;   // 4:-normal num /-0
        #20 a = 16'h0000; b = 16'h3e00;   // 5: +0/+normal num
        #20 a = 16'h0000; b = 16'hbe00;   //6: +0/-normal num
        #20 a = 16'h8000; b = 16'h3e00;   //7: -0/+normal num
        #20 a = 16'h8000; b = 16'hbe00;   // 8: -0/-normal num
        #20 a = 16'h7e00; b = 16'h3e00;   // 9:+inf/+nor
        #20 a = 16'h7e00; b = 16'hbe00;   //10:+inf/-nor 
        #20 a = 16'hfe00; b = 16'h3e00;   //11: -inf/+nor
        #20 a = 16'hfe00; b = 16'hbe00;   //12: -inf/-nor
        #20 a = 16'h0000; b = 16'h8000;   //13:+0/-0
        #20 a = 16'h0000; b = 16'h0000;   //14: +0/+0
        #20 a = 16'h8000; b = 16'h8000;   //15: -0/-0
        #20 a = 16'h8000; b = 16'h0000;   //16: -0/+0
        #20 a = 16'hfe00; b = 16'h7e00;   //17:-inf/+inf
        #20 a = 16'h7e00; b = 16'hfe00;   //18:+inf/-inf
        #20 a = 16'h7e00; b = 16'h7e00;   //19: +inf/+inf
        #20 a = 16'hfe00; b = 16'hfe00;   //20: -inf/-inf
        #20 a = 16'h3e00; b = 16'h7e00;   //21: 1/+inf
        #20 a = 16'h3e00; b = 16'hfe00;   //22: 1/-inf
        #20 a = 16'hbe00; b = 16'h7e00;   //23: -1/inf
        #20 a = 16'hbe00; b = 16'hfe00;   //24: -1/-inf
        #20 a = 16'hbe00; b = 16'h3e00;   //25: -1/1
        #20 a = 16'h4000; b = 16'h3e00;   //26: 2/1
        #20 a = 16'h3f00; b = 16'h4000;   //26: 1.5/2
       
        #20 $finish;
    end
endmodule
