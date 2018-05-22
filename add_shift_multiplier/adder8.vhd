library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder8 is
port (
    a : in std_logic_vector(7 downto 0);
    b : in std_logic_vector(7 downto 0);
    c_in : in std_logic;
    s : out std_logic_vector(7 downto 0);
    c : out std_logic
);
end adder8;

architecture Behavioral of adder8 is

component full_adder is
port (
    a : in std_logic;
    b : in std_logic;
    c_in : in std_logic;
    s : out std_logic;
    c : out std_logic
);
end component;

signal c1 : std_logic;
signal c2 : std_logic;
signal c3 : std_logic;
signal c4 : std_logic;
signal c5 : std_logic;
signal c6 : std_logic;
signal c7 : std_logic;
signal c8 : std_logic;

begin

A1 : full_adder port map (a => a(0), b => b(0), c_in => c_in, s => s(0), c => c1);
A2 : full_adder port map (a => a(1), b => b(1), c_in => c1, s => s(1), c => c2);
A3 : full_adder port map (a => a(2), b => b(2), c_in => c2, s => s(2), c => c3);
A4 : full_adder port map (a => a(3), b => b(3), c_in => c3, s => s(3), c => c4);
A5 : full_adder port map (a => a(4), b => b(4), c_in => c4, s => s(4), c => c5);
A6 : full_adder port map (a => a(5), b => b(5), c_in => c5, s => s(5), c => c6);
A7 : full_adder port map (a => a(6), b => b(6), c_in => c6, s => s(6), c => c7);
A8 : full_adder port map (a => a(7), b => b(7), c_in => c7, s => s(7), c => c8);

c <= c8;

end Behavioral;
