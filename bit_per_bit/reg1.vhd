library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg1 is
PORT(
    d : IN STD_LOGIC; -- input.
    ld : IN STD_LOGIC; -- load/enable.
    clr : IN STD_LOGIC; -- async. clear.
    clk : IN STD_LOGIC; -- clock.
    q : OUT STD_LOGIC -- output.
);
end reg1;

architecture Behavioral of reg1 is

begin

process (clk, clr, ld)
begin
    if clr = '1' then 
        q <= '0';
    elsif ld = '1' and clk'event and clk='1' then
        if d = '1' then
            q <= '1';
        elsif d = '0' then
            q <= '0';
        end if;
    end if;
end process;

end Behavioral;
