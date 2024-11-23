odule fp_int2float(
  input signed [31:0] in_int, 
  input clk,
  input rst_n,
  output reg [15:0] float_out1  
);
    reg [5:0] exponent;   
    reg [8:0] mantissa;    
    reg sign;             
    reg [31:0] abs_input;
    reg [15:0] float_out;
    integer i;
    
    always @(posedge clk) begin
     if (rst_n) begin
       float_out1 <= 16'b0;
      end else begin
       float_out1 <= float_out;
      end
     end 
       
    always @(*) begin
      if (in_int == 32'b0) begin
        float_out = 16'b0;
      end
      
      sign = (in_int < 0) ? 1 : 0;
        
      //determine absolute value
      abs_input = (in_int < 0) ? -in_int : in_int;
        
        // Normalize the number 
        exponent = 0;
        mantissa = 0;
        
      // Find the exponent (shift the number to be in the form 1.xxxx)
       for (i = 0; i < 32 ; i = i + 1) begin
        if (abs_input >= (1 << (exponent + 1))) begin
            exponent = exponent + 1; 
        end
       end        
        // Shift the number to form the normalized mantissa
        if ( exponent <= 9) begin
          mantissa = abs_input << (9 - exponent);  // Left shift for +ve exp
           end else begin
             mantissa = abs_input >> (exponent - 9);// Right shift for -ve exp
           end

        
        //Bias the exponent 
        exponent = exponent + 31;
      
      float_out = {sign,exponent,mantissa};
      end 
    
endmodule
