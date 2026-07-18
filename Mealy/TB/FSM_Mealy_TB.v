module FSM_pattern_tb( );
reg clk, reset, in;
wire out;

FSM_pattern_mealy dut (     //instantiation of the FSM module
                .clk (clk), 
                .reset (reset), 
                .in (in), 
                .out (out));

always #5 clk=~clk; //to generate clock with period of 10 time units

task send_bits (input i ); //to send input bits to the FSM
begin
@(negedge clk);
in <= i;
end
endtask

always@ (posedge clk)
begin
$strobe("time %t | input %b | state %b | output %b ", $time, in, dut.state, out);
end


initial begin

clk=0; reset=1; in = 0;
#12 reset = 0;

// Input sequence:
// 10110111011

send_bits (1);
send_bits (0);
send_bits (1);
send_bits (1);
send_bits (0);
send_bits (1);
send_bits (1);
send_bits (1);
send_bits (0);
send_bits (1);
send_bits (1);


#20 $finish;

end
endmodule
