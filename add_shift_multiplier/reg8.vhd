library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg8 is
PORT(
    d : IN STD_LOGIC_VECTOR(7 downto 0); -- input
    ld : IN STD_LOGIC; -- load/enable
    clr : IN STD_LOGIC; -- async clear
    clk : IN STD_LOGIC; -- clock
    q : OUT STD_LOGIC_VECTOR(7 downto 0); -- output
    sh : IN STD_LOGIC; -- shift
    s_in : IN STD_LOGIC -- shift in
);
end reg8;

architecture Behavioral of reg8 is

signal current_q : STD_LOGIC_VECTOR(7 downto 0);

begin

process (clk, clr, ld, sh)
begin
    if clr = '1' then 
        current_q <= "00000000";
    elsif clk'event and clk='1' then
        if ld = '1' then
            current_q <= d;
        elsif sh = '1' then
            current_q <= s_in & current_q(7 downto 1);
        end if;
    end if;
end process;

q <= current_q; 

end Behavioral;
