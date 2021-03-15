library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity booth_logic is port(
MUcand : in std_logic_vector(31 downto 0);
MUer : in std_logic_vector(31 downto 0);
product : out std_logic_vector(63 downto 0)
);
end entity booth_logic;

architecture logic of booth_logic is
begin
process(MUcand, MUer)
variable sum : signed(63 downto 0) := (others => '0');
variable M : signed(63 downto 0);
variable q : signed(32 downto 0);
	begin
	M := resize(signed(MUcand),  M'length);
	q(0) := '0';
	q(32 downto 1) := signed(MUer);
	for i in 0 to 31 loop
		if(q(0) = '0' and q(1) = '1') then
			sum := sum - (M sll i);
		elsif(q(0) = '1' and q(1) = '0') then
			sum := sum + (M sll i);
		end if;
		q := q srl 1;
	end loop;
	product <= std_logic_vector(sum);
	sum := (others => '0');
	end process;
end architecture logic;