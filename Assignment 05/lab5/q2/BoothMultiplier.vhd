library ieee;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all;

entity BoothMultiplier is
port (clk, rst : in std_logic;
		a, b : in std_logic_vector (3 downto 0);
		result : out std_logic_vector (7 downto 0) );
end entity;

architecture booth_arch of BoothMultiplier is
	signal res1,res2 : std_logic_vector(7 downto 0);
	signal i : std_logic;
	
begin

	process(clk)
	begin
		if(rising_edge(clk)) then
			if(rst='1') then
				i<='0';
				res1<="00000000"; res2<="00000000";
				result <= "00000000";
			else
				if(i='0') then
					if(b="0000") then
						res1 <= "00000000";
						res2 <= "00000000";
					elsif(b="0001") then
						res1 <= "0000" & a(3 downto 0);
						res2 <= "00000000";
					elsif(b="0010") then
						res1 <= "000" & a(3 downto 0) & '0';
						res2 <= "00000000";
					elsif(b="0011") then
						res1 <= ("0000" & a(3 downto 0)) + ("000" & a(3 downto 0) & '0');
						res2 <= "00000000";
					elsif(b="0100") then
						res1 <= "00000000";
						res2 <= "0000" & a(3 downto 0);
					elsif(b="0101") then
						res1 <= "0000" & a(3 downto 0);
						res2 <= "0000" & a(3 downto 0);
					elsif(b="0110") then
						res1 <= "000" & a(3 downto 0) & '0';
						res2 <= "0000" & a(3 downto 0);
					elsif(b="0111") then
						res1 <= ("0000" & a(3 downto 0)) + ("000" & a(3 downto 0) & '0');
						res2 <= "0000" & a(3 downto 0);
					elsif(b="1000") then
						res1 <= "00000000";
						res2 <= "000" & a(3 downto 0) & '0';
					elsif(b="1001") then
						res1 <= "0000" & a(3 downto 0);
						res2 <= "000" & a(3 downto 0) & '0';
					elsif(b="1010") then
						res1 <= "000" & a(3 downto 0) & '0';
						res2 <= "000" & a(3 downto 0) & '0';
					elsif(b="1011") then
						res1 <= ("0000" & a(3 downto 0)) + ("000" & a(3 downto 0) & '0');
						res2 <= "000" & a(3 downto 0) & '0';
					elsif(b="1100") then
						res1 <= "00000000";
						res2 <= ("0000" & a(3 downto 0)) + ("000" & a(3 downto 0) & '0');
					elsif(b="1101") then
						res1 <= "0000" & a(3 downto 0);
						res2 <= ("0000" & a(3 downto 0)) + ("000" & a(3 downto 0) & '0');
					elsif(b="1110") then
						res1 <= "000" & a(3 downto 0) & '0';
						res2 <= ("0000" & a(3 downto 0)) + ("000" & a(3 downto 0) & '0');
					elsif(b="1111") then
						res1 <= ("0000" & a(3 downto 0)) + ("000" & a(3 downto 0) & '0');
						res2 <= ("0000" & a(3 downto 0)) + ("000" & a(3 downto 0) & '0');
					end if;
					i<='1';
				else
					result <= res1 + (res2(5 downto 0) & "00");
					i<='0';
				end if;
			end if;
		end if;
	end process;

end architecture;