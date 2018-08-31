library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg4_dec is
PORT(
    d : IN STD_LOGIC_VECTOR(3 downto 0); -- input
    ld : IN STD_LOGIC; -- load/enable
    clr : IN STD_LOGIC; -- async clear
    clk : IN STD_LOGIC; -- clock
    q : OUT STD_LOGIC_VECTOR(3 downto 0); -- output
    sh : IN STD_LOGIC; -- shift
    dec : IN STD_LOGIC; -- decrease
    s_in : IN STD_LOGIC -- shift in
);
end reg4_dec;

architecture Behavioral of reg4_dec is

component adder4 is
port (
    a : in std_logic_vector(3 downto 0);
    b : in std_logic_vector(3 downto 0);
    c_in : in std_logic;
    s : out std_logic_vector(3 downto 0);
    c : out std_logic
);
end component;

signal current_q : STD_LOGIC_VECTOR(3 downto 0);
signal decreased_q : STD_LOGIC_VECTOR(3 downto 0);

begin

decrease : adder4 port map (a => "1111", b => current_q, c_in => '0', s => decreased_q, c => open);

process (clk, clr, ld, sh, dec)
begin
    current_q <= current_q;
    if clr = '1' then 
        current_q <= "0000";
    elsif clk'event and clk='1' then
        if ld = '1' then
            current_q <= d;
        elsif sh = '1' then
            current_q <= s_in & current_q(3 downto 1);
        elsif dec = '1' then
            current_q <= decreased_q;
        end if;
    end if;
end process;

q <= current_q;

end Behavioral;
