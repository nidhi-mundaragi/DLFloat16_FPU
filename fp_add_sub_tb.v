module fp_add_sub_tb();
  
  logic [15:0]a,b;
  logic op; 
  logic [15:0]c_add;
  
  fp_add_sub dut(.a(a),
               .b(b),
               .op(op),
               .c_add(c_add)
              );
  
  initial begin
    logic [15:0]c1;
    
     //ADDITION
         

    // Test Case 1:same sign positve
    a = 16'b0011111010100011; // a=1.32
    b = 16'b0100000001110011; // b=2.45 
    c1 =16'b0100000111000100; // c1= 3.765
    op=0;
    #10;
    if (c_add == c1) 
      $display("Test case 1: PASS. a = %b, b = %b, c = %b, expected:%b", a, b, c_add,c1);
     else 
       $display("Test case 1: FAIL. a = %b, b = %b,  c = %b, expected: %b", a, b, c_add, c1); 
   
    // Test Case 2:same sign negative
     a = 16'b1011111010100011; // a=-1.32
    b = 16'b1100000001110011; // b=-2.45 
    c1 =16'b1100000111000100; // c1= -3.765
   #10;
    if (c_add == c1) 
      $display("Test case 2: PASS. a = %b, b = %b, c = %b, expected:%b", a, b, c_add,c1);
     else 
       $display("Test case 2: FAIL. a = %b, b = %b,  c = %b, expected: %b", a, b,c_add, c1); 
     // Test Case 3:different sign -ve<+ve
   a = 16'b1011111010100011; // a=-1.32
    b = 16'b0100000001110011; // b=2.45 
    c1 =16'b0011111001000100; // c1= 1.13
   #10;
    if (c_add == c1) 
      $display("Test case 3: PASS. a = %b, b = %b, c = %b, expected:%b", a, b,c_add,c1);
     else 
       $display("Test case 3: FAIL. a = %b, b = %b,  c = %b, expected: %b", a, b,c_add, c1); 
    // Test Case 4:different sign -ve>+ve
    a = 16'b0011111010100011; // a=1.32
    b = 16'b1100000001110011; // b=-2.45 
   c1 =16'b1011111001000100; // c1= -1.13
    #10;
    if (c_add == c1) 
      $display("Test case 4: PASS. a = %b, b = %b, c = %b, expected:%b", a, b, c_add,c1);
     else 
       $display("Test case 4: FAIL. a = %b, b = %b,  c = %b, expected: %b", a, b,c_add, c1);
     // Test Case 5:one operand is zero
    a = 16'b0000000000000000; // a=0
    b = 16'b0100000001110011; // b=2.45 
    c1 =16'b0100000001110011; // c1=2.45
    #10;
    if (c_add == c1) 
      $display("Test case 5: PASS. a = %b, b = %b, c = %b, expected:%b", a, b, c_add,c1);
     else 
       $display("Test case 5: FAIL. a = %b, b = %b,  c = %b, expected: %b", a, b,c_add, c1); 
     // Test Case 6:both are zero
     a = 16'b0000000000000000; // a=0
     b = 16'b0000000000000000; // b=0
    c1 = 16'b0000000000000000; // c1=0
    #10;
    if (c_add == c1) 
      $display("Test case 6: PASS. a = %b, b = %b, c = %b, expected:%b", a, b, c_add,c1);
     else 
       $display("Test case 6: FAIL. a = %b, b = %b,  c = %b, expected: %b", a, b,c_add, c1); 
     // Test Case 7:Nan and inf
    a = 16'b1111111111111111; // a=inf/nan
    b = 16'b0011111010100011; // b=1.32 
   c1 = 16'b1111111111111111; // c1=Nan
    #10;
    if (c_add == c1) 
      $display("Test case 7: PASS. a = %b, b = %b, c = %b, expected:%b", a, b,c_add,c1);
     else 
       $display("Test case 7: FAIL. a = %b, b = %b,  c = %b, expected: %b", a, b,c_add, c1); 
    
    
    
    //SUBTRACTION
        

    // Test Case 1:same sign positve
    a = 16'b0011111010100011; // a=1.32
    b = 16'b0100000001110011; // b=2.45 
    c1 =16'b1011111001000100; // c1= -1.13
    op=1;
    #10;
    if (c_add == c1) 
      $display("Test case 1: PASS. a = %b, b = %b, c = %b, expected:%b", a, b, c_add,c1);
     else 
       $display("Test case 1: FAIL. a = %b, b = %b,  c = %b, expected: %b", a, b, c_add, c1); 
   
    // Test Case 2:same sign negative
     a = 16'b1011111010100011; // a=-1.32
     b = 16'b1100000001110011; // b=-2.45 
    //c1 =16'b1100000111000100; // c1= -3.765
    c1 =16'b0011111001000100; // c1= 1.13
   #10;
    if (c_add == c1) 
      $display("Test case 2: PASS. a = %b, b = %b, c = %b, expected:%b", a, b, c_add,c1);
     else 
       $display("Test case 2: FAIL. a = %b, b = %b,  c = %b, expected: %b", a, b,c_add, c1); 
     // Test Case 3:different sign -ve<+ve
    a = 16'b1011111010100011; // a=-1.32
    b = 16'b0100000001110011; // b=2.45 
    c1 =16'b1100000111000100; // c1= -3.765
   #10;
    if (c_add == c1) 
      $display("Test case 3: PASS. a = %b, b = %b, c = %b, expected:%b", a, b,c_add,c1);
     else 
       $display("Test case 3: FAIL. a = %b, b = %b,  c = %b, expected: %b", a, b,c_add, c1); 
    // Test Case 4:different sign -ve>+ve
    a = 16'b0011111010100011; // a=1.32
    b = 16'b1100000001110011; // b=-2.45 
    c1 =16'b0100000111000100; // c1= 3.765
    #10;
    if (c_add == c1) 
      $display("Test case 4: PASS. a = %b, b = %b, c = %b, expected:%b", a, b, c_add,c1);
     else 
       $display("Test case 4: FAIL. a = %b, b = %b,  c = %b, expected: %b", a, b,c_add, c1);
     // Test Case 5:one operand is zero
    a = 16'b0000000000000000; // a=0
    b = 16'b0100000001110011; // b=2.45 
    c1 =16'b1100000001110011; // c1=-2.45
    #10;
    if (c_add == c1) 
      $display("Test case 5: PASS. a = %b, b = %b, c = %b, expected:%b", a, b, c_add,c1);
     else 
       $display("Test case 5: FAIL. a = %b, b = %b,  c = %b, expected: %b", a, b,c_add, c1); 
     // Test Case 6:both are zero
     a = 16'b0000000000000000; // a=0
     b = 16'b0000000000000000; // b=0
    c1 = 16'b0000000000000000; // c1=0
    #10;
    if (c_add == c1) 
      $display("Test case 6: PASS. a = %b, b = %b, c = %b, expected:%b", a, b, c_add,c1);
     else 
       $display("Test case 6: FAIL. a = %b, b = %b,  c = %b, expected: %b", a, b,c_add, c1); 
     // Test Case 7:Nan and inf
    a = 16'b1111111111111111; // a=inf/nan
    b = 16'b0011111010100011; // b=1.32 
   c1 = 16'b1111111111111111; // c1=Nan
    #10;
    if (c_add == c1) 
      $display("Test case 7: PASS. a = %b, b = %b, c = %b, expected:%b", a, b,c_add,c1);
     else 
       $display("Test case 7: FAIL. a = %b, b = %b,  c = %b, expected: %b", a, b,c_add, c1); 
   
  
  
    #240 $finish;
  end
  
  
endmodule
