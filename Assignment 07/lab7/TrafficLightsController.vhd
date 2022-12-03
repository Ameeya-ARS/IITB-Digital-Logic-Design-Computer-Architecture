LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY TrafficLightsController IS
	PORT (clk, rst, tr1, tr4: in std_logic;
			r, g, y: out std_logic_vector (4 downto 0) );
END ENTITY;

ARCHITECTURE arch OF TrafficLightsController IS
	 
	 signal state: integer range 0 to 11;
    signal count: integer := 1;
	 
begin

	seq: process(clk, tr1, tr4, rst, count)
	begin
		if rst='1' then
			state <= 0;
		elsif rising_edge(clk) then
			if state=3 and tr4='0' then
				if count = 55 then
					state <= 10;
					count <= 1;
				else 
					count <= count+1;
				end if;
			elsif state=7 and tr1='0' then
				if count = 55 then
					state <= 11;
					count <= 1;
				else 
					count <= count+1;
				end if;
			elsif state=10 then
				if count = 5 then
					state <= 7;
					count <= 1;
				else 
					count <= count+1;
				end if;
			elsif state=11 then
				if count = 5 then
					state <= 1;
					count <= 1;
				else 
					count <= count+1;
				end if;
			elsif state = 0 or state=2 or state=4 or state=6 or state=8 then
				if count = 5 then
					state <= (state + 1) mod 10;
					count <= 1;
				else
					count <= count+1;
				end if;
			elsif state = 1 or state=3 or state=7 then
				if count = 55 then
					state <= (state + 1) mod 10;
					count <= 1;
				else
					count <= count+1;
				end if;
			elsif state = 5 or state=9 then
				if count = 25 then
					state <= (state + 1) mod 10;
					count <= 1;
				else
					count <= count+1;
				end if;
			end if;
		end if;
	end process;
	
	comb: process (state)
   begin
		
      case state is
			when 0 =>
					r(4 downto 0) <= "11001";
					y(4 downto 0) <= "00010";
					g(4 downto 0) <= "00100";
				
			when 1 =>
					r(4 downto 0) <= "11011";
					y(4 downto 0) <= "00000";
					g(4 downto 0) <= "00100";
				
			when 2 =>
					r(4 downto 0) <= "10011";
					y(4 downto 0) <= "00100";
					g(4 downto 0) <= "01000";
					
			when 3 =>
					r(4 downto 0) <= "10111";
					y(4 downto 0) <= "00000";
					g(4 downto 0) <= "01000";
				
			when 4 =>
					r(4 downto 0) <= "00111";
					y(4 downto 0) <= "01000";
					g(4 downto 0) <= "10000";
				
			when 5 =>
					r(4 downto 0) <= "01111";
					y(4 downto 0) <= "00000";
					g(4 downto 0) <= "10000";
					
			when 6 =>
					r(4 downto 0) <= "01110";
					y(4 downto 0) <= "10000";
					g(4 downto 0) <= "00001";
					
			when 7 =>
					r(4 downto 0) <= "11110";
					y(4 downto 0) <= "00000";
					g(4 downto 0) <= "00001";
				
			when 8 =>
					r(4 downto 0) <= "11100";
					y(4 downto 0) <= "00001";
					g(4 downto 0) <= "00010";
			
			when 9 =>
					r(4 downto 0) <= "11101";
					y(4 downto 0) <= "00000";
					g(4 downto 0) <= "00010";
					
			when 10 =>
					r(4 downto 0) <= "10110";
					y(4 downto 0) <= "01000";
					g(4 downto 0) <= "00001";
			when 11 =>
					r(4 downto 0) <= "11010";
					y(4 downto 0) <= "00001";
					g(4 downto 0) <= "00100";
		end case;
	end process;

END ARCHITECTURE;