library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity main_file is
  Port (
    clk: in std_logic;
    sel: buffer std_logic := '0';
    ssd: out std_logic_vector(6 downto 0);
    sw0 : in std_logic;
    sw1 : in std_logic;
    sw2 : in std_logic;
    sw3 : in std_logic;
    sw4 : in std_logic;
    sw5 : in std_logic;
    sw6 : in std_logic;
    sw7 : in std_logic;
    btnC : in std_logic;
    ld0 : out std_logic := '0';
    ld1 : out std_logic;
    ld2 : out std_logic;--??????
    ld3 : out std_logic := '0';
    ld4 : out std_logic := '0';
    ld5 : out std_logic;
    ld6 : out std_logic;
    ld7 : out std_logic := '0';
    trig : buffer STD_LOGIC;--trigger
    echo : in STD_LOGIC;
    go_ahead_1: out std_logic;
    go_ahead_2: out std_logic );
end main_file;

architecture Behavioral of main_file is

component clock_divider
        generic (N : integer);
    port (
        clk : in std_logic;
        clk_out : buffer std_logic
        );
end component;

component sonar
    port (
        clk : in std_logic;
        trig : buffer STD_LOGIC;
        echo : in STD_LOGIC;
        tri : in std_logic;

--        ld0 : out std_logic;
        ld1 : out std_logic;
        ld2 : out std_logic;
        ld2_sub : buffer std_logic;
        ld5 : out std_logic;
        ld6 : out std_logic;
        dis : buffer std_logic;
        trigger : in integer := -1;
        testwhy : buffer std_logic;
        ld7 : out std_logic;
        go_ahead_1: out std_logic;
           go_ahead_2: out std_logic
        );
end component;

component control
    Port (
        dis: in std_logic;
        clk: in std_logic;
        movement: buffer std_logic := '0';
        h: buffer integer;--??????
        z: buffer integer;
        movtmp: buffer std_logic;
        finish: in std_logic;
        trigger : in integer;
        go_ahead_1: out std_logic;
        go_ahead_2: out std_logic);
--        ld0 : out std_logic);
end component;

component ssd_ctrl
port (
clk: in std_logic;
data_in: in std_logic_vector (7 downto 0);
sel: buffer std_logic :='0';
ssd: out std_logic_vector (6 downto 0)
);
end component;

signal tmp1p : std_logic;
signal out_data: STD_LOGIC_VECTOR(7 downto 0);
signal clk1000000Hz: std_logic;
signal clk1Hz: std_logic;
signal clk4Hz: std_logic;
signal tri : std_logic := '0';
signal dis : std_logic;
signal movement : std_logic;
signal finish : std_logic;
signal hn: integer;
signal zn: integer;
signal h: integer := 0;
signal z: integer := 0;
signal display: std_logic_vector(7 downto 0);
signal movtmp: std_logic;
signal ld2_sub: std_logic;
signal ld2_subp: std_logic;

signal endd: std_logic;
signal tri1: std_logic;
signal tri2: std_logic;
signal tri3: std_logic;
signal state: integer := -1;
signal trigger : integer;
signal tmp1 : std_logic;
signal testp : std_logic;
signal testwhy : std_logic;
signal zb: integer := 0;


begin
comp_clk1000000Hz: clock_divider generic map(N => 50) port map(clk, clk1000000Hz);--1us
comp_clk1Hz: clock_divider generic map(N => 50000000) port map(clk, clk1Hz);
comp_clk4Hz: clock_divider generic map(N => 12500000) port map(clk, clk4Hz);

sonar_inst: sonar port map (
    clk => clk,
    trig => trig,
    echo => echo,
    tri => tri,
--    ld0 => ld0,
    ld1 => ld1,
    ld2 => ld2,
    ld2_sub => ld2_sub,
    ld5 => ld5,
    ld6 => ld6,
    dis => dis,
    go_ahead_1 => go_ahead_1,
    go_ahead_2 => go_ahead_2,
    trigger => trigger,
    testwhy => testwhy);
    
control_inst: control port map (
    dis => dis,
    clk => clk,
    movement => movement,
    h => hn,
    z => zn,
    movtmp => movtmp,
    finish => finish,
    trigger => trigger,
    go_ahead_1 => go_ahead_1,
    go_ahead_2 => go_ahead_2);

ssd_ctrl_port_map: ssd_ctrl port map(clk => clk, data_in => out_data, sel => sel, ssd=>ssd);

process(clk1000000Hz)
 variable count: integer := 5000000;
begin
--if rising_edge (btnC) then
-- if count <1000000 then
--  count := count + 1;
-- else
--  zb <= '1';
-- end if;
--end if;

if rising_edge (clk1000000Hz) then
 if btnC= '1' then
    count := 0;
    zb <= 1;
    ld0 <= '0';
 elsif count < 20000000 then
    count := count + 1;
 elsif zb = 1 then
    zb <= 2;
 end if;
end if;
end process;
  

process(clk)--FSM
 variable count: integer := 0;
begin

if rising_edge(clk) then
 
  if state = -1 then
   if btnC = '1' then
    state <= 0;
   end if;
  elsif state = 0 then
   if ld2_sub = '1' then
    state <= 1;
   else 
    state <= 0;
   end if;
  elsif state = 1 then
   if tmp1 = '1' then
    state <= 0;
   else 
    state <= 1;
   end if;
  end if;
 end if;
end process;

process (state, zb)--trigger????? & ??h?z??
begin
if state = -1 then
-- ld0 <= '1';
--elsemovtmp <= '1';
-- ld0 <= '0';
end if;
if zb = 2 then
 trigger <= -1;
 ld0 <= '1';
elsif state = 0 then
 trigger <= 0;
elsif state = 1 then
 trigger <= 1;
end if;

if state = -1 then
 if sw0 = '1' then h <= 1;
 elsif sw1 = '1' then h <= 2;
 elsif sw2 = '1' then h <= 3;
 elsif sw3 = '1' then h <= 4;
 end if;
 
 if sw4 = '1' then z <= 1;
 elsif sw5 = '1' then z <= 2;
 elsif sw6 = '1' then z <= 3;
 elsif sw7 = '1' then z <= 4;
 end if;
end if;
end process;

process(state)
begin
if state = 0 then
-- ld0 <= '1';
 ld3 <= '1';
 ld4 <= '0';
end if;
if state = 1 then
 ld3 <= '0';
 ld4 <= '1';
end if;
if state = 2 then
 ld3 <= '0';
 ld4 <= '0';
end if;
if state = 3 then
 ld3 <= '1';
 ld4 <= '1';
end if;
end process;

process(clk1Hz)
variable count : integer := -1;
begin
if rising_edge (clk1Hz) then
 if count = -1 then
  if btnC = '1' then
   count := 0;
   display <= "00000000";
  end if;
 elsif count < 20 then
  count := count + 1;
  display <= std_logic_vector(to_unsigned(count, 8));
 else
  display <= "11111111";
  count := -1;
 end if;
end if;
end process;

process(movtmp)--???????? & ???? & ??tri
begin
if movtmp = '1' then
 if hn = h and zn = z then
--  display <= "11111111";
 else
--  display (7 downto 4) <= std_logic_vector(to_unsigned(hn, 4));
--  display (3 downto 0) <= std_logic_vector(to_unsigned(zn, 4)); 
  tmp1 <= '1';--?????????????
 end if;
 else
  tmp1 <= '0';
end if;
end process;

process(clk4Hz)--set displaying figure
begin
if rising_edge(clk4Hz) then
 out_data <= display;
end if;
end process;

end Behavioral;

