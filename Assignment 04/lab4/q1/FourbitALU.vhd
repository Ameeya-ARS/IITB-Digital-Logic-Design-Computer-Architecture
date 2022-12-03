library ieee;
use ieee.std_logic_1164.all;

entity FourbitALU is
port ( a, b: in std_logic_vector (3 downto 0);
		 sel: in std_logic_vector (2 downto 0);
		 result: out std_logic_vector (7 downto 0));
end entity;

architecture arch of FourbitALU is
signal resA,resB,resC,resD,resE,resF,resG: std_logic_vector(7 downto 0);
component adder_subtractor
	port ( a,b : in std_logic_vector(3 downto 0);
			 sel: in std_logic_vector (2 downto 0);
			 result : out std_logic_vector(7 downto 0));
end component;
component multiplier
	port ( a,b : in std_logic_vector(3 downto 0);
			 sel: in std_logic_vector (2 downto 0);
			 result : out std_logic_vector(7 downto 0));
end component;
component comparator
	port ( a,b : in std_logic_vector(3 downto 0);
			 sel: in std_logic_vector (2 downto 0);
			 result : out std_logic_vector(7 downto 0));
end component;
component bitwiseNAND
	port ( a,b : in std_logic_vector(3 downto 0);
			 sel: in std_logic_vector (2 downto 0);
			 result : out std_logic_vector(7 downto 0));
end component;
component bitwiseNOR
	port ( a,b : in std_logic_vector(3 downto 0);
			 sel: in std_logic_vector (2 downto 0);
			 result : out std_logic_vector(7 downto 0));
end component;
component bitwiseXOR
	port ( a,b : in std_logic_vector(3 downto 0);
			 sel: in std_logic_vector (2 downto 0);
			 result : out std_logic_vector(7 downto 0));
end component;
component bitwiseXNOR
	port ( a,b : in std_logic_vector(3 downto 0);
			 sel: in std_logic_vector (2 downto 0);
			 result : out std_logic_vector(7 downto 0));
end component;
component bitwiseOR
	port ( resA,resB,resC,resD,resE,resF,resG : in std_logic_vector(7 downto 0);
			 result : out std_logic_vector(7 downto 0));
end component;
begin
PartA:	adder_subtractor
	port map(a,b,sel,resA);
PartB: multiplier
	port map(a,b,sel,resB);
PartC: comparator
	port map(a,b,sel,resC);
PartD: bitwiseNAND
	port map(a,b,sel,resD);
PartE: bitwiseNOR
	port map(a,b,sel,resE);
PartF: bitwiseXOR
	port map(a,b,sel,resF);
PartG: bitwiseXNOR
	port map(a,b,sel,resG);
FINAL: bitwiseOR
	port map(resA,resB,resC,resD,resE,resF,resG,result);
end architecture;