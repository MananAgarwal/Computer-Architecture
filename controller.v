module controller(op, cs, pcWrite, pcwWriteCond, IorD, memRead, memWrite, IRWrite ,memToReg, pcSource, ALUop, ALUsrcB, ALUsrcA, RegWrite, RegDst, ns);
	input [5:0] op;
	input [3:0] cs;
	output pcWrite, pcwWriteCond, IorD, memRead, memWrite, IRWrite, memToReg, ALUsrcA, RegDst, RegWrite;
	output [1:0] pcSource, ALUsrcB, ALUop;
	output [3:0] ns;
	wire [9:0] cur;
	
	assign cur[0] = ~cs[3]&~cs[2]&~cs[1]&~cs[0];
	assign cur[1] = ~cs[3]&~cs[2]&~cs[1]&cs[0];
	assign cur[2] = ~cs[3]&~cs[2]& cs[1]&~cs[0];
	assign cur[3] = ~cs[3]&~cs[2]& cs[1]&cs[0];
	assign cur[4] = ~cs[3]& cs[2]&~cs[1]&~cs[0];
	assign cur[5] = ~cs[3]& cs[2]&~cs[1]&cs[0];
	assign cur[6] = ~cs[3]& cs[2]& cs[1]&~cs[0];
	assign cur[7] = ~cs[3]& cs[2]& cs[1]&cs[0];
	assign cur[8] =  cs[3]&~cs[2]&~cs[1]&~cs[0];
	assign cur[9] =  cs[3]&~cs[2]&~cs[1]&cs[0];
	assign pcWrite = cur[9] | cur[0];
	assign pcwWriteCond = cur[8];
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
	assign ns[3] = (~cs[3]&~cs[2]&~cs[1]&~cs[0])&(~op[5]&~op[4]&~op[3]&~op[2]& op[1]&~op[0]) | (~cs[3]&~cs[2]&~cs[1]&~cs[0])&(~op[5]&~op[4]&~op[3]& op[2]&~op[1]&~op[0]);
	assign ns[2] = cur[3] | cur[6] | (~cs[3]&~cs[2]& cs[1]&~cs[0])&( op[5]&~op[4]& op[3]&~op[2]& op[1]& op[0]) | (~cs[3]&~cs[2]&~cs[1]&cs[0])&(~op[5]&~op[4]&~op[3]&~op[2]&~op[1]&~op[0]);
	assign ns[1] = cur[6] | (~cs[3]&~cs[2]&~cs[1]&cs[0])&(op[5]&~op[4]&~op[3]&~op[2]& op[1]&op[0]) | (~cs[3]&~cs[2]&~cs[1]&cs[0])&(op[5]&~op[4]&op[3]&~op[2]& op[1]&op[0])| (~cs[3]&~cs[2]&~cs[1]&cs[0])&(~op[5]&~op[4]&~op[3]&~op[2]&~op[1]&~op[0])|(~cs[3]&~cs[2]& cs[1]&~cs[0])&(op[5]&~op[4]&~op[3]&~op[2]& op[1]&op[0]);
	assign ns[0] = cur[0] | cur[6] | (~cs[3]&~cs[2]&~cs[1]&~cs[0])&(~op[5]&~op[4]&~op[3]&~op[2]& op[1]&~op[0]) | (~cs[3]&~cs[2]& cs[1]&~cs[0])&( op[5]&~op[4]& op[3]&~op[2]& op[1]& op[0]) | (~cs[3]&~cs[2]& cs[1]&~cs[0])&(op[5]&~op[4]&~op[3]&~op[2]& op[1]&op[0]);
	
endmodule
	