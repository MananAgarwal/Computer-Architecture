module sync_counter(clk,q);
        input clk;
        output [3:0] q;
        reg [3:0] q;

        initial
                q = 4'b0000;

        always @(posedge clk)
        begin
                q[0] <= ~q[0];
                if(q[0])
                        q[1] <= ~q[1];
                if(q[0]&q[1])
                        q[2] <= ~q[2];
                if(q[0]&q[1]&q[2])
                        q[3] <= ~q[3]; 
        end
endmodule

module tb_sync_counter;
        reg clk;
        wire [3:0] q;

        sync_counter sc(clk,q);

        initial
        begin
                clk = 0;
                // #20 $finish;
        end

        always
                #1 clk = ~clk;

        always @ (posedge clk)
        begin
                $display($time," %d",q);
                if(q == 15)
                        #1 $finish;
        end

endmodule
        
