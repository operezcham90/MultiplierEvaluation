library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity array_multiplier_8_bit is
port(
    a : in std_logic_vector(7 downto 0);
    b : in std_logic_vector(7 downto 0);
    p : out std_logic_vector(15 downto 0)
);
end array_multiplier_8_bit;

architecture Behavioral of array_multiplier_8_bit is

component full_adder is
port (
    a : in std_logic;
    b : in std_logic;
    c_in : in std_logic;
    s : out std_logic;
    c : out std_logic
);
end component;
component half_adder is
port(
    a : in std_logic;
    b : in std_logic;
    s : out std_logic;
    c : out std_logic
);
end component;

signal ab0 : std_logic_vector(7 downto 0);
signal ab1 : std_logic_vector(7 downto 0);
signal ab2 : std_logic_vector(7 downto 0);
signal ab3 : std_logic_vector(7 downto 0);
signal ab4 : std_logic_vector(7 downto 0);
signal ab5 : std_logic_vector(7 downto 0);
signal ab6 : std_logic_vector(7 downto 0);
signal ab7 : std_logic_vector(7 downto 0);

signal s1 : std_logic_vector(7 downto 0);
signal c1 : std_logic_vector(7 downto 0);
signal s2 : std_logic_vector(7 downto 0);
signal c2 : std_logic_vector(7 downto 0);
signal s3 : std_logic_vector(7 downto 0);
signal c3 : std_logic_vector(7 downto 0);
signal s4 : std_logic_vector(7 downto 0);
signal c4 : std_logic_vector(7 downto 0);
signal s5 : std_logic_vector(7 downto 0);
signal c5 : std_logic_vector(7 downto 0);
signal s6 : std_logic_vector(7 downto 0);
signal c6 : std_logic_vector(7 downto 0);
signal s7 : std_logic_vector(7 downto 0);
signal c7 : std_logic_vector(7 downto 0);

begin

-- partial products
ab0(0) <= a(0) and b(0);
ab0(1) <= a(1) and b(0);
ab0(2) <= a(2) and b(0);
ab0(3) <= a(3) and b(0);
ab0(4) <= a(4) and b(0);
ab0(5) <= a(5) and b(0);
ab0(6) <= a(6) and b(0);
ab0(7) <= a(7) and b(0);

ab1(0) <= a(0) and b(1);
ab1(1) <= a(1) and b(1);
ab1(2) <= a(2) and b(1);
ab1(3) <= a(3) and b(1);
ab1(4) <= a(4) and b(1);
ab1(5) <= a(5) and b(1);
ab1(6) <= a(6) and b(1);
ab1(7) <= a(7) and b(1);

ab2(0) <= a(0) and b(2);
ab2(1) <= a(1) and b(2);
ab2(2) <= a(2) and b(2);
ab2(3) <= a(3) and b(2);
ab2(4) <= a(4) and b(2);
ab2(5) <= a(5) and b(2);
ab2(6) <= a(6) and b(2);
ab2(7) <= a(7) and b(2);

ab3(0) <= a(0) and b(3);
ab3(1) <= a(1) and b(3);
ab3(2) <= a(2) and b(3);
ab3(3) <= a(3) and b(3);
ab3(4) <= a(4) and b(3);
ab3(5) <= a(5) and b(3);
ab3(6) <= a(6) and b(3);
ab3(7) <= a(7) and b(3);

ab4(0) <= a(0) and b(4);
ab4(1) <= a(1) and b(4);
ab4(2) <= a(2) and b(4);
ab4(3) <= a(3) and b(4);
ab4(4) <= a(4) and b(4);
ab4(5) <= a(5) and b(4);
ab4(6) <= a(6) and b(4);
ab4(7) <= a(7) and b(4);

ab5(0) <= a(0) and b(5);
ab5(1) <= a(1) and b(5);
ab5(2) <= a(2) and b(5);
ab5(3) <= a(3) and b(5);
ab5(4) <= a(4) and b(5);
ab5(5) <= a(5) and b(5);
ab5(6) <= a(6) and b(5);
ab5(7) <= a(7) and b(5);

ab6(0) <= a(0) and b(6);
ab6(1) <= a(1) and b(6);
ab6(2) <= a(2) and b(6);
ab6(3) <= a(3) and b(6);
ab6(4) <= a(4) and b(6);
ab6(5) <= a(5) and b(6);
ab6(6) <= a(6) and b(6);
ab6(7) <= a(7) and b(6);

ab7(0) <= a(0) and b(7);
ab7(1) <= a(1) and b(7);
ab7(2) <= a(2) and b(7);
ab7(3) <= a(3) and b(7);
ab7(4) <= a(4) and b(7);
ab7(5) <= a(5) and b(7);
ab7(6) <= a(6) and b(7);
ab7(7) <= a(7) and b(7);

-- addition 1
A1 : half_adder port map (a => ab1(0), b => ab0(1), s => s1(0), c => c1(0));
A2 : full_adder port map (a => ab1(1), b => ab0(2), s => s1(1), c => c1(1), c_in => c1(0));
A3 : full_adder port map (a => ab1(2), b => ab0(3), s => s1(2), c => c1(2), c_in => c1(1));
A4 : full_adder port map (a => ab1(3), b => ab0(4), s => s1(3), c => c1(3), c_in => c1(2));
A5 : full_adder port map (a => ab1(4), b => ab0(5), s => s1(4), c => c1(4), c_in => c1(3));
A6 : full_adder port map (a => ab1(5), b => ab0(6), s => s1(5), c => c1(5), c_in => c1(4));
A7 : full_adder port map (a => ab1(6), b => ab0(7), s => s1(6), c => c1(6), c_in => c1(5));
A8 : half_adder port map (a => ab1(7), b => c1(6), s => s1(7), c => c1(7));

-- addition 2
A9 : half_adder port map (a => ab2(0), b => s1(1), s => s2(0), c => c2(0));
A10 : full_adder port map (a => ab2(1), b => s1(2), s => s2(1), c => c2(1), c_in => c2(0));
A11 : full_adder port map (a => ab2(2), b => s1(3), s => s2(2), c => c2(2), c_in => c2(1));
A12 : full_adder port map (a => ab2(3), b => s1(4), s => s2(3), c => c2(3), c_in => c2(2));
A13 : full_adder port map (a => ab2(4), b => s1(5), s => s2(4), c => c2(4), c_in => c2(3));
A14 : full_adder port map (a => ab2(5), b => s1(6), s => s2(5), c => c2(5), c_in => c2(4));
A15 : full_adder port map (a => ab2(6), b => s1(7), s => s2(6), c => c2(6), c_in => c2(5));
A16 : full_adder port map (a => ab2(7), b => c1(7), s => s2(7), c => c2(7), c_in => c2(6));

-- addition 3
A17 : half_adder port map (a => ab3(0), b => s2(1), s => s3(0), c => c3(0));
A18 : full_adder port map (a => ab3(1), b => s2(2), s => s3(1), c => c3(1), c_in => c3(0));
A19 : full_adder port map (a => ab3(2), b => s2(3), s => s3(2), c => c3(2), c_in => c3(1));
A20 : full_adder port map (a => ab3(3), b => s2(4), s => s3(3), c => c3(3), c_in => c3(2));
A21 : full_adder port map (a => ab3(4), b => s2(5), s => s3(4), c => c3(4), c_in => c3(3));
A22 : full_adder port map (a => ab3(5), b => s2(6), s => s3(5), c => c3(5), c_in => c3(4));
A23 : full_adder port map (a => ab3(6), b => s2(7), s => s3(6), c => c3(6), c_in => c3(5));
A24 : full_adder port map (a => ab3(7), b => c2(7), s => s3(7), c => c3(7), c_in => c3(6));

-- addition 4
A25 : half_adder port map (a => ab4(0), b => s3(1), s => s4(0), c => c4(0));
A26 : full_adder port map (a => ab4(1), b => s3(2), s => s4(1), c => c4(1), c_in => c4(0));
A27 : full_adder port map (a => ab4(2), b => s3(3), s => s4(2), c => c4(2), c_in => c4(1));
A28 : full_adder port map (a => ab4(3), b => s3(4), s => s4(3), c => c4(3), c_in => c4(2));
A29 : full_adder port map (a => ab4(4), b => s3(5), s => s4(4), c => c4(4), c_in => c4(3));
A30 : full_adder port map (a => ab4(5), b => s3(6), s => s4(5), c => c4(5), c_in => c4(4));
A31 : full_adder port map (a => ab4(6), b => s3(7), s => s4(6), c => c4(6), c_in => c4(5));
A32 : full_adder port map (a => ab4(7), b => c3(7), s => s4(7), c => c4(7), c_in => c4(6));

-- addition 5
A33 : half_adder port map (a => ab5(0), b => s4(1), s => s5(0), c => c5(0));
A34 : full_adder port map (a => ab5(1), b => s4(2), s => s5(1), c => c5(1), c_in => c5(0));
A35 : full_adder port map (a => ab5(2), b => s4(3), s => s5(2), c => c5(2), c_in => c5(1));
A36 : full_adder port map (a => ab5(3), b => s4(4), s => s5(3), c => c5(3), c_in => c5(2));
A37 : full_adder port map (a => ab5(4), b => s4(5), s => s5(4), c => c5(4), c_in => c5(3));
A38 : full_adder port map (a => ab5(5), b => s4(6), s => s5(5), c => c5(5), c_in => c5(4));
A39 : full_adder port map (a => ab5(6), b => s4(7), s => s5(6), c => c5(6), c_in => c5(5));
A40 : full_adder port map (a => ab5(7), b => c4(7), s => s5(7), c => c5(7), c_in => c5(6));

-- addition 6
A41 : half_adder port map (a => ab6(0), b => s5(1), s => s6(0), c => c6(0));
A42 : full_adder port map (a => ab6(1), b => s5(2), s => s6(1), c => c6(1), c_in => c6(0));
A43 : full_adder port map (a => ab6(2), b => s5(3), s => s6(2), c => c6(2), c_in => c6(1));
A44 : full_adder port map (a => ab6(3), b => s5(4), s => s6(3), c => c6(3), c_in => c6(2));
A45 : full_adder port map (a => ab6(4), b => s5(5), s => s6(4), c => c6(4), c_in => c6(3));
A46 : full_adder port map (a => ab6(5), b => s5(6), s => s6(5), c => c6(5), c_in => c6(4));
A47 : full_adder port map (a => ab6(6), b => s5(7), s => s6(6), c => c6(6), c_in => c6(5));
A48 : full_adder port map (a => ab6(7), b => c5(7), s => s6(7), c => c6(7), c_in => c6(6));

-- addition 6
A49 : half_adder port map (a => ab7(0), b => s6(1), s => s7(0), c => c7(0));
A50 : full_adder port map (a => ab7(1), b => s6(2), s => s7(1), c => c7(1), c_in => c7(0));
A51 : full_adder port map (a => ab7(2), b => s6(3), s => s7(2), c => c7(2), c_in => c7(1));
A52 : full_adder port map (a => ab7(3), b => s6(4), s => s7(3), c => c7(3), c_in => c7(2));
A53 : full_adder port map (a => ab7(4), b => s6(5), s => s7(4), c => c7(4), c_in => c7(3));
A54 : full_adder port map (a => ab7(5), b => s6(6), s => s7(5), c => c7(5), c_in => c7(4));
A55 : full_adder port map (a => ab7(6), b => s6(7), s => s7(6), c => c7(6), c_in => c7(5));
A56 : full_adder port map (a => ab7(7), b => c6(7), s => s7(7), c => c7(7), c_in => c7(6));

-- product
p(0) <= ab0(0);
p(1) <= s1(0);
p(2) <= s2(0);
p(3) <= s3(0);
p(4) <= s4(0);
p(5) <= s5(0);
p(6) <= s6(0);
p(7) <= s7(0);
p(8) <= s7(1);
p(9) <= s7(2);
p(10) <= s7(3);
p(11) <= s7(4);
p(12) <= s7(5);
p(13) <= s7(6);
p(14) <= s7(7);
p(15) <= c7(7);

end Behavioral;
