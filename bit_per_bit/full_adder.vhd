library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder is
port (
    a : in std_logic;
    b : in std_logic;
    c_in : in std_logic;
    s : out std_logic;
    c : out std_logic
);
end full_adder;

architecture Behavioral of full_adder is

signal ab : std_logic;

begin

ab <= (a xor b);
s <= ab xor c_in;
c <= (a and b) or (c_in and ab);

end Behavioral;