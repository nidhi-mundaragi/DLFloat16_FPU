module fp_int2float(
  input signed [31:0] in_int, 
    output reg [15:0] float_out  
);
    reg [5:0] exponent;   
    reg [8:0] mantissa;    
    reg sign;             
    reg [31:0] abs_input;
    
    always @(*) begin
       
      if (in_int == 16'b0) begin
        float_out = 16'b0;
      end
      else if (in_int == 16'hFFFF) begin
        float_out = 16'hFFFF;
      end
      else begin
      sign = (in_int < 0) ? 1 : 0;
        
      //determine absolute value
      abs_input = (in_int < 0) ? -in_int : in_int;
        
        // Normalize the number 
        exponent = 0;
        mantissa = 0;
        
      // Find the exponent (shift the number to be in the form 1.xxxx)
        while (abs_input >= (1 << (exponent + 1))) begin
            exponent = exponent + 1;
        end
        
        // Shift the number to form the normalized mantissa
        mantissa = abs_input << (9 - exponent);
        
        //Bias the exponent 
        exponent = exponent + 31;
        
      float_out = {sign,exponent,mantissa};
      end
    end
endmodule
