library ieee;
use ieee.std_logic_1164.all;

entity bitwiseOR is
port ( resA,resB,resC,resD,resE,resF,resG : in std_logic_vector(7 downto 0);
       result : out std_logic_vector(7 downto 0));
end entity;

architecture bitwiseOR_arch of bitwiseOR is
begin
	result(7) <= resA(7) or resB(7) or resC(7) or resD(7) or resE(7) or resF(7) or resG(7);
	result(6) <= resA(6) or resB(6) or resC(6) or resD(6) or resE(6) or resF(6) or resG(6);
	result(5) <= resA(5) or resB(5) or resC(5) or resD(5) or resE(5) or resF(5) or resG(5);
	result(4) <= resA(4) or resB(4) or resC(4) or resD(4) or resE(4) or resF(4) or resG(4);
	result(3) <= resA(3) or resB(3) or resC(3) or resD(3) or resE(3) or resF(3) or resG(3);
	result(2) <= resA(2) or resB(2) or resC(2) or resD(2) or resE(2) or resF(2) or resG(2);
	result(1) <= resA(1) or resB(1) or resC(1) or resD(1) or resE(1) or resF(1) or resG(1);
	result(0) <= resA(0) or resB(0) or resC(0) or resD(0) or resE(0) or resF(0) or resG(0);
	
end architecture;
