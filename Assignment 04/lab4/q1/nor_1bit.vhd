library ieee;
use ieee.std_logic_1164.all;

entity nor_1bit is
	port(a,b:in std_logic; c:out std_logic);
end entity;

architecture nor_1bit_arch of nor_1bit is
	signal s:std_logic;
begin
	s <= a or b;
	c <= not s;
end architecture;