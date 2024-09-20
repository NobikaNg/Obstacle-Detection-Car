library IEEE;
 use IEEE.STD_LOGIC_1164.all;
 use IEEE.Numeric_Std.all;
 
 entity clock_divider is
    generic(
            N : integer
    );
  port( 
        clk : in std_logic;
        clk_out : buffer std_logic
        );
 end clock_divider;
 
 architecture arch_clock_divider of clock_divider is
      signal counter : integer := 0;
 begin
        process (clk)
        begin
            if rising_edge(clk) then
                if (counter = (N- 1)) then
                       clk_out <= not clk_out;
                       counter <= 0;
                else
                    counter <= counter +1;
                end if;
        end if;
   end process;
 end arch_clock_divider;
