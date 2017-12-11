library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity sig_gen is
   Port (clk : in STD_LOGIC;
     reset_n : in STD_LOGIC;
     clk_out : out STD_LOGIC);
end entity sig_gen;

architecture Behavioral of sig_gen is
signal clk_sig : std_logic;
begin
process(reset_n,clk)
    variable   cnt   : integer;
    begin
    if (reset_n='0') then
        clk_sig<='0';
        cnt:=0;
        elsif rising_edge(clk) then

        if (cnt=24999999) then

                clk_sig<=NOT(clk_sig);
                cnt:=0;
               else
                cnt:=cnt+1;
        end if;
     end if;
end process;

clk_out <= clk_sig;

end Behavioral;







-- Clock Divider --
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_unsigned.all;

-- Entity Declaration --
entity clkdiv is
generic( K: integer := 11);       -- Output bit (0 - 23) see below -- 
	port(
			CLOCK_50 : in STD_LOGIC;
			clr : in STD_LOGIC;
			clk_out : out STD_LOGIC
		 );
end clkdiv;

-- Architecture Definition --
architecture clkdiv of clkdiv is
signal q: STD_LOGIC_VECTOR(23 downto 0);
begin
	process(CLOCK_50, clr)
		begin
			if clr = '1' then
				q <=X"000000";
			elsif CLOCK_50'event and CLOCK_50 = '1' then
				q <= q + 1;
			end if;
		end process;
		
		clk_out <=q(K);
		
end clkdiv;

-- Table of Clock Divide Frequencies --

--   FPGA Clock = 50 MHz

-- q(i)	Frequency		  Period    --
--	 0		  25.0   MHz		40  ns   --
--	 1		  12.5   MHz		80  ns   --	
--  2		  6.25   MHz	 	160 ns   --
--  3		  3.125  MHz	 	320 ns   --
--  4		  1.563  MHz	 	640 ns   --
--  5		  781.35 kHz	 	1.28  us --
--  6		  390.6  kHz 		2.56  us --
--  7		  195.3  kHz		5.12  us --
--  8		   97.7  kHz		10.24 us --
--  9		   48.8  kHz		20.48 us --
--  10	   24.4  kHz		40.96 us --
--  11	   12.2  kHz		81.92 us --
--  12		 6.1  kHz		163.8 us --
--  13		3.05  kHz		327.7 us --
--  14		1.53  kHz		655.4 us --
--  15		762.9 kHz		1.31  ms --
--  16		381.5  Hz		2.62  ms --
--  17		190.7  Hz		5.24  ms --
--  18		 95.37 Hz		10.49 ms --
--  19		 47.68 Hz		20.97 ms --
--  20		 23.84 Hz		41.94 ms --
--  21		 11.92 Hz		83.89 ms --
--  22		  5.96 Hz		167.8 ms --
--  23		  2.98 Hz		335.5 ms --

--       End of Table        --
 