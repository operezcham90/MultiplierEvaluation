library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mult is
Port (
    a : in std_logic_vector(7 downto 0);
    b : in std_logic_vector(7 downto 0);
    clk : in std_logic;
    clr : in std_logic;
    start : in std_logic;
    finish : out std_logic;
    p : out std_logic_vector(15 downto 0)
);
end mult;

architecture Behavioral of mult is

component reg8 is
PORT(
    d : IN STD_LOGIC_VECTOR(7 downto 0); -- input
    ld : IN STD_LOGIC; -- load/enable
    clr : IN STD_LOGIC; -- async clear
    clk : IN STD_LOGIC; -- clock
    q : OUT STD_LOGIC_VECTOR(7 downto 0); -- output
    sh : IN STD_LOGIC; -- shift
    s_in : IN STD_LOGIC -- shift in
);
end component;

component reg1 is
PORT(
    d : IN STD_LOGIC; -- input.
    ld : IN STD_LOGIC; -- load/enable.
    clr : IN STD_LOGIC; -- async. clear.
    clk : IN STD_LOGIC; -- clock.
    q : OUT STD_LOGIC -- output.
);
end component;

component reg4_dec is
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
end component;

component full_adder is
port (
    a : in std_logic;
    b : in std_logic;
    c_in : in std_logic;
    s : out std_logic;
    c : out std_logic
);
end component;

signal ldm : std_logic;
signal m : std_logic_vector(7 downto 0);

signal ldq : std_logic;
signal shq : std_logic;
signal q : std_logic_vector(7 downto 0);

signal e_in : std_logic;
signal lde : std_logic;
signal e : std_logic;
signal clre : std_logic;

signal ac : std_logic_vector(7 downto 0);
signal ac_in : std_logic_vector(7 downto 0);
signal lda : std_logic;
signal sha : std_logic;
signal clra : std_logic;

signal ldc : std_logic;
signal c : std_logic_vector(3 downto 0);
signal decc : std_logic;

signal ldc2 : std_logic;
signal c2 : std_logic_vector(3 downto 0);
signal decc2 : std_logic;

signal ldv : std_logic;
signal shv : std_logic;
signal v1 : std_logic_vector(7 downto 0);
signal v2 : std_logic_vector(7 downto 0);
signal sum_in : std_logic;

TYPE State_type IS (t0, t1, t2, t3, t20, t21);

SIGNAL state : State_Type;

begin

multiplicand : reg8 PORT map (d => a, ld => ldm, clr => clr, clk => clk, q => m, sh => '0', s_in => '0');
multiplier : reg8 PORT map (d => b, ld => ldq, clr => clr, clk => clk, q => q, sh => shq, s_in => ac(0));
multiplier_carry : reg1 PORT map (d => e_in , ld => lde , clr => clre, clk => clk, q => e);
val1 : reg8 PORT map (d => m, ld => ldv, clr => clr, clk => clk, q => v1, sh => shv, s_in => '0');
val2 : reg8 PORT map (d => ac, ld => ldv, clr => clr, clk => clk, q => v2, sh => shv, s_in => '0');
sum : reg8 PORT map (d => "00000000", ld => '0', clr => clr, clk => clk, q => ac_in, sh => shv, s_in => sum_in);
adder : full_adder port map (a => v1(0), b => v2(0), c_in => e, c => e_in, s => sum_in);
--adder : adder8 port map (a => m, b => ac, c_in => '0', s => ac_in, c => e_in);
accumulator : reg8 PORT map(d => ac_in, ld => lda, clr => clra, clk => clk, q => ac, sh => sha, s_in => e);
counter : reg4_dec PORT map (d => "1000", ld => ldc, clr => clr, clk => clk, q => c, sh => '0', s_in => '0', dec => decc);
counter2 : reg4_dec PORT map (d => "0111", ld => ldc2, clr => clr, clk => clk, q => c2, sh => '0', s_in => '0', dec => decc2);


p <= ac & q;

process(clk, clr)
begin
    -- clear
    if clr = '1' then
        -- default values
        ldm <= '0';
        ldq <= '0';
        ldc <= '0';
        shq <= '0';
        lde <= '0';
        clre <= '1';
        lda <= '0';
        sha <= '0';
        clra <= '1';
        decc <= '0';
        ldc2 <= '0';
        decc2 <= '0';
        ldv <= '0';
        shv <= '0';
        finish <= '0';
        state <= t0;
    elsif clk'event and clk='1' then
        CASE state IS
            WHEN t0 =>
                -- wait
                finish <= '1';
                if start = '1' then
                    state <= t1;
                else
                    state <= t0;
                end if;
                
                -- default values
                ldc <= '0';
                ldm <= '0';
                ldq <= '0';
                shq <= '0';
                lde <= '0';
                clre <= '0';
                lda <= '0';
                sha <= '0';
                clra <= '0';
                decc <= '0';
                ldc2 <= '0';
                decc2 <= '0';
                ldv <= '0';
                shv <= '0';
            WHEN t1 =>
                -- initialize
                clra <= '1';
                clre <= '1';
                ldc <= '1';
                ldm <= '1';
                ldq <= '1';
                state <= t2;
                
                -- default values
                shq <= '0';
                lde <= '0';
                lda <= '0';
                sha <= '0';
                decc <= '0';
                finish <= '0';
                ldc2 <= '0';
                decc2 <= '0';
                ldv <= '0';
                shv <= '0';
            WHEN t2 =>
                if q(0) = '1' then
                    -- initialize addition
                    ldc2 <= '1';
                    ldv <= '1';
                    state <= t20;
                else
                    -- skip
                    ldc2 <= '0';
                    ldv <= '0';
                    state <= t3;
                end if;
                decc <= '1';
                
                -- default values
                ldm <= '0';
                ldq <= '0';
                ldc <= '0';
                shq <= '0';
                lde <= '0';
                clre <= '0';
                lda <= '0';
                sha <= '0';
                clra <= '0';
                decc2 <= '0';
                shv <= '0';
                finish <= '0';
            WHEN t20 =>
                -- 1 bit addition
                shv <= '1';
                lde <= '1';
                state <= t21;
                decc2 <= '1';
                
                -- deafult values
                ldm <= '0';
                ldq <= '0';
                ldc <= '0';
                shq <= '0';
                clre <= '0';
                lda <= '0';
                sha <= '0';
                clra <= '0';
                decc <= '0';
                ldc2 <= '0';
                ldv <= '0';
                finish <= '0';
            WHEN t21 =>
                if c2 = "0000" then
                    -- end addition
                    state <= t3;
                    lda <= '1';
                else
                    -- continue
                    state <= t20;
                    lda <= '0';
                end if;
                decc2 <= '0';
                
                -- default values
                ldm <= '0';
                ldq <= '0';
                ldc <= '0';
                shq <= '0';
                lde <= '0';
                clre <= '0';
                sha <= '0';
                clra <= '0';
                decc <= '0';
                ldc2 <= '0';
                ldv <= '0';
                shv <= '0';
                finish <= '0';
            WHEN t3 =>
                -- shift
                sha <= '1';
                shq <= '1';
                clre <= '1';
                if c = "0000" then
                    state <= t0;
                else
                    state <= t2;
                end if;
                
                -- default values
                ldm <= '0';
                ldq <= '0';
                ldc <= '0';
                lde <= '0';
                lda <= '0';
                clra <= '0';
                decc <= '0';
                ldc2 <= '0';
                decc2 <= '0';
                ldv <= '0';
                shv <= '0';
                finish <= '0';
            WHEN others =>
                state <= t0;
        end CASE;
    end if;
end process;

end Behavioral;
