LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY testbench IS
END testbench;
 
ARCHITECTURE behavior OF testbench IS 

    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT TrafficLightsController IS
    port (clk, rst, tr1, tr4: in std_logic;
			 r, g, y: out std_logic_vector (4 downto 0) );
    END COMPONENT;
	
   --Inputs
   signal rst : std_logic := '0';
	signal clk : std_logic := '0';
   signal tr1 : std_logic := '0';
	signal tr4 : std_logic := '0';

 	--Outputs
   signal r : std_logic_vector(4 downto 0);
   signal g : std_logic_vector(4 downto 0);
   signal y : std_logic_vector(4 downto 0);

   -- Clock period definitions
   constant clk_period : time := 1000 ms;
 
    

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: TrafficLightsController 
	PORT MAP (
			 clk => clk,
          rst => rst,
			 tr1 => tr1,
			 tr4 => tr4,
			 r => r,
          g => g,
          y => y
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   rst_process: process
	begin
		rst <= '1';
		wait for clk_period;
		rst <= '0';
		wait;
  end process;
  
  tr1_process: process
  begin
		tr1 <= '1';
		wait for 480*clk_period;
		tr1 <= '0';
		wait for 480*clk_period;
  end process;
  
  tr4_process: process
  begin
		tr4 <= '1';
		wait for 240*clk_period;
		tr4 <= '0';
		wait for 240*clk_period;
  end process;
  

END;