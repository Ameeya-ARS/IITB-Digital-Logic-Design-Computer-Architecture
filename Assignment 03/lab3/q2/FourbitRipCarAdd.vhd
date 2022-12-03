library ieee;
use ieee.std_logic_1164.all;

entity FourbitRipCarAdd is
port (a, b : in std_logic_vector (3 downto 0);
		cin: in std_logic;
		sum : out std_logic_vector (3 downto 0);
		cout: out std_logic);
end entity;

architecture four_bit_add_Arch of FourbitRipCarAdd is
	signal p1,p2,p3: std_logic;
	component OnebitFullAdd
		port (a, b, cin : in std_logic;
				sum, cout: out std_logic);
	end component;
begin
	Inst1: OnebitFullAdd
		port map(a(0),b(0),cin,sum(0),p1);
	Inst2: OnebitFullAdd
		port map(a(1),b(1),p1,sum(1),p2);
	Inst3: OnebitFullAdd
		port map(a(2),b(2),p2,sum(2),p3);
	Inst4: OnebitFullAdd
		port map(a(3),b(3),p3,sum(3),cout);
end architecture;