//moore FSM for sequence detector 1011
module FSM_Pattern_gen(reset, clk, din, z);
input wire reset, clk, din;
output reg z;
localparam idle = 3'b000, s1 = 3'b001, s10 = 3'b010, s101 = 3'b011, s1011 = 3'b111;
reg [2:0] state, next_state;

always@ (posedge clk or posedge reset) //state register
begin
    if (reset)
    state <= idle;
    else
    state <= next_state;
end

always@ (*) //next- state logic and moore output
begin
next_state = state;

z = 1'b0;

case(state)

idle: begin //no bits matched
if (din)
next_state = s1;
else
next_state = idle;
end

s1: begin //matched "1"
if (!din)
next_state = s10;
else
next_state = s1;
end

s10: begin //matched "10"
if (din)
next_state = s101;
else
next_state = idle;
end

s101: begin //matched "101"
if (din)
next_state = s1011;
else
next_state = s10;
end

s1011: begin //matched "1011"
z = 1'b1;
if (din)
next_state = s1;
else
next_state = s10;
end

default: begin
next_state = idle;
z = 1'b0;
end

endcase
end

endmodule
