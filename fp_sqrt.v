module dlfloat16_sqrt (
    input  [15:0] dl_in,              
    output reg [19:0] dl_out,         
    output reg [4:0] exception_flags  
);
    wire sign = dl_in[15];                
    wire [5:0] exp_in = dl_in[14:9];      
    wire [8:0] mant_in = dl_in[8:0];      

   
    wire [9:0] mant_norm = (exp_in == 0) ? {1'b0, mant_in} : {1'b1, mant_in};

   
    reg [5:0] exp_out;      
    reg [12:0] mant_sqrt;    
    integer i;

   
    reg invalid, overflow, underflow, inexact;
    wire div_by_zero = 1'b0;

    always @(*) begin
       
        invalid = 0;
        overflow = 0;
        underflow = 0;
        inexact = 0;

        //special cases
        if (dl_in == 16'h0000) begin
            // Zero input
            dl_out = 20'h00000;  // Output is zero
        end else if (sign == 1'b1) begin
            // Negative input
            dl_out = 20'hFFFFF;  // NaN representation
            invalid = 1'b1;
        end else begin
            // Adjust exponent (divide by 2 and handle bias)
            if (exp_in == 6'b0) begin
                exp_out = 6'b0;  // Denormalized input
            end else begin
                exp_out = ((exp_in - 31) >> 1) + 31;
            end

            // Iterative approximation for square root of mantissa
            mant_sqrt = 13'b0;
            for (i = 12; i >= 0; i = i - 1) begin
                if ((mant_sqrt | (1 << i)) * (mant_sqrt | (1 << i)) <= (mant_norm << 3)) begin
                    mant_sqrt = mant_sqrt | (1 << i);
                end
            end

            // Check for inexact result
            if (mant_sqrt * mant_sqrt != (mant_norm << 3)) begin
                inexact = 1'b1;
            end

            // Check for overflow and underflow
            if (exp_out > 6'b111110) begin
                overflow = 1'b1;
                dl_out = 20'h7DFE0;  
            end else if (exp_out == 6'b0 && mant_sqrt == 13'b0) begin
                underflow = 1'b1;
                dl_out = 20'h00000;  
            end else begin
            
                dl_out = {1'b0, exp_out, mant_sqrt};
            end
        end

       
        exception_flags = {invalid, inexact, overflow, underflow, div_by_zero};
    end
endmodule
