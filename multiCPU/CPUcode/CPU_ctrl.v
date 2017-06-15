module CPU_ctrl(clk,rst,inst,RegDst,RegWrite,
ALUSrcA,ALUSrcB,ALUOp,PCSource,PCWriteCond,PCWrite,IorD,MemRead,MemWrite,MemtoReg,IRWrite, ALUoutCtrl
    );
input wire clk;
input wire [5:0] inst;
input wire rst;
output reg RegDst,RegWrite,ALUSrcA,PCWriteCond,PCWrite,IorD,MemRead,MemWrite,MemtoReg,IRWrite,ALUoutCtrl;
output reg [1:0] ALUSrcB;
output reg [1:0] ALUOp;
output reg [1:0] PCSource;
reg [3:0] state;
reg [3:0] nextstate;

initial begin
	state <= 4'b1010;
	nextstate <= 4'b0001;
	RegDst <= 0;
	RegWrite <= 0;
	ALUSrcA <= 0;
	ALUSrcB <= 0;
	ALUOp  <= 0;
	PCSource <= 0;
	PCWriteCond <= 0;
	PCWrite <= 0;
	IorD <= 0;
	MemRead <= 0;
	MemWrite <= 0;
	MemtoReg <= 0;
	IRWrite <= 0;
	ALUoutCtrl <= 0;
end

always@(posedge clk or posedge rst)begin
	if(rst)
		state <= 10;
	else
		state <= nextstate;
end

always@(posedge clk or posedge rst)begin
	if(rst)begin
		nextstate = 1;
	end
	else
		case(state)
			0: begin
				MemRead   = 1;
				MemWrite  = 0;
				ALUSrcA   = 0;
				IorD      = 0;
				IRWrite   = 1;
				ALUSrcB   = 2'b01;
				ALUOp     = 2'b00;
				PCWrite   = 0;
				PCSource  = 2'b01;
				
				ALUoutCtrl= 1;
				RegDst    = 0;
				RegWrite  = 0;
				PCWriteCond = 0;
				MemtoReg  = 0;
				nextstate = 11;
			end
			1:	begin
				PCWrite   = 0;
				ALUSrcA   = 0;
				ALUSrcB   = 2'b11;
				ALUOp     = 2'b00;
				case (inst)
					6'b000000:nextstate = 6;
					6'b100011:nextstate = 2;
					6'b101011:nextstate = 2;
					6'b000100:nextstate = 8;
					6'b000010:nextstate = 9;
					endcase
			end
			2:	begin
				ALUSrcA   = 1;
				ALUSrcB   = 2'b10;
				ALUOp     = 2'b00;
				case (inst)
					6'b100011:nextstate = 3;
					6'b101011:nextstate = 5;
					endcase
			end
			3: begin
				MemRead   = 1;
				MemWrite  = 0;
				IorD      = 1;
				IRWrite   = 0;
				nextstate = 4;
			end
			4: begin
				RegDst    = 0;
				RegWrite  = 1;
				MemtoReg  = 1;
				nextstate = 0;
			end
			5:	begin
				MemWrite  = 1;
				MemRead   = 0;
				IorD      = 1;
				nextstate = 4;
			end
			6:	begin
				ALUSrcA   = 1;
				ALUSrcB   = 2'b00;
				ALUOp     = 2'b10;
				nextstate = 7;
			end
			7: begin
				RegDst    = 1;
				RegWrite  = 1;
				MemtoReg  = 0;
				nextstate = 0;
			end
			8:	begin
				ALUSrcA   = 1;
				ALUSrcB   = 2'b00;
				ALUOp     = 2'b01;
				PCWriteCond = 1;
				PCSource  = 2'b01;
				nextstate = 0;
			end
			9: begin
				PCWrite   = 1;
				PCSource  = 2'b10;
				nextstate = 0;
			end
			10:begin
				MemRead   = 1;
				MemWrite  = 0;
				ALUSrcA   = 0;
				IorD      = 0;
				IRWrite   = 1;
				ALUSrcB   = 2'b01;
				ALUOp     = 2'b00;
				PCWrite   = 0;
				PCSource  = 2'b00;
				nextstate = 1;
			end
			11:begin
				PCWrite   = 1;
				ALUoutCtrl= 0;
				nextstate = 1;
			end
			default:nextstate = 0;
		endcase
end

endmodule
