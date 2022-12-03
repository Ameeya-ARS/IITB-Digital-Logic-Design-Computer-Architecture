library ieee;
use ieee.std_logic_1164.all;
entity nor_gate is
	port(x,y: in std_logic; z: out std_logic);
end entity;

architecture nor_arch of nor_gate is
	signal p: std_logic;
	component or_gate
		port(a,b: in std_logic; c: out std_logic);
	end component;
	component not_gate
		port(a: in std_logic; b: out std_logic);
	end component;
begin
	OrInst1: or_gate
		port map(x,y,p);
	NotInst1: not_gate
		port map(p,z);
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
	