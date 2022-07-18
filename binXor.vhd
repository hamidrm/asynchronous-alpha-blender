----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:19:26 01/12/2022 
-- Design Name: 
-- Module Name:    binXor - Behavioral 
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
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity binXor is
	generic(
		constant a_len : integer
	);
	port(
		a_in : in std_logic_vector(a_len-1 downto 0);
		b_in : in std_logic;
		res_out : out std_logic_vector(a_len-1 downto 0)
	);
end binXor;

architecture Behavioral of binXor is
signal iter : natural range 0 to a_len-1 := 0;
begin
binXor:	for iter in 0 to a_len-1 generate
		res_out(iter) <= a_in(iter) and b_in;
end generate binXor;
end Behavioral;

