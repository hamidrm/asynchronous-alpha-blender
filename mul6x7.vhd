library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mul6x7 is
    Port ( a : in  STD_LOGIC_VECTOR (6 downto 0);
           b : in  STD_LOGIC_VECTOR (5 downto 0);
           c : out  STD_LOGIC_VECTOR (12 downto 0));
end mul6x7;

architecture Behavioral of mul6x7 is

signal ab0, ab1, ab2, ab3, ab4, ab5 : STD_LOGIC_VECTOR (6 downto 0);
signal c0, c1, c2 : STD_LOGIC_VECTOR (6 downto 0);
signal s0, s1, s2 : STD_LOGIC_VECTOR (7 downto 0);
signal r1, r2, r3, r4 : STD_LOGIC_VECTOR (12 downto 0);
signal rc1, rc2 : STD_LOGIC_VECTOR (11 downto 0);

component full_adder
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           cin : in  STD_LOGIC;
           cout : out  STD_LOGIC;
           sum : out  STD_LOGIC);
end component;

begin
	ab0(0) <= a(0) and b(0); ab0(1) <= a(1) and b(0); ab0(2) <= a(2) and b(0);
	ab0(3) <= a(3) and b(0); ab0(4) <= a(4) and b(0); ab0(5) <= a(5) and b(0);
	ab0(6) <= a(6) and b(0);
	ab1(0) <= a(0) and b(1); ab1(1) <= a(1) and b(1); ab1(2) <= a(2) and b(1);
	ab1(3) <= a(3) and b(1); ab1(4) <= a(4) and b(1); ab1(5) <= a(5) and b(1);
	ab1(6) <= a(6) and b(1);
	ab2(0) <= a(0) and b(2); ab2(1) <= a(1) and b(2); ab2(2) <= a(2) and b(2);
	ab2(3) <= a(3) and b(2); ab2(4) <= a(4) and b(2); ab2(5) <= a(5) and b(2);
	ab2(6) <= a(6) and b(2);
	ab3(0) <= a(0) and b(3); ab3(1) <= a(1) and b(3); ab3(2) <= a(2) and b(3);
	ab3(3) <= a(3) and b(3); ab3(4) <= a(4) and b(3); ab3(5) <= a(5) and b(3);
	ab3(6) <= a(6) and b(3);
	ab4(0) <= a(0) and b(4); ab4(1) <= a(1) and b(4); ab4(2) <= a(2) and b(4);
	ab4(3) <= a(3) and b(4); ab4(4) <= a(4) and b(4); ab4(5) <= a(5) and b(4);
	ab4(6) <= a(6) and b(4);
	ab5(0) <= a(0) and b(5); ab5(1) <= a(1) and b(5); ab5(2) <= a(2) and b(5);
	ab5(3) <= a(3) and b(5); ab5(4) <= a(4) and b(5); ab5(5) <= a(5) and b(5);
	ab5(6) <= a(6) and b(5);
	
	s0(0) <= ab0(0);
	s0(1) <= ab1(0) xor ab0(1);
	c0(0) <= ab1(0) and ab0(1);
	
	s1(0) <= ab2(0);
	s1(1) <= ab3(0) xor ab2(1);
	c1(0) <= ab3(0) and ab2(1);

	s2(0) <= ab4(0);
	s2(1) <= ab5(0) xor ab4(1);
	c2(0) <= ab5(0) and ab4(1);
	
fa11:	full_adder port map (ab0(2), ab1(1), c0(0), c0(1), s0(2));
fa12:	full_adder port map (ab0(3), ab1(2), c0(1), c0(2), s0(3));
fa13:	full_adder port map (ab0(4), ab1(3), c0(2), c0(3), s0(4));
fa14:	full_adder port map (ab0(5), ab1(4), c0(3), c0(4), s0(5));
fa15:	full_adder port map (ab0(6), ab1(5), c0(4), c0(5), s0(6));
s0(7) <= c0(5) xor ab1(6);
c0(6) <= c0(5) and ab1(6);

fa21:	full_adder port map (ab2(2), ab3(1), c1(0), c1(1), s1(2));
fa22:	full_adder port map (ab2(3), ab3(2), c1(1), c1(2), s1(3));
fa23:	full_adder port map (ab2(4), ab3(3), c1(2), c1(3), s1(4));
fa24:	full_adder port map (ab2(5), ab3(4), c1(3), c1(4), s1(5));
fa25:	full_adder port map (ab2(6), ab3(5), c1(4), c1(5), s1(6));
s1(7) <= c1(5) xor ab3(6);
c1(6) <= c1(5) and ab3(6);

fa31:	full_adder port map (ab4(2), ab5(1), c2(0), c2(1), s2(2));
fa32:	full_adder port map (ab4(3), ab5(2), c2(1), c2(2), s2(3));
fa33:	full_adder port map (ab4(4), ab5(3), c2(2), c2(3), s2(4));
fa34:	full_adder port map (ab4(5), ab5(4), c2(3), c2(4), s2(5));
fa35:	full_adder port map (ab4(6), ab5(5), c2(4), c2(5), s2(6));
s2(7) <= c2(5) xor ab5(6);
c2(6) <= c2(5) and ab5(6);

r1 <= "0000" & c0(6) & s0;
r2 <= "00"   & c1(6) & s1 & "00";
r3 <= c2(6)  & s2    & "0000";

fa41:	full_adder port map (r1(0), r2(0), '0', rc1(0), r4(0));
fa42:	full_adder port map (r1(1), r2(1), rc1(0), rc1(1), r4(1));
fa43:	full_adder port map (r1(2), r2(2), rc1(1), rc1(2), r4(2));
fa44:	full_adder port map (r1(3), r2(3), rc1(2), rc1(3), r4(3));
fa45:	full_adder port map (r1(4), r2(4), rc1(3), rc1(4), r4(4));
fa46:	full_adder port map (r1(5), r2(5), rc1(4), rc1(5), r4(5));
fa47:	full_adder port map (r1(6), r2(6), rc1(5), rc1(6), r4(6));
fa48:	full_adder port map (r1(7), r2(7), rc1(6), rc1(7), r4(7));
fa49:	full_adder port map (r1(8), r2(8), rc1(7), rc1(8), r4(8));
fa4a:	full_adder port map (r1(9), r2(9), rc1(8), rc1(9), r4(9));
fa4b:	full_adder port map (r1(10), r2(10), rc1(9), rc1(10), r4(10));
fa4c:	full_adder port map (r1(11), r2(11), rc1(10), rc1(11), r4(11));
r4(12) <= (r1(12) xor r2(12)) xor rc1(11);

fa51:	full_adder port map (r4(0), r3(0), '0', rc2(0), c(0));
fa52:	full_adder port map (r4(1), r3(1), rc2(0), rc2(1), c(1));
fa53:	full_adder port map (r4(2), r3(2), rc2(1), rc2(2), c(2));
fa54:	full_adder port map (r4(3), r3(3), rc2(2), rc2(3), c(3));
fa55:	full_adder port map (r4(4), r3(4), rc2(3), rc2(4), c(4));
fa56:	full_adder port map (r4(5), r3(5), rc2(4), rc2(5), c(5));
fa57:	full_adder port map (r4(6), r3(6), rc2(5), rc2(6), c(6));
fa58:	full_adder port map (r4(7), r3(7), rc2(6), rc2(7), c(7));
fa59:	full_adder port map (r4(8), r3(8), rc2(7), rc2(8), c(8));
fa5a:	full_adder port map (r4(9), r3(9), rc2(8), rc2(9), c(9));
fa5b:	full_adder port map (r4(10), r3(10), rc2(9), rc2(10), c(10));
fa5c:	full_adder port map (r4(11), r3(11), rc2(10), rc2(11), c(11));
c(12) <= (r4(12) xor r3(12)) xor rc2(11);

end Behavioral;

