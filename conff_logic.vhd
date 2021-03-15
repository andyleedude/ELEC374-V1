library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity conff_logic is port (
	clk : in std_logic;
	clr: in std_logic;
	C2_bits: in std_logic_vector(1 downto 0);
	Busmux_in: in std_logic_vector(31 downto 0);
	Con_in: in std_logic;
	Q: out std_logic
);
end entity conff_logic;


architecture logic of conff_logic is 

signal dec_out: std_logic_vector(3 downto 0);
signal eq, neq, gte, lt: std_logic; -- equal, not equal, greater equal, less than
signal nor_out: std_logic;
signal Con_d: std_logic; 

begin 

dec_out<= "0001" when (C2_bits = "00") else
			 "0010" when (C2_bits = "01") else
			 "0100" when (C2_bits = "10") else
			 "1000";
			 
nor_out<= (not (Busmux_in(0) or Busmux_in(1) or Busmux_in(2) or Busmux_in(3) or Busmux_in(4) 
or Busmux_in(5) or Busmux_in(6) or Busmux_in(7) or Busmux_in(8) or Busmux_in(9)
or Busmux_in(10) or Busmux_in(11) or Busmux_in(12) or Busmux_in(13) or Busmux_in(14) or 
Busmux_in(15) or Busmux_in(16) or Busmux_in(17) or Busmux_in(18) or Busmux_in(19) or Busmux_in(20)
or Busmux_in(21) or Busmux_in(22) or Busmux_in(23) or Busmux_in(24) or Busmux_in(25) or 
Busmux_in(26) or Busmux_in(27) or Busmux_in(28) or Busmux_in(29) or Busmux_in(30) or Busmux_in(31)));

 
eq <= dec_out(0) and (nor_out);
neq <= dec_out(1) and (not (nor_out));
gte <= dec_out(2) and (not Busmux_in(31));
lt<= dec_out(3) and Busmux_in(31);

Con_d <= (eq or neq or gte or lt);

Conff: process(clk, Con_in, clr) 
begin 
if (clr = '0') then 
	Q<= '0';
elsif (clk'event and clk = '1') then 
	if(Con_in = '1') then 
		Q<= Con_d;
	end if;
end if;
	
end process;
end architecture logic;