library ieee;
use ieee.std_logic_1164.ALL;
 
entity Partial_Adder is
port ( a,b,cin:in std_logic; s,p,g:out std_logic);
end entity;
 
architecture Partial_Adder_arch of Partial_Adder is
signal w: std_logic;
begin
 
	w <= (a and (not b)) or ((not a) and b);
	s <= (w and (not cin)) or ((not w) and cin);
	p <= (a and (not b)) or ((not a) and b);
	g <= a and b;
 
end architecture;
