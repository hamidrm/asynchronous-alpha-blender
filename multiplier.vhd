----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:58:30 01/11/2022 
-- Design Name: 
-- Module Name:    multiplier - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity multiplier is
	generic(
		constant a_len : integer := 8;
		constant b_len : integer := 3
	);
	port(
		a_in : in std_logic_vector(a_len-1 downto 0);
		b_in : in std_logic_vector(b_len-1 downto 0);
		res_out : out std_logic_vector((a_len + b_len-1) downto 0);
		ready_out : out std_logic := '0';
		clk_in : in std_logic := '0';
		trig_in : in std_logic := '0'
	);
end multiplier;

architecture Behavioral of multiplier is
begin
--ready_out <= '1' when j = b_len else '0';
res_out <= a_in * b_in;
process (clk_in)
--variable add_res : integer range 0 to (2**(b_len+a_len-1)) := 0;
begin
--	if clk_in = '1' and clk_in'event then
--		if trig_in = '1' then
--			j <= 0;
--			add_res := 0;
--		else
--			if j < b_len then
--				j <= j + 1;
--				add_res := add_res + to_integer(signed(mul_tabe(j)));
--			else
--				res_out <= std_logic_vector(to_signed(add_res, res_out'length));
--			end if;
--		end if;
--	end if;
end process;
end Behavioral;

