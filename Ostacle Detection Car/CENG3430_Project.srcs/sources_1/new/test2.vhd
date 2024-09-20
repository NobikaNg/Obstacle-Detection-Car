library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity sonar is
    Port ( clk : in STD_LOGIC;
           trig : buffer STD_LOGIC;
           echo : in STD_LOGIC;
           tri : in std_logic;

--           btnC : in std_logic;
--           ld0 : out std_logic;
           ld1 : out std_logic;
           ld2 : out std_logic;
           ld2_sub : buffer std_logic;
           ld5 : out std_logic;
           ld6 : out std_logic;
           ld7 : out std_logic := '0';
           dis : buffer std_logic;
           trigger : in integer;
           testwhy : buffer std_logic;
           go_ahead_1: out std_logic;
           go_ahead_2: out std_logic);
end sonar;
architecture sonar_arch of sonar is

component clock_divider
        generic (N : integer);
    port (
        clk : in std_logic;
        clk_out : buffer std_logic
        );
end component;

signal clk1000000Hz: std_logic;
signal clk1Hz: std_logic;
signal state: integer := 3;
signal echocount : integer := 0;
signal token : std_logic := '0';
signal testp : std_logic;

begin
 comp_clk1000000Hz: clock_divider generic map(N => 50) port map(clk, clk1000000Hz);--1us
 comp_clk1Hz: clock_divider generic map(N => 50000000) port map(clk, clk1Hz);

process(clk)
begin
if trigger = 0 then
 token <= '1';
elsif ld2_sub = '1' then
 token <= '0';
end if;
end process;

process(clk1000000Hz)
 variable count: integer := 0;
begin

if rising_edge(clk1000000Hz) then
 
  if state = 0 then
   if count < 10 then
    count := count + 1;
   else
    count := 0;
    state <= 1;
   end if;
  elsif state = 1 then
   if count < 40000 then
    count := count + 1;
   else
    count := 0;
    state <= 2;
   end if;
  elsif state = 2 then
   if count < 1000000 then--1s
    count := count + 1;
   else
    count := 0;
    state <= 3;
   end if;
  elsif state = 3 then
   if token = '1' then
    state <= 0;
   end if;
  end if;
 end if;
end process;

process(state)
begin
if state = 0 then
 trig <= '1';
else
 trig <= '0';
end if;
end process;

process(clk1000000Hz)
begin
if rising_edge (clk1000000Hz) then
 if state = 0 then
  echocount <= 0;
 end if;
 if state = 1 then
  if echo = '1' then
   echocount <= echocount + 1;
  end if;  
 end if;
end if;
end process;

process(state)

begin
if state = 2 then
 if echocount < 2000 then
  ld5 <= '1';
  ld6 <= '0';
  dis <= '1';
  go_ahead_1 <= '1';
  go_ahead_2 <= '0';
 else
  ld5 <= '0';
  ld6 <= '1';
  dis <= '0';
  go_ahead_1 <= '1';
  go_ahead_2 <= '1';
  end if;
elsif state = 3 then
 go_ahead_1 <= '0';
 go_ahead_2 <= '0';
end if;
end process;
  

process(state)
begin
if state = 0 then
-- ld0 <= '1';
 ld1 <= '0';
 ld2 <= '0';
 ld2_sub <= '0';
end if;
if state = 1 then
-- ld0 <= '0';
 ld1 <= '1';
 ld2 <= '0';
 ld2_sub <= '0';
end if;
if state = 2 then
-- ld0 <= '0';
 ld1 <= '0';
 ld2 <= '1';
 ld2_sub <= '1';
end if;
if state = 3 then
-- ld0 <= '0';
 ld1 <= '0';
 ld2 <= '0';
 ld2_sub <= '0';
end if;
end process;
end sonar_arch;