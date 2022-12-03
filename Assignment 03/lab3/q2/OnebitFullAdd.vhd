library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity OnebitFullAdd is
port ( a, b, cin : in std_logic;
		sum, cout: out std_logic);
end entity;

architecture arch of OnebitFullAdd is
	signal sum1,carry1,carry2: std_logic;
	component or_gate
		port(x,y: in std_logic; z: out std_logic);
	end component;
	component one_bit_half_adder
		port(in1,in2: in std_logic; out_sum,out_carry: out std_logic);
	end component;
begin
	HalfAdderInst1: one_bit_half_adder
		port map(a,b,sum1,carry1);
	HalfAdderInst2: one_bit_half_adder
		port map(sum1,cin,sum,carry2);
	OrInst1: or_gate
		port map(carry1,carry2,cout);
		
end architecture;