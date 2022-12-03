library ieee;
use ieee.std_logic_1164.all;

entity bitwiseNAND is
port ( a,b : in std_logic_vector(3 downto 0);
		 sel: in std_logic_vector (2 downto 0);
       result : out std_logic_vector(7 downto 0));
end entity;

architecture bitwiseNAND_arch of bitwiseNAND is
signal input: std_logic;
signal final: std_logic_vector(7 downto 0);
	component nand_1bit
		port(a,b: in std_logic; c:out std_logic);
	end component;
begin
	input <= (sel(2)) and (not sel(1)) and (not sel(0));
	Inst1:nand_1bit
		port map(a(3),b(3),final(3));
	Inst2:nand_1bit
		port map(a(2),b(2),final(2));
	Inst3:nand_1bit
		port map(a(1),b(1),final(1));
	Inst4:nand_1bit
		port map(a(0),b(0),final(0));
		
	result(3) <= final(3) and input;
	result(2) <= final(2) and input;
	result(1) <= final(1) and input;
	result(0) <= final(0) and input;
	
	result(7) <= '0';
	result(6) <= '0';
	result(5) <= '0';
	result(4) <= '0';
end architecture;
