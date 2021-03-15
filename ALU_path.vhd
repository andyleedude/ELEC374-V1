library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.components_all.all;

entity ALU_path is port(
clk:in std_logic;
clr:in std_logic; 
Y_enable:in std_logic; 
Z_enable: in std_logic;
In1: in std_logic_vector(31 downto 0);
In2: in std_logic_vector(31 downto 0);
PC_plus: in std_logic;
ALU_sel: in std_logic_vector(4 downto 0);
overflow: out std_logic;
ToLow:out std_logic_vector(31 downto 0); 
ToHi: out std_logic_vector(31 downto 0)
);
end entity ALU_path;

architecture structure of ALU_path is 
signal Yout: std_logic_vector(31 downto 0);
signal Zin: std_logic_vector(63 downto 0);
signal ALU_out: std_logic_vector(63 downto 0);
signal PCinc: std_logic_vector(63 downto 0);

begin 
register_Y: register32bit port map (In1, Y_enable, clr, clk, Yout);
the_alu: alu port map(Yout, In2, AlU_sel, overflow, ALU_out);
register_Z: register64bit port map(Zin, Z_enable, clr, clk, ToLow, ToHi);

PCinc(31 downto 0)<= std_logic_vector(unsigned(In1)+1); --increment the content of PC by 1
PCinc(63 downto 32)<= (others=>'0');

Zin<= PCinc when PC_plus ='1' else 
		ALU_out; -- the mux between alu and Z

end architecture structure;

