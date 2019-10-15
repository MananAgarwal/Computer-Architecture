module controller(op, cs, pcWrite, pcWriteCond, IorD, memRead, memWrite, IRWrite ,memToReg, pcSource, ALUop, ALUsrcB, ALUsrcA, RegWrite, RegDst, ns);
	input [5:0] op;
	input [3:0] cs;
	output pcWrite, pcWriteCond, IorD, memRead, memWrite, IRWrite ,memToReg, ALUsrcA, RegWrite, RegDst, ns;
	output [1:0] pcSource, ALUop, ALUsrcB;
	output [3:0] ns;
	wire [9:0] curr;
	wire [5:0] currOP;
	
	assign curr[0] = ~cs[3]&~cs[2]&~cs[1]&~cs[0];
	assign curr[1] = ~cs[3]&~cs[2]&~cs[1]&cs[0];
	assign curr[2] = ~cs[3]&~cs[2]&cs[1]&~cs[0];
	assign curr[3] = ~cs[3]&~cs[2]&cs[1]&cs[0];
	assign curr[4] = ~cs[3]&cs[2]&~cs[1]&~cs[0];
	assign curr[5] = ~cs[3]&cs[2]&~cs[1]&cs[0];
	assign curr[6] = ~cs[3]&cs[2]&cs[1]&~cs[0];
	assign curr[7] = ~cs[3]&cs[2]&cs[1]&cs[0];
	assign curr[8] = cs[3]&~cs[2]&~cs[1]&~cs[0];
	assign curr[9] = cs[3]&~cs[2]&~cs[1]&cs[0];
	
	assign pcWrite = curr[0]|curr[9];
	assign pcWriteCond = curr[8];
	assign IorD = curr[3]|curr[5];
	assign IorD = cur[3] |cur[5];
	assign memRead = cur[0] | cur[3];
	assign memWrite = cur[5];
	assign IRWrite = cur[0];
	assign memToReg = cur[4];
	assign pcSource[1] = cur[9];
	assign pcSource[0] = cur[8];
	assign ALUop[1] = cur[6];
	assign ALUop[0] = cur[8];
	assign ALUsrcB[1] = cur[1] | cur[2];
	assign ALUsrcB[0] = cur[0] | cur[1];
	assign ALUsrcA = cur[2] | cur[6] | cur[8];
	assign RegWrite = cur[4] | cur[7];
	assign RegDst = cur[7];
	
	assign currOP[0] = ~op[5]&~op[4]&~op[3]&~op[2]&op[1]&~op[0];
	assign currOP[1] = ~op[5]&~op[4]&~op[3]&op[2]&~op[1]&~op[0];
	assign currOP[2] = ~op[5]&~op[4]&~op[3]&~op[2]&~op[1]&~op[0];
	assign currOP[3] = op[5]&~op[4]&op[3]&~op[2]&op[1]&op[0];
	assign currOP[4] = op[5]&~op[4]&~op[3]&~op[2]&op[1]&op[0];
	
	assign ns[3] = (curr[1]&currOP[0])|(curr[1]&currOP[1]);
	assign ns[2] = curr[3]|curr[6]|(curr[1]&currOP[2])|(curr[2]&currOP[3]); 
	assign ns[1] = curr[6]|(curr[1]&currOP[2])|(curr[1]&currOP[3])|(curr[1]&currOP[4])|(curr[2]&currOP[4]);
	assign ns[0] = curr[0]|curr[6]|(curr[1]&currOP[0])|(curr[2]&currOP[3])|(curr[1]&currOP[4]);

endmodule