library ieee;
use ieee.std_logic_1164.all;
entity xor_gate is
	port(in1,in2: in std_logic; out1: out std_logic);
end entity;
architecture xor_arch of xor_gate is
	signal p,q,not_x,not_y: std_logic;
	component and_gate
		port(a,b: in std_logic; c: out std_logic);
	end component;
	component or_gate
		port(x,y: in std_logic; z: out std_logic);
	end component;
	component not_gate
		port(a: in std_logic; b: out std_logic);
	end component;
begin
	NotInst1: not_gate
		port map(in1,not_x);
	NotInst2: not_gate
		port map(in2,not_y);
	AndInst1: and_gate
		port map(in1,not_y,p);
	AndInst2: and_gate
		port map(not_x,in2,q);
	OrInst1: or_gate
		port map(p,q,out1);
end architecture;

library ieee;
use ieee.std_logic_1164.all;
entity and_gate is
	port(a,b: in std_logic; c: out std_logic);
end entity;
architecture and_arch of and_gate is
begin
	c <= a and b;
end architecture;

library ieee;
use ieee.std_logic_1164.all;
entity not_gate is
	port(a: in std_logic; b: out std_logic);
end entity;
architecture not_arch of not_gate is
begin
	b <= not a;
end architecture;