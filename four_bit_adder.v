module DECODER(d0,d1,d2,d3,d4,d5,d6,d7,x,y,z);
	input x,y,z;
	output d0,d1,d2,d3,d4,d5,d6,d7;
	wire x0,y0,z0;
	not n1(x0,x);
	not n2(y0,y);
	not n3(z0,z);
	and a0(d0,x0,y0,z0);
	and a1(d1,x0,y0,z);
	and a2(d2,x0,y,z0);
	and a3(d3,x0,y,z);
	and a4(d4,x,y0,z0);
	and a5(d5,x,y0,z);
	and a6(d6,x,y,z0);
	and a7(d7,x,y,z);
endmodule

module FADDER(s,c,x,y,z);
	input x,y,z;
	wire d0,d1,d2,d3,d4,d5,d6,d7;
	output s,c;
	DECODER dec(d0,d1,d2,d3,d4,d5,d6,d7,x,y,z);
	assign s = d1 | d2 | d4 | d7, c = d3 | d5 | d6 | d7;
endmodule

module FOURBIT(z,a,b);
	input [3:0]a,b;
	output [4:0]z;
	wire w0,wc0,wc1,wc2,wc3;
	assign w0 = 0;
	FADDER f1(z[0],wc0,w0,a[0],b[0]);
	FADDER f2(z[1],wc1,wc0,a[1],b[1]);
	FADDER f3(z[2],wc2,wc1,a[2],b[2]);
	FADDER f4(z[3],z[4],wc2,a[3],b[3]);
endmodule
	
module testbench;
	reg [3:0]x,y;
	wire [4:0]s;
	FOURBIT ffl(s,x,y);
	initial
		$monitor(,$time,"x=%b,y=%b,s=%b",x,y,s);
	initial
		begin
		#0 x=4'b0000;y=4'b0001;
		#4 x=4'b0001;y=4'b0001;
		#4 x=4'b0010;y=4'b1000;
		#4 x=4'b0011;y=4'b1100;
		#4 x=4'b0100;y=4'b0000;
		#4 x=4'b0101;y=4'b0111;
		#4 x=4'b0110;y=4'b1111;
		#4 x=4'b0111;y=4'b1111;
		end
	initial
		begin
		$dumpfile("filename.vcd");
		$dumpvars;
		end
endmodule
