library ieee;
use ieee.std_logic_1164.all;
entity xnor_gate is
	port(x,y: in std_logic; z: out std_logic);
end entity;
architecture xnor_arch of xnor_gate is
	signal p,q,not_x,not_y: std_logic;
	component and_gate
		port(a,b: in std_logic; c: out std_logic);
	end component;
	component or_gate
		port(a,b: in std_logic; c: out std_logic);
	end component;
	component not_gate
		port(a: in std_logic; b: out std_logic);
	end component;
begin
	NotInst1: not_gate
		port map(x,not_x);
	NotInst2: not_gate
		port map(y,not_y);
	OrInst1: or_gate
		port map(x,not_y,p);
	OrInst2: or_gate
		port map(not_x,y,q);
	AndInst1: and_gate
		port map(p,q,z);
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
entity or_gate is
	port(a,b: in std_logic; c: out std_logic);
end entity;
architecture or_arch of or_gate is
begin
	c <= a or b;
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