library ieee;
use ieee.std_logic_1164.all;

entity multiplier is
port ( a,b : in std_logic_vector(3 downto 0);
		 sel: in std_logic_vector (2 downto 0);
       result : out std_logic_vector(7 downto 0));
end entity;

architecture multiplier_arch of multiplier is
signal input,a0b0,a0b1,a0b2,a0b3,a1b0,a1b1,a1b2,a1b3,a2b0,a2b1,a2b2,a2b3,a3b0,a3b1,a3b2,a3b3: std_logic;
signal sha1,cha1,sha2,cha2,sha3,cha3,sha4,cha4: std_logic;
signal sfa1,sfa2,sfa3,sfa4,sfa5,sfa6,sfa7,sfa8: std_logic;
signal cfa1,cfa2,cfa3,cfa4,cfa5,cfa6,cfa7,cfa8: std_logic;
component one_bit_half_adder
	port(in1,in2: in std_logic; out_sum,out_carry: out std_logic);
end component;
component OnebitFullAdd
	port(a,b,cin:in std_logic; sum,cout:out std_logic);
end component;
begin
input <= (not sel(2)) and (sel(1)) and (not sel(0));

-- CALCULATING THE 4 ROWS OF NUMBERS TO BE ADDED
a0b0<=a(0) and b(0);  a0b1<=a(0) and b(1);  a0b2<=a(0) and b(2);  a0b3<=a(0) and b(3);
a1b0<=a(1) and b(0);  a1b1<=a(1) and b(1);  a1b2<=a(1) and b(2);  a1b3<=a(1) and b(3);
a2b0<=a(2) and b(0);  a2b1<=a(2) and b(1);  a2b2<=a(2) and b(2);  a2b3<=a(2) and b(3);
a3b0<=a(3) and b(0);  a3b1<=a(3) and b(1);  a3b2<=a(3) and b(2);  a3b3<=a(3) and b(3);

-- ADDITION USING HALF ADDERS AND FULL ADDERS
HA1 : one_bit_half_adder
	port map(a0b1,a1b0,sha1,cha1);
FA1 : OnebitFullAdd
	port map(a1b1,a2b0,cha1,sfa1,cfa1);
FA2 : OnebitFullAdd
	port map(a2b1,a3b0,cfa1,sfa2,cfa2);
HA2 : one_bit_half_adder
	port map(a3b1,cfa2,sha2,cha2);
HA3 : one_bit_half_adder
	port map(a0b2,sfa1,sha3,cha3);
FA3 : OnebitFullAdd
	port map(a1b2,sfa2,cha3,sfa3,cfa3);
FA4 : OnebitFullAdd
	port map(a2b2,sha2,cfa3,sfa4,cfa4);
FA5 : OnebitFullAdd
	port map(a3b2,cha2,cfa4,sfa5,cfa5);
HA4 : one_bit_half_adder
	port map(a0b3,sfa3,sha4,cha4);
FA6 : OnebitFullAdd
	port map(a1b3,sfa4,cha4,sfa6,cfa6);
FA7 : OnebitFullAdd
	port map(a2b3,sfa5,cfa6,sfa7,cfa7);
FA8 : OnebitFullAdd
	port map(a3b3,cfa5,cfa7,sfa8,cfa8);
	
-- FINAL ASSIGNMENT OF RESULT 
result(0) <= a0b0 and input;
result(1) <= sha1 and input;
result(2) <= sha3 and input;
result(3) <= sha4 and input;
result(4) <= sfa6 and input;
result(5) <= sfa7 and input;
result(6) <= sfa8 and input;
result(7) <= cfa8 and input;
end architecture;