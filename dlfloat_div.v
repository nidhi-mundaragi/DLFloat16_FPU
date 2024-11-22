//+inf = 7e00, -inf = fe00, +NaN = 7fff, -Nan= ffff, +0 =0000, -0 =8000
module dlfloat_div(
    input [15:0] a, b,
    input clk, rst_n,
    output reg [19:0] c_div,         // 1-bit sign, 6-bit exponent, 13-bit mantissa
    output reg [4:0] exception_flags 
);
    reg [9:0] ma, mb;       
    reg [12:0] mant;        
  reg [15:0] m_temp;     
    reg [5:0] ea, eb, e_temp, exp;
    reg sa, sb, s;
    reg [19:0] c_div1;      

    // Flags
    reg div_by_zero, underflow, overflow, inexact, invalid;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            c_div <= 20'b0;
            exception_flags <= 5'b0;
        end else begin
            c_div <= c_div1;
            exception_flags <= {invalid, inexact, overflow, underflow, div_by_zero};
        end
    end

    always @(*) begin
        ma = {1'b1, a[8:0]}; 
        mb = {1'b1, b[8:0]}; 
        sa = a[15];
        sb = b[15];
        ea = a[14:9];
        eb = b[14:9];

        // Default values to avoid latch inference
        e_temp = 6'b0;
        m_temp = 16'b0;
        mant = 13'b0;
        exp = 6'b0;
        s = 0;
        c_div1 = 20'b0; 
        div_by_zero = 1'b0;
        underflow = 1'b0;
        overflow = 1'b0;
        inexact = 1'b0;
        invalid = 1'b0;

        // Special Cases
      if(( b == 16'b0 || b==16'b1000000000000000) &&(a==16'b0 || a==16'b1000000000000000))
            begin
              c_div1 = {sa ^sb,15'b111111111111111,4'b0};
              invalid = 1'b1;
            end
      
       else if (b == 16'b0 || b == 16'b1000000000000000) begin
            
            div_by_zero = 1'b1;
            c_div1 = {sa ^ sb, 6'b111111, 13'b0};
        end else if (a == 16'hfe00 || a == 16'h7e00) begin
            
          if (b == 16'hFe00 || b == 16'h7e00) begin
                
                invalid = 1'b1;
            c_div1 = {sa ^sb,15'b111111111111111,4'b0}; 
            end else begin
               
                c_div1 = {sa ^ sb, 6'b111111, 13'b0}; 
            end
        end else if (b == 16'hfe00 || b == 16'h7e00) begin
           
            c_div1 = {sa ^ sb, 19'b0};
        end else if (a == 16'b0 || a == 16'b1000000000000000) begin
            
          
            c_div1 = {sa ^ sb, 19'b0};
        end else begin
            
            e_temp = ea - eb + 31;
          m_temp = ma / mb; 
          if (m_temp[15]) begin
            mant = m_temp[14:2]; 
                exp = e_temp + 1'b1;
            end else begin
              mant = m_temp[13:1]; 
                exp = e_temp;
            end
            s = sa ^ sb;

            
          if (m_temp[3:0] != 4'b0) begin
                inexact = 1'b1;
            end

            // Check for underflow/overflow
            if (exp < 0) begin
                underflow = 1'b1;
                c_div1 = 20'b0; 
            end else if (exp > 63) begin
                overflow = 1'b1;
                c_div1 = s ? 20'hFDFE0 : 20'h7DFE0; 
            end else begin
                c_div1 = {s, exp, mant};
            end
        end
    end
endmodule
