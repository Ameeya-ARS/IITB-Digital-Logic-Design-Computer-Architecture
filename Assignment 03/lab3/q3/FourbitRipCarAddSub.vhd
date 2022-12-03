library ieee;
use ieee.std_logic_1164.all;

entity FourbitRipCarAddSub is
port (a, b : in std_logic_vector (3 downto 0);
		cin: in std_logic;
		sum : out std_logic_vector (3 downto 0);
		cout: out std_logic);
end entity;

architecture four_bit_addsub_Arch of FourbitRipCarAddSub is
	signal p: std_logic_vector (3 downto 0);
	component FourbitRipCarAdd
		port (a, b : in std_logic_vector (3 downto 0);
				cin: in std_logic;
				sum : out std_logic_vector (3 downto 0);
				cout: out std_logic);
	end component;
	component xor_gate
		port(in1,in2: in std_logic; out1: out std_logic);
	end component;
begin
	XorInst1: xor_gate
		port map(b(0),cin,p(0));
	XorInst2: xor_gate
		port map(b(1),cin,p(1));
	XorInst3: xor_gate
		port map(b(2),cin,p(2));
	XorInst4: xor_gate
		port map(b(3),cin,p(3));
	Inst1: FourbitRipCarAdd
		port map(a,p,cin,sum,cout);
end architecture;