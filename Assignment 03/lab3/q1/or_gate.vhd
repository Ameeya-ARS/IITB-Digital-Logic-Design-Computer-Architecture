library ieee;
use ieee.std_logic_1164.all;
entity or_gate is
	port(x,y: in std_logic; z: out std_logic);
end entity;
architecture or_arch of or_gate is
begin
	z <= x or y;
end architecture;