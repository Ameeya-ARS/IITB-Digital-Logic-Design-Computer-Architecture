library ieee;
use ieee.std_logic_1164.all;

entity xor_1bit is
	port(a,b:in std_logic; c:out std_logic);
end entity;

architecture xor_1bit_arch of xor_1bit is
	signal not_a,not_b,p1,p2:std_logic;
begin
	not_a <= not a;
	not_b <= not b;
	p1 <= a and not_b;
	p2 <= b and not_a;
	c <= p1 or p2;
end architecture;