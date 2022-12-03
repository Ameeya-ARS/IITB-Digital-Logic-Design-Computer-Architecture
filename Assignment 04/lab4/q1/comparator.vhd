library ieee;
use ieee.std_logic_1164.all;

entity comparator is

port (a, b : in  std_logic_vector(3 downto 0);
		sel: in std_logic_vector (2 downto 0);
		result: out std_logic_vector (7 downto 0));

end entity;

architecture comparator_arch of comparator is
signal s : std_logic_vector(3 downto 0);
signal input: std_logic;
signal final: std_logic_vector(7 downto 0);
begin 
input <= (not sel(2)) and (sel(1)) and (sel(0));

s(0)<= (a(0) and b(0)) or ((not a(0)) and (not b(0)));
s(1)<= (a(1) and b(1)) or ((not a(1)) and (not b(1)));
s(2)<= (a(2) and b(2)) or ((not a(2)) and (not b(2)));
s(3)<= (a(3) and b(3)) or ((not a(3)) and (not b(3)));

final(1)<=s(3) and s(2) and s(1) and s(0);

final(2)<=(a(3) and (not b(3))) or
    (s(3) and a(2) and (not b(2))) or
    (s(3) and s(2) and a(1)and (not b(1))) or
    (s(3) and s(2) and s(1) and a(0) and (not b(0)));

final(0)<=(b(3) and (not a(3))) or
    (s(3) and b(2) and (not a(2)))or
    (s(3) and s(2) and b(1)and (not a(1))) or
    (s(3) and s(2) and s(1) and b(0) and (not a(0)));
	 
	result(2) <= final(2) and input;
	result(1) <= final(1) and input;
	result(0) <= final(0) and input;
	
	result(7) <= '0';
	result(6) <= '0';
	result(5) <= '0';
	result(4) <= '0';
	result(3) <= '0';

end architecture;