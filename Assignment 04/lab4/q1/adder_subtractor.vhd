library ieee;
use ieee.std_logic_1164.ALL;
 
entity adder_subtractor is
port ( a, b: in std_logic_vector (3 downto 0);
		 sel: in std_logic_vector (2 downto 0);
		 result: out std_logic_vector (7 downto 0));
end entity;
 
architecture adder_subtractor_arch of adder_subtractor is
 
component Partial_Adder
	port ( a,b,cin:in std_logic; s,p,g:out std_logic);
end component;
 
signal input,cout: std_logic;
signal in1,in2,c,P,G,S: std_logic_vector(3 downto 0);
begin
input <= (not sel(2)) and (not sel(1));
c(0) <= sel(0);

in1 <= a;
in2(3) <= (c(0) and (not b(3))) or ((not c(0)) and b(3));
in2(2) <= (c(0) and (not b(2))) or ((not c(0)) and b(2));
in2(1) <= (c(0) and (not b(1))) or ((not c(0)) and b(1));
in2(0) <= (c(0) and (not b(0))) or ((not c(0)) and b(0));
 
Inst1: Partial_Adder
	port map( in1(0), in2(0), c(0), S(0), P(0), G(0));
Inst2: Partial_Adder
	port map( in1(1), in2(1), c(1), S(1), P(1), G(1));
Inst3: Partial_Adder
	port map( in1(2), in2(2), c(2), S(2), P(2), G(2));
Inst4: Partial_Adder
	port map( in1(3), in2(3), c(3), S(3), P(3), G(3));
 
c(1) <= G(0) or (P(0) and c(0));
c(2) <= G(1) or (P(1) and G(0)) or (P(1) and P(0) and c(0));
c(3) <= G(2) or (P(2) and G(1)) or (P(2) and P(1) and G(0)) or (P(2) and P(1) and P(0) and c(0));
cout <= G(3) or (P(3) and G(2)) or (P(3) and P(2) and G(1)) or (P(3) and P(2) and P(1) and G(0)) or (P(3) and P(2) and P(1) and P(0) and c(0));

result(0) <= S(0) and input;
result(1) <= S(1) and input;
result(2) <= S(2) and input;
result(3) <= S(3) and input;
result(4) <= cout and input;
result(5) <= '0';
result(6) <= '0';
result(7) <= '0';
end architecture;