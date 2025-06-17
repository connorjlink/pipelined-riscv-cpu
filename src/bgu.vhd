-------------------------------------------------------------------------
-- Connor Link
-- Iowa State University
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-- bgu.vhd
-- DESCRIPTION: This file contains an implementation of a basic RISC-V branch generation unit.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.RISCV_types.all;

entity bgu is
    port(
        i_CLK            : in  std_logic;
        i_DS1            : in  std_logic_vector(31 downto 0);
        i_DS2            : in  std_logic_vector(31 downto 0);
        i_BGUOp          : in  natural;
        o_BranchTaken    : out std_logic;
        o_BranchNotTaken : out std_logic
        -- TODO: prediction results here
    );
end bgu;

architecture mixed of bgu is

begin 

    process(
        all
    )
        variable v_BranchTaken    : std_logic := '0';
        variable v_BranchNotTaken : std_logic := '0';

    begin

        v_BranchTaken    := '0';
        v_BranchNotTaken := '0';

        case i_BGUOp is
            when work.RISCV_types.BEQ =>
                if unsigned(i_DS1) = unsigned(i_DS2) then
                    v_BranchTaken := '1';
                else
                    v_BranchNotTaken := '1';
                end if;

            when work.RISCV_types.BNE =>
                if unsigned(i_DS1) /= unsigned(i_DS2) then
                    v_BranchTaken := '1';
                else
                    v_BranchNotTaken := '1';
                end if;

            when work.RISCV_types.BLT =>
                if signed(i_DS1) < signed(i_DS2) then
                    v_BranchTaken := '1';
                else
                    v_BranchNotTaken := '1';
                end if;

            when work.RISCV_types.BGE =>
                if signed(i_DS1) >= signed(i_DS2) then
                    v_BranchTaken := '1';
                else
                    v_BranchNotTaken := '1';
                end if;

            when work.RISCV_types.BLTU =>
                if unsigned(i_DS1) < unsigned(i_DS2) then
                    v_BranchTaken := '1';
                else
                    v_BranchNotTaken := '1';
                end if;

            when work.RISCV_types.BGEU =>
                if unsigned(i_DS1) >= unsigned(i_DS2) then
                    v_BranchTaken := '1';
                else
                    v_BranchNotTaken := '1';
                end if;

            when work.RISCV_types.J =>
                v_BranchTaken := '1';

            when others =>

        end case;

        -- TODO: "Predict" unconditional branches as always taken -- should save one cycle
        -- TODO: predict conditional forward branch not taken (used for `if` conditions), backward branch taken (used for loops) -- should save about .5 cycles per branch I estimate

        o_BranchTaken    <= v_BranchTaken;
        o_BranchNotTaken <= v_BranchNotTaken;

    end process;
    
end mixed;
