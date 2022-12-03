library ieee;
use ieee.std_logic_1164.all;
entity nand_gate is
	port(x,y: in std_logic; z: out std_logic);
end entity;
architecture nand_arch of nand_gate is
	signal p: std_logic;
	component and_gate
		port(a,b: in std_logic; c: out std_logic);
	end component;
	component not_gate
		port(a: in std_logic; b: out std_logic);
	end component;
begin
	AndInst1: and_gate
		port map(x,y,p);
	NotInst1: not_gate
		port map(p,z);
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