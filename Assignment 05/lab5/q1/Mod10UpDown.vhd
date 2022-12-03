library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Mod10UpDown is
port (clk, rst, up : in std_logic;
		count: out std_logic_vector (3 downto 0) );
end entity;

architecture updown_arch of Mod10UpDown is

signal result:std_logic_vector(3 downto 0);

begin
process(clk,rst)
begin
if rising_edge(clk) then
	if(rst='1')then
		result<="0000";
	else
		if(up ='1')then
			if (result = "1001") then
				result <= "0000";
			else
				result <= result+1;
			end if;
		else
			if (result = "0000") then
				result <= "1001";
			else
				result <= result-1;
			end if;
		end if;
	end if;
end if;
end process;

count<=result;
end architecture;