library ieee;
use ieee.std_logic_1164.all;

entity nand_1bit is
	port(a,b:in std_logic; c:out std_logic);
end entity;

architecture nand_1bit_arch of nand_1bit is
	signal s:std_logic;
begin
	s <= a and b;
	c <= not s;
end architecture;