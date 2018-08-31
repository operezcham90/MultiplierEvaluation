library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity array_multiplier is
port(
    a : in std_logic_vector(3 downto 0);
    b : in std_logic_vector(3 downto 0);
    p : out std_logic_vector(7 downto 0)
);
end array_multiplier;

architecture Behavioral of array_multiplier is
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

signal ab0 : std_logic_vector(3 downto 0);
signal ab1 : std_logic_vector(3 downto 0);
signal ab2 : std_logic_vector(3 downto 0);
signal ab3 : std_logic_vector(3 downto 0);

signal s1 : std_logic_vector(3 downto 0);
signal c1 : std_logic_vector(3 downto 0);
signal s2 : std_logic_vector(3 downto 0);
signal c2 : std_logic_vector(3 downto 0);
signal s3 : std_logic_vector(3 downto 0);
signal c3 : std_logic_vector(3 downto 0);

begin

-- partial products
ab0(0) <= a(0) and b(0);
ab0(1) <= a(1) and b(0);
ab0(2) <= a(2) and b(0);
ab0(3) <= a(3) and b(0);

ab1(0) <= a(0) and b(1);
ab1(1) <= a(1) and b(1);
ab1(2) <= a(2) and b(1);
ab1(3) <= a(3) and b(1);

ab2(0) <= a(0) and b(2);
ab2(1) <= a(1) and b(2);
ab2(2) <= a(2) and b(2);
ab2(3) <= a(3) and b(2);

ab3(0) <= a(0) and b(3);
ab3(1) <= a(1) and b(3);
ab3(2) <= a(2) and b(3);
ab3(3) <= a(3) and b(3);

-- addition 1
A1 : half_adder port map (a => ab1(0), b => ab0(1), s => s1(0), c => c1(0));
A2 : full_adder port map (a => ab1(1), b => ab0(2), s => s1(1), c => c1(1), c_in => c1(0));
A3 : full_adder port map (a => ab1(2), b => ab0(3), s => s1(2), c => c1(2), c_in => c1(1));
A4 : half_adder port map (a => ab1(3), b => c1(2), s => s1(3), c => c1(3));

-- addition 2
A5 : half_adder port map (a => ab2(0), b => s1(1), s => s2(0), c => c2(0));
A6 : full_adder port map (a => ab2(1), b => s1(2), s => s2(1), c => c2(1), c_in => c2(0));
A7 : full_adder port map (a => ab2(2), b => s1(3), s => s2(2), c => c2(2), c_in => c2(1));
A8 : full_adder port map (a => ab2(3), b => c1(3), s => s2(3), c => c2(3), c_in => c2(2));

-- addition 3
A9 : half_adder port map (a => ab3(0), b => s2(1), s => s3(0), c => c3(0));
A10 : full_adder port map (a => ab3(1), b => s2(2), s => s3(1), c => c3(1), c_in => c3(0));
A11 : full_adder port map (a => ab3(2), b => s2(3), s => s3(2), c => c3(2), c_in => c3(1));
A12 : full_adder port map (a => ab3(3), b => c2(3), s => s3(3), c => c3(3), c_in => c3(2));

-- product
p(0) <= ab0(0);
p(1) <= s1(0);
p(2) <= s2(0);
p(3) <= s3(0);
p(4) <= s3(1);
p(5) <= s3(2);
p(6) <= s3(3);
p(7) <= c3(3);

end Behavioral;