module p1(out, a, b, c);	// P1, P1=!A * !B * !C
	input a, b, c;
	output out;
	not gate1(net1, a);
	not gate2(net2, b);
	not gate3(net3, c);
	and gate4(and_result, net1, net2);
	and gate5(out, and_result, net3);
endmodule

module p2(out, a, b, c);	// P2, P2=A * B * C
	input a, b, c;
	output out;
	and gate1(net1, a, b);
	and gate2(out, net1, c);
endmodule

module or_module(out, a, b);	// Y, Y=P1 + P2
	input a, b;
	output out;
	or gate1(out, a, b);
endmodule

module testPlatform;	// For testing above models
	reg pa, pb, pc;
	wire pout, aout, bout;
	p1 module1(aout, pa, pb, pc);
	p2 moduel2(bout, pa, pb, pc);
	or_module module3(pout, aout, bout);
	initial
		begin
			pa=0; pb=0; pc=0;
			#5 pc=1;
			#5 pc=0; pb=1;
			#5 pc=1;
			#5 pa=1; pb=0; pc=0;
			#5 pc=1;
			#5 pb=1; pc=0;
			#5 pc=1;
			#5;
		end
	initial
		$monitor("time=%t, pa=%b, pb=%b, pc=%b, pout=%b", $time, pa, pb, pc, pout);
endmodule

	