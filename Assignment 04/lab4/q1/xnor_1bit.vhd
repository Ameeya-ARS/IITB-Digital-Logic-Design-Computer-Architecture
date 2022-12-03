library ieee;
use ieee.std_logic_1164.all;

entity xnor_1bit is
	port(a,b:in std_logic; c:out std_logic);
end entity;

architecture xnor_1bit_arch of xnor_1bit is
	signal not_a,not_b,p1,p2:std_logic;
begin
	not_a <= not a;
	not_b <= not b;
	p1 <= a and b;
	p2 <= not_a and not_b;
	c <= p1 or p2;
end architecture;