module bcd_to_grey (a,f);
	input [3:0]a;
	output [3:0]f;
	xor o1(f[0], a[0], a[1]);
	xor o2(f[1], a[1], a[2]);
	or(f[2], a[2], a[3]);
	assign f[3] = a[3];
endmodule

module testbench;
	reg [3:0]a;
	wire [3:0]f;
	bcd_to_grey grey(a,f);
	initial
		begin
			$monitor(,$time," a=%4b, f=%4b",a,f);
			#0 a=4'b0000;
				repeat(9)
			#10 a=a+4'b0001;
		end
endmodule