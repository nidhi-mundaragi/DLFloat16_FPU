module fp_comp_tb ();
  
  logic [15:0] a1,b1;
  logic [1:0]opcode;
  logic [15:0] c1;
  
  fp_compare dut ( .a1(a1),
                   .b1(b1),
                  .opcode(opcode),
                  .c1(c1)
                 );
  
  initial begin
    //Equaltiy instruction
    // Test Case 1: same sign positve
    a1 = 16'b0011111010100011; // a=1.32
    b1 = 16'b0100000001110011; // b=2.45 
    opcode =2'b00;
    #10;
    $display("Test case 1:  a = %b, b = %b, c = %b",a1, b1,c1);
     // Test Case 2: unequal sign
    a1 = 16'b1011111010100011; // a=-1.32
    b1 = 16'b0100000001110011; // b=2.45 
    opcode =2'b00;
    #10;
    $display("Test case 2:  a = %b, b = %b, c = %b",a1, b1,c1);
    //Test Case 3:  equal numbers 
     a1 = 16'b1011111010100011; // a=-1.32
     b1 = 16'b1011111010100011; // b=-1.32
    opcode =2'b00;
    #10;
    $display("Test case 3:  a = %b, b = %b, c = %b",a1, b1,c1);
    //Less Than instruction
   // Test Case 4
    a1 = 16'b0011111010100011; // a=1.32
    b1 = 16'b0100000001110011; // b=2.45 
    opcode =2'b01;
    #10;
    $display("Test case 4:  a = %b, b = %b, c = %b",a1, b1,c1); 
    // Test Case 5:
    a1 = 16'b0011111010100011; // a=1.32
    b1 = 16'b1100000001110011; // b=-2.45 
    opcode =2'b01;
    #10;
    $display("Test case 5: a = %b, b = %b, c = %b",a1, b1,c1);
    //greater than instruction
    //Test Case 6:  
     a1 = 16'b1011111010100011; // a=-1.32
     b1 = 16'b0011111010100011; // b= 1.32
    opcode =2'b10;
    #10;
    $display("Test case 6:  a = %b, b = %b, c = %b",a1, b1,c1);
    //Test Case 7:  
     a1 = 16'b0100000001110011; // a= 2.45
     b1 = 16'b0011111010100011; // b= 1.32
    opcode =2'b10;
    #10;
    $display("Test case 7:  a = %b, b = %b, c = %b",a1, b1,c1);
    //one input is zero
    a1=16'b0;
    b1=16'b0011111001000100;// b=1.13
    opcode = 2'b01;
    #10;
    $display("Test case 8:  a = %b, b = %b, c = %b",a1, b1,c1);
    //input is inf
    a1=16'hFFFF;
    b1= 16'hFFFF;
    opcode =2'b00;
    #10;
    $display("Test case 9:  a = %b, b = %b, c = %b",a1, b1,c1);
  
    #40 $finish;
end

endmodule
