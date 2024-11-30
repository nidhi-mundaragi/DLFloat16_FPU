module float16_to_int32(
  input [15:0] float_in,
  output reg signed [31:0] int_out
);
  reg sign;
  reg [5:0] exponent;
  reg [9:0] mantissa; 
  reg signed [5:0] actual_exponent;
  reg signed [31:0] result;

  always @(*) begin
    // Extract fields
    sign = float_in[15];
    exponent = float_in[14:9];
    mantissa = {1'b1, float_in[8:0]}; 

    // Handle special cases
    if (exponent == 0) begin
      int_out = 0;
    end  
    else if (exponent == 6'b111111) begin
      // Infinity or NaN: saturate to max 32-bit signed integer
      int_out = sign ? -32'h80000000 : 32'h7FFFFFFF;
    end else begin
  
      actual_exponent = exponent - 31; // Unbias the exponent
      
      if (actual_exponent <=9) begin
        result = {23'b0, mantissa >> ( 9 - actual_exponent)};
        end else begin
        result = mantissa << (actual_exponent - 9);
      end 
    
      int_out = sign ? -result : result;

      // Clamp to 32-bit signed range
      if (int_out > 32'h7FFFFFFF) int_out = 32'h7FFFFFFF;
      if (int_out < -32'h80000000) int_out = -32'h80000000; 
    end
  end
endmodule
