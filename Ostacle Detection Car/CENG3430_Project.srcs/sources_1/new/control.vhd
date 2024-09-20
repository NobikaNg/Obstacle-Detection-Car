library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity control is
    Port (
        dis: in std_logic;
        clk: in std_logic;
        movement: buffer std_logic := '0';
--        finish: in std_logic;
        h: buffer integer;--??????
        z: buffer integer; --??????
        movtmp: buffer std_logic;
        endd : in std_logic;
        trigger : in integer;
        finish : in std_logic;
        go_ahead_1: out std_logic;
        go_ahead_2: out std_logic
--        ld0 : out std_logic 
    );
end control;

architecture Behavioral of control is

component clock_divider
        generic (N : integer);
    port (
        clk : in std_logic;
        clk_out : buffer std_logic
        );
end component;
signal clk4Hz: std_logic;
signal clk100000Hz: std_logic;
signal direct: integer range 0 to 3;
signal tmp : std_logic;
signal tmpp : std_logic;
--signal ld0_sub: std_logic;
--0??????
--1??????
--2??????
--3??????

begin
comp_clk4Hz: clock_divider generic map(N => 12500000) port map(clk, clk4Hz);
comp_clk100000Hz: clock_divider generic map(N => 500) port map(clk, clk100000Hz);
    
    process(trigger)--??movement???????
    begin

    if trigger = 1 then
     if dis = '1' then
      movement <= '0';
      if direct = 0 then direct <= 1;
      elsif direct = 1 then direct <= 2;
      elsif direct = 2 then direct <= 3;
      elsif direct = 3 then direct <= 0;
      end if;
     else
      movement <= '1';
      if direct = 0 then h <= h + 1;
      elsif direct = 1 then z <= z - 1;
      elsif direct = 2 then h <= h - 1;
      elsif direct = 3 then z <= z + 1;
      end if;
     end if;
    movtmp <= '1';
    else
    movtmp <= '0';
    end if;
    end process;
end Behavioral;

