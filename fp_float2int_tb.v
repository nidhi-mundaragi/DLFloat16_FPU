`timescale 1ns/1ps

module tb_float16_to_int32;
  reg [15:0] float_in;
  wire signed [31:0] int_out;

  // Instantiate the module under test
  float16_to_int32 uut (
    .float_in(float_in),
    .int_out(int_out)
  );

  // Task to display results
  task display_results;
    input [15:0] float_val;
    input signed [31:0] int_val;
    begin
      $display("Input Float: %b (Hex: %h), Output Int: %d", float_val, float_val, int_val);
    end
  endtask

  // Test the module
  initial begin
    $dumpfile("tb_float16_to_int32.vcd");
    $dumpvars(0, tb_float16_to_int32);

    // Test case 1: -5
    float_in = 16'b1100001010000000; 
    #10; // Wait for the result
    display_results(float_in, int_out);

    // Test case 2: +5
    float_in = 16'b0100001010000000; 
    #10; // Wait for the result
    display_results(float_in, int_out);

    // Test case 3: -11
    float_in = 16'b1100010011000000; // +0
    #10; // Wait for the result
    display_results(float_in, int_out);

    // Test case 4: -0
    float_in = 16'b1_000000_000000000; // -0
    #10; // Wait for the result
    display_results(float_in, int_out);

    // Test case 5: Max Positive Integer 
    float_in = 16'b0_111110_111111111; // Large positive number 
    #10; // Wait for the result
    display_results(float_in, int_out);

    // Test case 6: Min Negative Integer 
    float_in = 16'b1_111110_111111111; // Large negative number 
    #10; // Wait for the result
    display_results(float_in, int_out); 

    $finish;
  end
endmodule
