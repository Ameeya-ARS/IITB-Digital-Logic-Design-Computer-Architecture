library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity one_bit_half_adder is
  port (
    in1  : in std_logic;
    in2  : in std_logic;
    out_sum   : out std_logic;
    out_carry : out std_logic
    );
end one_bit_half_adder;
 
architecture half_adder_arch of one_bit_half_adder is
begin
  out_sum   <= in1 xor in2;
  out_carry <= in1 and in2;
end architecture;