library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity half_adder is
port(
    a : in std_logic;
    b : in std_logic;
    s : out std_logic;
    c : out std_logic
);
end half_adder;

architecture Behavioral of half_adder is

begin

s <= a xor b;
c <= a and b;

end Behavioral;