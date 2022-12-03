library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RunLengthEncoder is
	port(clk, rst : in std_logic; input : in std_logic_vector (7 downto 0); output : out std_logic_vector (7 downto 0); data_valid : out std_logic ;sigkill : out std_logic);
end entity;

architecture RunLengthEncoder_arch of RunLengthEncoder is	
	signal ESC : std_logic_vector (7 downto 0) := "00011011";

begin

	process (clk, rst)
		variable cin : std_logic_vector (511 downto 0):= (others => '0');
		variable cout : std_logic_vector (1535 downto 0) := (others => '0');
		variable cin_read_idx, cin_write_idx : unsigned (9 downto 0) := "0000000000";
		variable cout_read_idx, cout_write_idx: unsigned (11 downto 0) := "000000000000";
		variable letter, next_letter : std_logic_vector (7 downto 0);
		variable count : unsigned (7 downto 0);
		variable sigterm : std_logic;
		variable eof : std_logic;		
		variable data_valid_proxy : std_logic;
	begin
		if rising_edge(clk) then
			if rst = '1' then
				next_letter := (others => '0');
				count := "00000000";
				sigkill <= '0';
				sigterm := '0';
				eof := '0';
				data_valid_proxy := '0';
			else 
				-- Take input
				if cin_write_idx <= 511 then
					for I in 0 to 7 loop
						cin(to_integer(cin_write_idx) + I) := input(I);
					end loop;
					cin_write_idx := cin_write_idx + 8;
				end if;
				
				-- report "cout" & integer'image(to_integer(unsigned(cout)));
				
				--  Give output
				if cout_read_idx < cout_write_idx then
					-- report "Attempting to print. cout_read_idx " & integer'image(to_integer(cout_read_idx));
					for I in 0 to 7 loop
						output(I) <= cout(to_integer(cout_read_idx)+I);
					end loop;
					data_valid_proxy := '1';
					cout_read_idx := cout_read_idx + 8;
				elsif sigterm = '1' then
					data_valid_proxy := '0';
					sigkill <= '1';
				else
					data_valid_proxy := '0';
				end if;

				-- Prepare for next cycle
				letter := next_letter;
				
				-- Read from input stream
				if cin_read_idx <= 511 then
					for I in 0 to 7 loop
						next_letter(I) := cin(to_integer(cin_read_idx)+I);
					end loop;
					-- report "cin_read_idx " & integer'image(to_integer(cin_read_idx));
					cin_read_idx := cin_read_idx + 8;
					-- report "cin_read_idx " & integer'image(to_integer(cin_read_idx));
					-- report "next letter " & integer'image(to_integer(unsigned(next_letter)));
					-- report "letter" & integer'image(to_integer(unsigned(letter)));
				else
					eof := '1';
				end if;
				
				-- Write to output stream
				if sigterm = '0' then
					if cin_read_idx = 8 then
						count := count + 1;
					elsif eof = '1' then
							if letter = ESC then
								for I in 0 to 7 loop
										cout(to_integer(cout_write_idx)+I) := ESC(I);
								end loop;
								cout_write_idx := cout_write_idx + 8;
								for I in 0 to 7 loop
										cout(to_integer(cout_write_idx)+I) := count(I);
								end loop;
								cout_write_idx := cout_write_idx + 8;
								for I in 0 to 7 loop
										cout(to_integer(cout_write_idx)+I) := ESC(I);
								end loop;
								cout_write_idx := cout_write_idx + 8;
							else
								if count > 2 then
									for I in 0 to 7 loop
										cout(to_integer(cout_write_idx)+I) := ESC(I);
									end loop;
									cout_write_idx := cout_write_idx + 8;
									for I in 0 to 7 loop
										cout(to_integer(cout_write_idx)+I) := count(I);
									end loop;
									cout_write_idx := cout_write_idx + 8;
									for I in 0 to 7 loop
										cout(to_integer(cout_write_idx)+I) := letter(I);
									end loop;
									cout_write_idx := cout_write_idx + 8;
									
								elsif count = 2 then
									for I in 0 to 7 loop
										cout(to_integer(cout_write_idx)+I) := letter(I);
									end loop;
									cout_write_idx := cout_write_idx + 8;
									for I in 0 to 7 loop
										cout(to_integer(cout_write_idx)+I) := letter(I);
									end loop;
									cout_write_idx := cout_write_idx + 8;
								else
									for I in 0 to 7 loop
										cout(to_integer(cout_write_idx)+I) := letter(I);
									end loop;
									cout_write_idx := cout_write_idx + 8;
								end if;
							end if;
						count := "00000000";
						sigterm := '1';
					else
						-- If same letter
						if next_letter = letter then
							if letter = ESC then
								if count < 6 then 
									count := count + 1;
								else
									for I in 0 to 7 loop
										cout(to_integer(cout_write_idx)+I) := ESC(I);
									end loop;
									cout_write_idx := cout_write_idx + 8;
									for I in 0 to 7 loop
										cout(to_integer(cout_write_idx)+I) := count(I);
									end loop;
									cout_write_idx := cout_write_idx + 8;
									for I in 0 to 7 loop
										cout(to_integer(cout_write_idx)+I) := letter(I);
									end loop;
									cout_write_idx := cout_write_idx + 8;
									
									count := "00000001";
								end if;
							else
								if count < 5 then 
									count := count + 1;
									-- report "AAAAAAAAAA";
								else
									-- report "BBBBBBBBBB";
									for I in 0 to 7 loop
										cout(to_integer(cout_write_idx)+I) := ESC(I);
									end loop;
									cout_write_idx := cout_write_idx + 8;
									for I in 0 to 7 loop
										cout(to_integer(cout_write_idx)+I) := count(I);
									end loop;
									cout_write_idx := cout_write_idx + 8;
									for I in 0 to 7 loop
										cout(to_integer(cout_write_idx)+I) := letter(I);
									end loop;
									cout_write_idx := cout_write_idx + 8;
									
									count := "00000001";
								end if;
							end if;
						else
							if letter = ESC then
								for I in 0 to 7 loop
										cout(to_integer(cout_write_idx)+I) := ESC(I);
								end loop;
								cout_write_idx := cout_write_idx + 8;
								for I in 0 to 7 loop
										cout(to_integer(cout_write_idx)+I) := count(I);
								end loop;
								cout_write_idx := cout_write_idx + 8;
								for I in 0 to 7 loop
										cout(to_integer(cout_write_idx)+I) := ESC(I);
								end loop;
								cout_write_idx := cout_write_idx + 8;
							else
								if count > 2 then
									for I in 0 to 7 loop
										cout(to_integer(cout_write_idx)+I) := ESC(I);
									end loop;
									cout_write_idx := cout_write_idx + 8;
									for I in 0 to 7 loop
										cout(to_integer(cout_write_idx)+I) := count(I);
									end loop;
									cout_write_idx := cout_write_idx + 8;
									for I in 0 to 7 loop
										cout(to_integer(cout_write_idx)+I) := letter(I);
									end loop;
									cout_write_idx := cout_write_idx + 8;
									
								elsif count = 2 then
									for I in 0 to 7 loop
										cout(to_integer(cout_write_idx)+I) := letter(I);
									end loop;
									cout_write_idx := cout_write_idx + 8;
									for I in 0 to 7 loop
										cout(to_integer(cout_write_idx)+I) := letter(I);
									end loop;
									cout_write_idx := cout_write_idx + 8;
								else
									for I in 0 to 7 loop
										cout(to_integer(cout_write_idx)+I) := letter(I);
									end loop;
									cout_write_idx := cout_write_idx + 8;
								end if;
							end if;
							count := "00000001";
						end if;
					end if;
				end if;
			end if;
		end if;
		data_valid <= data_valid_proxy and clk;
	end process;
	

end architecture; 