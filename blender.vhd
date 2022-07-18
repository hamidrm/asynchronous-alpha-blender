----------------------------------------------------------------------------------
-- Engineer: Hamidreza Mehrabian
-- Module Name:    Alpha Blender 
----------------------------------------------------------------------------------
library IEEE;
use ieee.std_logic_1164.all;

entity blender is
	PORT(
		color1 : in STD_LOGIC_VECTOR(15 downto 0);
		color2 : in STD_LOGIC_VECTOR(15 downto 0);
		alpha : in STD_LOGIC_VECTOR(6 downto 0);
		color_out : out STD_LOGIC_VECTOR(15 downto 0)
		);
end blender;

architecture Behavioral of blender is

--Color 1 (5:6:5)
signal r_color1 : std_logic_vector(4 downto 0);
signal g_color1 : std_logic_vector(5 downto 0);
signal b_color1 : std_logic_vector(4 downto 0);

--Color 2 (5:6:5)
signal r_color2 : std_logic_vector(4 downto 0);
signal g_color2 : std_logic_vector(5 downto 0);
signal b_color2 : std_logic_vector(4 downto 0);

--Temp
signal r_temp1, r_temp2, b_temp1, b_temp2 : std_logic_vector(11 downto 0);
signal g_temp1, g_temp2 : std_logic_vector(12 downto 0);

signal r_color_res1, r_color_res2 : std_logic_vector(4 downto 0);
signal g_color_res1, g_color_res2 : std_logic_vector(5 downto 0);
signal b_color_res1, b_color_res2 : std_logic_vector(4 downto 0);

signal c1 : std_logic_vector(3 downto 0);
signal c2 : std_logic_vector(4 downto 0);
signal c3 : std_logic_vector(3 downto 0);

signal r_res : std_logic_vector(4 downto 0);
signal g_res : std_logic_vector(5 downto 0);
signal b_res : std_logic_vector(4 downto 0);

signal com_alpha : std_logic_vector(6 downto 0);

component mul5x7 is
    Port ( a : in  STD_LOGIC_VECTOR (6 downto 0);
           b : in  STD_LOGIC_VECTOR (4 downto 0);
           c : out  STD_LOGIC_VECTOR (11 downto 0));
end component;

component mul6x7 is
    Port ( a : in  STD_LOGIC_VECTOR (6 downto 0);
           b : in  STD_LOGIC_VECTOR (5 downto 0);
           c : out  STD_LOGIC_VECTOR (12 downto 0));
end component;

component full_adder
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           cin : in  STD_LOGIC;
           cout : out  STD_LOGIC;
           sum : out  STD_LOGIC);
end component;

begin

com_alpha <= not alpha(6 downto 0);

r_color1 <= color1(4 downto 0);
g_color1 <= color1(10 downto 5);
b_color1 <= color1(15 downto 11);

r_color2 <= color2(4 downto 0);
g_color2 <= color2(10 downto 5);
b_color2 <= color2(15 downto 11);

rf_mul_alpha:
	mul5x7 port map (alpha, r_color1, r_temp1);

rb_mul_alpha:
	mul5x7 port map (com_alpha, r_color2, r_temp2);

gf_mul_alpha:
	mul6x7 port map (alpha, g_color1, g_temp1);

gb_mul_alpha:
	mul6x7 port map (com_alpha, g_color2, g_temp2);
	
bf_mul_alpha:
	mul5x7 port map (alpha, b_color1, b_temp1);

bb_mul_alpha:
	mul5x7 port map (com_alpha, b_color2, b_temp2);
	
r_color_res1 <= r_temp1(11 downto 7);
r_color_res2 <= r_temp2(11 downto 7);

g_color_res1 <= g_temp1(12 downto 7);
g_color_res2 <= g_temp2(12 downto 7);

b_color_res1 <= b_temp1(11 downto 7);
b_color_res2 <= b_temp2(11 downto 7);

far11:	full_adder port map (r_color_res1(0), r_color_res2(0), '0'  , c1(0), r_res(0));
far12:	full_adder port map (r_color_res1(1), r_color_res2(1), c1(0), c1(1), r_res(1));
far13:	full_adder port map (r_color_res1(2), r_color_res2(2), c1(1), c1(2), r_res(2));
far14:	full_adder port map (r_color_res1(3), r_color_res2(3), c1(2), c1(3), r_res(3));
r_res(4) <= (r_color_res1(4) xor r_color_res2(4)) xor c1(3);

far21:	full_adder port map (g_color_res1(0), g_color_res2(0), '0'  , c2(0), g_res(0));
far22:	full_adder port map (g_color_res1(1), g_color_res2(1), c2(0), c2(1), g_res(1));
far23:	full_adder port map (g_color_res1(2), g_color_res2(2), c2(1), c2(2), g_res(2));
far24:	full_adder port map (g_color_res1(3), g_color_res2(3), c2(2), c2(3), g_res(3));
far25:	full_adder port map (g_color_res1(4), g_color_res2(4), c2(3), c2(4), g_res(4));
g_res(5) <= (g_color_res1(5) xor g_color_res2(5)) xor c2(4);

far31:	full_adder port map (b_color_res1(0), b_color_res2(0), '0'  , c3(0), b_res(0));
far32:	full_adder port map (b_color_res1(1), b_color_res2(1), c3(0), c3(1), b_res(1));
far33:	full_adder port map (b_color_res1(2), b_color_res2(2), c3(1), c3(2), b_res(2));
far34:	full_adder port map (b_color_res1(3), b_color_res2(3), c3(2), c3(3), b_res(3));
b_res(4) <= (b_color_res1(4) xor b_color_res2(4)) xor c3(3);

color_out(4 downto 0) <= r_res;
color_out(10 downto 5) <= g_res;
color_out(15 downto 11) <= b_res;

end Behavioral;

