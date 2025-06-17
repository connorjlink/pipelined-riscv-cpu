-------------------------------------------------------------------------
-- Connor Link
-- Iowa State University
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-- set_less.vhd
-- DESCRIPTION: This file contains an implementation of a "set-less-than" unit for the ALU.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;

entity set_less is
    port(i_A     : in  std_logic_vector(31 downto 0);
         i_B     : in  std_logic_vector(31 downto 0);
         o_Less  : out std_logic_vector(31 downto 0);
         o_LessU : out std_logic_vector(31 downto 0));
end set_less;

architecture mixed of set_less is

begin

    o_LessU <= 32x"1" when (unsigned(i_A) < unsigned(i_B)) else
               32x"0";
        
    o_Less <= 32x"1" when (signed(i_A) < signed(i_B)) else
              32x"0";

end mixed;
