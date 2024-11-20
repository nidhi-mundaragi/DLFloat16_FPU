module fp_mult(a,b,c);
    input [15:0]a,b;
    output  reg [19:0]c;
    
    reg [9:0]ma,mb; //1 extra because 1.smthng
    reg [8:0] mant;
    reg [19:0]m_temp; //after multiplication
    reg [5:0] ea,eb,e_temp,exp;
    reg sa,sb,s;

   


  always @(*)
    begin 
        ma ={1'b1,a[8:0]};
        mb= {1'b1,b[8:0]};
        sa = a[15];
        sb = b[15];
        ea = a[14:9];
        eb = b[14:9];
        
        /*NOTE: If i remove this segment of checking for overflow/underflow :if the exponent is 64 it'll round to some 6 bit value and
        the Exception block will consider it as normal exponent */
        /* In this case We check for underflow/overflow for input also and send either flags to exception unit or push the result to some value 
        which the exception unit will identify as underflow/overflow */
        
        //checking for underflow/overflow
        if ( (ea + eb) <= 31) begin        
          c=20'b0;
        end
        else if ( (ea + eb) >= 94) begin
          c=20'hFFFFF;
        end
        else begin
        e_temp = ea + eb - 31;
            mant = m_temp[19] ? m_temp[18:6] : m_temp[17:5]; //taking 4 bits extra for rounding
        exp = m_temp[19] ? e_temp+1'b1 : e_temp;	
        s=sa ^ sb;
          //checking for special cases
         if( a==16'hFFFF | b==16'hFFFF ) begin
             c=20'hFFFFF;
          end
          else begin
             c = (a==0 | b==0) ? 0 :{s,exp,mant};
          end 
          
    end 
endmodule 
