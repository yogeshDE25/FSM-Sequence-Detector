module FSM_Moore_TB();
reg clk, reset, din;
wire z;

FSM_Pattern_det dut (
            .clk   (clk),
            .reset (reset),
            .din   (din), 
            .z     (z));

always #5 clk = ~clk; //to generate clock with period of 10 time units

task send_bit (input i); //to send input bits to the FSM
begin
@(negedge clk);
din <= i;
end
endtask

always@ (posedge clk) //to display the output at every positive edge of clock
begin
$strobe(" Time is %t | din is %b | state is %b | Output is %b", $time, din, dut.state, z );
end

initial begin 

clk = 0;
reset = 1; 
din = 0;

#12 reset = 0;

send_bit (1);
send_bit (0);
send_bit (1);
send_bit (1);
send_bit (0);
send_bit (1);
send_bit (1);
send_bit (1);
send_bit (0);
send_bit (1);
send_bit (1);

#15 $finish;

end
endmodule

//output 
//101101 -> input
//   ^
//   z=1 -> output
