module FSM_pattern_mealy(clk, reset, in, out);
input wire clk, reset, in;
output reg out;
reg [1:0] state, next_state;
localparam idle = 2'b00, s1 = 2'b01, s10 = 2'b10, s101 = 2'b11; //state encoding

always @(posedge clk or posedge reset)//state register

begin

if(reset)
state <= idle;
else
state <= next_state;

end

always @(*) //next - state logic

begin

case (state)
idle: next_state = in ? s1 : idle;  // no bits matched

s1: next_state = !in? s10 : s1; // matched "1"

s10: next_state = in ? s101 : idle; // matched "10"

// Matched "101"
// input=1 -> "1011" detected, overlap begins with last '1'
// input=0 -> last bits become "10"
s101: next_state = in ? s1 : s10;

default: next_state = idle;

endcase

end

always @(*) //output logic
begin

out = (state == s101) && in;

end

endmodule
