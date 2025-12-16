module judgePlatform;
	reg a, b, c;
	wire out;
	and gate1(tmp1, a, b);
	and gate2(tmp2, b, c);
	and gate3(tmp3, a, c);
	or gate4(tmp4, tmp1, tmp2);
	or gate5(out, tmp4, tmp3);

	initial
		begin
			a=0; b=0; c=0;
			#5 c=1;
			#5 c=0; b=1;
			#5 c=1;
			#5 a=1; b=0; c=0;
			#5 c=1;
			#5 b=1; c=0;
			#5 c=1;
			#5;
		end
	initial
		$monitor("A=%b, B=%b, C=%b, Out=%b", a, b, c, out);
endmodule
