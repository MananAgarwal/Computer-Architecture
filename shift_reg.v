module shiftreg(en, in, clk, q);
        input en, in, clk;
        output [0:3] q;
        reg [0:3] q;

        initial
        q=4'd10;

        always @(posedge clk)
        begin
                if(en) begin
                        q[3] <= q[2];
                        q[2] <= q[1];
                        q[1] <= q[0];
                        q[0] <= in;
                end
        end
endmodule

module tb_shiftreg;
        reg en, in, clk;
        wire [0:3]q;
        integer i;
        reg [15:0] sequ;

        shiftreg sh(en,in,clk,q);

        initial
        begin
                clk = 0;
                en = 1;
                sequ = 16'b0010_1110_0111_1011;
                for(i=0; i<16; i=i+1)
                        begin
                                in = sequ[i];
                                #2 clk = 1;
                                #2 clk = 0;
                                $display("Q values: %b", q);
                        end
        end
endmodule
