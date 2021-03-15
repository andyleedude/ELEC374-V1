library ieee;
use ieee.std_logic_1164.all;
use work.components_all.all;

entity control_unit is port (
	clk: in std_logic;
	reset: in std_logic;
	stop: in std_logic;
	IR: in std_logic_vector (31 downto 0);
	con_ff: in std_logic; 
	Rin: out std_logic;
	Rout: out std_logic; 
	Gra: out std_logic;
	Grb: out std_logic;
	Grc: out std_logic;
	BAout: out std_logic;
	encoder_in: out std_logic_vector (31 downto 0);
	register_enable: out std_logic_vector (31 downto 0);
	MDR_read: out std_logic;
	MDR_write: out std_logic;
	IncPC: out std_logic;
	run: out std_logic;
	clear: out std_logic;
	OP_code: out std_logic_vector (4 downto 0); -- for alu selection
	status: out state
);
end entity control_unit; 

architecture behavior of control_unit is 
--Type state is in the components_all package 
signal present_state: state;
signal PCout, MDRout, Zhighout, Zlowout, HIout, LOout, Inportout: std_logic;
signal HIin, LOin, CONin, PCin, IRin, Yin, Zin, MARin, MDRin, Cout, Out_in, In_in: std_logic; -- outport, inport enable

begin
	
encoder_in(0) <= HIout;
encoder_in(1) <= LOout;
encoder_in(2) <= Zhighout;
encoder_in(3) <= Zlowout;
encoder_in(4) <= PCout;
encoder_in(5) <= MDRout;
encoder_in(6) <= Inportout;
encoder_in(7) <= Cout;
encoder_in(8) <= '0';
encoder_in(9) <= '0';
encoder_in(10) <= '0';
encoder_in(11) <= '0';
encoder_in(12) <= '0';
encoder_in(13) <= '0';
encoder_in(14) <= '0';
encoder_in(15) <= '0';

register_enable(0) <= HIin;
register_enable(1) <= LOin;
register_enable(2) <= PCin;
register_enable(3) <= IRin;
register_enable(4) <= MDRin;
register_enable(5) <= MARin;
register_enable(6) <= Yin;
register_enable(7) <= Zin;
register_enable(8) <= In_in;
register_enable(9) <= Out_in;
register_enable(10) <= CONin;
register_enable(11) <= '0';
register_enable(12) <= '0';
register_enable(13) <= '0';
register_enable(14) <= '0';
register_enable(15) <= '0';	

status <= present_state;

process (clk, reset, stop)
begin
	if (reset = '1') then
		present_state <= reset_state1;
	elsif (stop = '1') then 
		present_state <= halt;
	elsif (clk'event and clk = '1') then 
		case present_state is 
			when reset_state0 =>
				present_state <= reset_state1;
			when reset_state1 =>
				present_state <= fetch0;
			when fetch0 =>
				present_state <= fetch1;
			when fetch1 =>
				present_state <= fetch2; 
			when fetch2 =>
				present_state <= fetch3; 
			when fetch3 =>
				case IR(31 downto 27) is 
					when "00000" => 
						present_state <= ld3;
					when "00001" => 
						present_state <= ldi3;
					when "00010" =>
						present_state <= st3; 
					when "00011" =>
						present_state <= add3;
					when "00100" =>
						present_state <= sub3;
					when "00101" =>
						present_state <= shr3;
					when "00110" =>
						present_state <= shl3;
					when "00111" =>
						present_state <= ror3;
					when "01000" =>
						present_state <= rol3;
					when "01001" =>
						present_state <= and3;
					when "01010" =>
						present_state <= or3;
					when "01011" =>
						present_state <= addi3;
					when "01100" =>
						present_state <= andi3;
					when "01101" => 
						present_state <= ori3;
					when "01110" =>
						present_state <= mul3;
					when "01111" => 
						present_state <= div3;
					when "10000" =>
						present_state <= neg3;
					when "10001" =>
						present_state <= not3;
					when "10010" => 
						present_state <= branch3;
					when "10011" =>
						present_state <= jr3;
					when "10100" =>
						present_state <= jal3;
					when "10101" =>
						present_state <= in3;
					when "10110" =>
						present_state <= out3;
					when "10111" =>
						present_state <= mfhi3;
					when "11000" =>
						present_state <= mflo3;
					when "11001" => -- the nop instruction (do nothing)
						present_state <= fetch0; 
					when "11010" =>
						present_state <= halt; 
					when others=>
				end case;
				
			when add3 => 
				present_state <= add4;
			when add4 => 
				present_state <= add5;
			when add5 => 
				present_state <= fetch0;
-------------------------------------------------			
			when sub3 => 
				present_state <= sub4;
			when sub4 => 
				present_state <= sub5;
			when sub5 => 
				present_state <= fetch0;
-------------------------------------------------									
			when shr3 => 
				present_state <= shr4;
			when shr4 => 
				present_state <= shr5;
			when shr5 => 
				present_state <= fetch0;
-------------------------------------------------					
			when shl3 => 
				present_state <= shl4;
			when shl4 => 
				present_state <= shl5;
			when shl5 => 
				present_state <= fetch0;
-------------------------------------------------					
			when ror3 => 
				present_state <= ror4;
			when ror4 => 
				present_state <= ror5;
			when ror5 => 
				present_state <= fetch0;
-------------------------------------------------					
			when rol3 => 
				present_state <= rol4;
			when rol4 => 
				present_state <= rol5;
			when rol5 => 
				present_state <= fetch0;				
-------------------------------------------------					
			when and3 => 
				present_state <= and4;
			when and4 => 
				present_state <= and5;
			when and5 => 
				present_state <= fetch0;
-------------------------------------------------							
			when ld3 =>
				present_state <= ld4;
			when ld4 =>
				present_state <= ld5;
			when ld5 =>
				present_state <= ld6;
			when ld6 =>
				present_state <= ld7;
			when ld7 =>
				present_state <= fetch0;		
-------------------------------------------------						
			when ldi3 =>
				present_state <= ldi4;
			when ldi4 =>
				present_state <= ldi5;
			when ld5 =>
				present_state <= fetch0;
-------------------------------------------------									
			when st3 =>
				present_state <= st4;
			when st4 =>
				present_state <= st5;
			when st5 =>
				present_state <= st6;
			when st6 =>
				present_state <= fetch0;				
-------------------------------------------------				
			when or3 => 
				present_state <= or4;
			when or4 => 
				present_state <= or5;
			when or5 => 
				present_state <= fetch0;
				
-------------------------------------------------		
			when addi3 => 
				present_state <= addi4;
			when addi4 => 
				present_state <= addi5;
			when addi5 => 
				present_state <= fetch0;
-------------------------------------------------								
			when andi3 => 
				present_state <= andi4;
			when andi4 => 
				present_state <= andi5;
			when andi5 => 
				present_state <= fetch0;
-------------------------------------------------							
			when ori3 => 
				present_state <= ori4;
			when ori4 => 
				present_state <= ori5;
			when ori5 => 
				present_state <= fetch0;
-------------------------------------------------									
			when mul3 =>
				present_state <= mul4;
			when mul4 =>
				present_state <= mul5;
			when mul5 =>
				present_state <= mul6;
			when mul6 =>
				present_state <= fetch0;
-------------------------------------------------														
			when div3 =>
				present_state <= div4;
			when div4 =>
				present_state <= div5;
			when div5 =>
				present_state <= div6;
			when div6 =>
				present_state <= fetch0;
-------------------------------------------------									
			when neg3 =>
				present_state <= neg4;
			when neg4 =>
				present_state <= fetch0;
-------------------------------------------------										
			when not3 =>
				present_state <= not4;
			when not4 =>
				present_state <= fetch0;				
-------------------------------------------------						
			when branch3 =>
				present_state <= branch4;
			when branch4 =>
				present_state <= fetch0;
-------------------------------------------------						
			when jr3 =>
				present_state <= fetch0;		
-------------------------------------------------						
			when jal3 =>
				present_state <= jal4;
			when jal4 =>
				present_state <= fetch0;				
-------------------------------------------------					
			when in3 =>
				present_state <= fetch0;	
-------------------------------------------------						
			when out3 =>
				present_state <= fetch0;
-------------------------------------------------						
			when mfhi3 =>
				present_state <= fetch0;
-------------------------------------------------						
			when mflo3 =>
				present_state <= fetch0;
-------------------------------------------------					
			when halt =>
			when others=>
		end case;
end if;
end process;
				
				
process(present_state) 
begin

	case present_state is 
		when reset_state0 => -- initialize everything 
			Gra<= '0';
			Grb<= '0';
			Grc<= '0';
			BAout <= '0';
			Rin <= '0';
			Rout <= '0';	
			IncPC <= '0';
			MDR_read <= '0';
			MDR_write <= '0';	
			OP_code <= "00000";
			HIout <= '0';
			LOout <= '0';
			Zhighout <= '0';
			Zlowout <= '0';
			PCout <= '0';
			MDRout <= '0';
			Inportout <= '0';
			Cout <= '0';
			HIin <= '0';
			LOin <= '0';
			PCin <= '0';
			IRin <= '0';
			MDRin <= '0';
			MARin <= '0';
			Yin <= '0';
			Zin <= '0';
			In_in <= '0';
			Out_in <= '0';
			CONin <= '0';
			clear <= '0';
			run <= '0';
		when reset_state1 => -- when reset ='1'
			clear <= '1'; -- set all the register to zero 
			run <= '1'; 
		when fetch0 =>
			Zin <='1';
			PCout <= '1';
			MARin <= '1';
			IncPC <= '1';
		when fetch1 =>
			Zlowout <= '1';
			PCin <= '1';
			MDR_read <= '1';
			MDRin <= '1';
		when fetch2 =>
			MDRout <= '1';
			IRin <= '1';
		when fetch3 => -- choose according to IR
-----------------------------------------------------------		
		when add3 =>
			Rout <= '1';
			Grb <= '1';
			Yin <= '1';
		when add4 =>
			Rout <= '1';
			Grc <= '1';
			OP_code <= "00011"; --add
			Zin <= '1';
		when add5 =>
			Zlowout <= '1';
			Rin <= '1';
			Gra <= '1';
			
-----------------------------------------------------------		
		when sub3 =>
			Rout <= '1';
			Grb <= '1';
			Yin <= '1';
		when sub4 =>
			Rout <= '1';
			Grc <= '1';
			OP_code <= "00100";
		when sub5 =>
			Zlowout <= '1';
			Rin <= '1';
			Gra <= '1';
-----------------------------------------------------------	
		when mul3 =>
			Rout <= '1';
			Gra<= '1';
			Yin <= '1';
		when mul4 =>
			Rout <= '1';
			Grb <= '1';
			OP_code <= "01110";
			Zin <= '1';
		when mul5 =>
			Zlowout <= '1';
			LOin <= '1';
		when mul6 =>
			Zhighout <= '1';
			HIin <= '1';
-----------------------------------------------------------	
		when and3 =>
			Rout <= '1';
			Grb <= '1';
			Yin <= '1';
		when and4 =>
			Rout <= '1';
			Grc <= '1';
			OP_code <= "01001";
			Zin <= '1';
		when and5 =>
			Zlowout <= '1';
			Rin <= '1';
			Gra <= '1';
----------------------------------------------------------
		when or3 =>
			Rout <= '1';
			Grb <= '1';
			Yin <= '1';
		when or4 =>
			Rout <= '1';
			Grc <= '1';
			OP_code <= "01010";
			Zin <= '1';
		when or5 =>
			Zlowout <= '1';
			Rin <= '1';
			Gra <= '1';
----------------------------------------------------------
		when div3 =>
			Rout <= '1';
			Gra<= '1';
			Yin <= '1';
		when div4 =>
			Rout <= '1';
			Grb <= '1';
			OP_code <= "01111";
			Zin <= '1';
		when div5 =>
			Zlowout <= '1';                
			LOin <= '1';
		when div6 =>
			Zhighout <= '1';
			HIin <= '1';
----------------------------------------------------------
		when shr3 =>
			Rout <= '1';
			Grb <= '1';
			Yin <= '1';
		when shr4 =>
			Rout <= '1';
			Grc <= '1';
			OP_code <= "00101";
			Zin <= '1';
		when shr5 =>
			Zlowout <= '1';
			Rin <= '1';
			Gra <= '1';	
----------------------------------------------------------
		
		when shl3 =>
			Rout <= '1';
			Grb <= '1';
			Yin <= '1';
		when shl4 =>
			Rout <= '1';
			Grc <= '1';
			OP_code <= "00110";
			Zin <= '1';
		when shl5 =>
			Zlowout <= '1';
			Rin <= '1';
			Gra <= '1';
----------------------------------------------------------
		when ror3 =>
			Rout <= '1';
			Grb <= '1';
			Yin <= '1';
		when ror4 =>
			Rout <= '1';
			Grc <= '1';
			OP_code <= "00111";
			Zin <= '1';
		when ror5 =>
			Zlowout <= '1';
			Rin <= '1';
			Gra <= '1';
----------------------------------------------------------
		when rol3 =>
			Rout <= '1';
			Grb <= '1';
			Yin <= '1';
		when rol4 =>
			Rout <= '1';
			Grc <= '1';
			OP_code <= "01000";
			Zin <= '1';
		when rol5 =>
			Zlowout <= '1';
			Rin <= '1';
			Gra <= '1';
----------------------------------------------------------

		when neg3 =>
			Rout <= '1';
			Grb <= '1';
			OP_code <= "10000";
			Zin <= '1';
		when neg4 =>
			Zlowout <= '1';
			Gra <= '1';
			Rin <= '1';
----------------------------------------------------------				
		when not3 =>
			Rout <= '1';
			Grb <= '1';
			OP_code <= "10001";
			Zin <= '1';
		when not4 =>
			Zlowout <= '1';
			Gra <= '1';
			Rin <= '1';
----------------------------------------------------------				
----------------------------------------------------------

		when andi3 =>
			Rout <= '1';
			Grb <= '1';
			Yin <= '1';
		when andi4 =>
			Cout <= '1';
			OP_code <= "01100";
			Zin <= '1';
		when andi5 =>
			Zlowout <= '1';
			Rin <= '1';
			Gra <= '1';	
----------------------------------------------------------				
		when ori3 =>
			Rout <= '1';
			Grb <= '1';
			Yin <= '1';
		when ori4 =>
			Cout <= '1';
			OP_code <= "01101";
			Zin <= '1';
		when ori5 =>
			Zlowout <= '1';
			Rin <= '1';
			Gra <= '1';	
----------------------------------------------------------

		when addi3 =>
			Rout <= '1';
			Grb <= '1';
			Yin <= '1';
		when addi4 =>
			Cout <= '1';
			OP_code <= "01011";
			Zin <= '1';
		when addi5 =>
			Zlowout <= '1';
			Rin <= '1';
			Gra <= '1';	
----------------------------------------------------------				
		when branch3 =>
			Rout <= '1';
			Gra <= '1';
			CONin <= '1';
		when branch4 =>
			Grb <= '1';
			Rout <= '1';
			if(con_ff = '1') then
				PCin <= '1';
			end if;
----------------------------------------------------------	
		when jr3 =>
			Rout <= '1';
			Gra <= '1';
			PCin <= '1';
----------------------------------------------------------					
		when jal3 =>
			Rin <= '1';
			Grb <= '1';
			PCout <= '1';	
		when jal4 =>
			Rout <= '1';
			Gra <= '1';
			PCin <= '1';
----------------------------------------------------------	
		when in3 =>
			Rin <= '1';
			Gra <= '1';
			inportout <= '1';
----------------------------------------------------------		
		when out3 =>
			Gra <= '1';
			Rout <= '1';
			Out_in <= '1';
----------------------------------------------------------				
		when mfhi3 =>
			Rin <= '1';
			Gra <= '1';
			HIout <= '1';
----------------------------------------------------------					
		when mflo3 =>
			Rin <= '1';
			Gra <= '1';
			LOout<= '1';
----------------------------------------------------------	
		when ld3 =>
			BAout <= '1';
			Grb <= '1';
			Yin <= '1';
		when ld4 =>
			Cout <= '1';
			OP_code <= "00011";
			Zin <= '1';
		when ld5 =>
			Zlowout <= '1';
			MARin <= '1';
		when ld6 =>
			MDR_read <= '1';
			MDRin <= '1';
		when ld7 =>
			MDRout <= '1';
			Gra <= '1';
			Rin <= '1';
----------------------------------------------------------	
		when ldi3 =>
			BAout <= '1';
			Grb <= '1';
			Yin <= '1';
		when ldi4 =>
			Cout <= '1';
			OP_code <= "00011";
			Zin <= '1';
		when ldi5 =>
			Zlowout <= '1';
			Gra <= '1';
			Rin <= '1';
----------------------------------------------------------	
		when st3 =>
			BAout <= '1';
			Grb <= '1';
			Yin <= '1';
		when st4 =>
			Cout <= '1';
			OP_code <= "00011";
			Zin <= '1';
		when st5 =>
			Zlowout <= '1';
			MARin <= '1';
		when st6 =>
			MDR_write <= '1';
			Gra <= '1';
			Rout <= '1';
			MDRin <= '1';
----------------------------------------------------------	
		when nop =>
		when halt =>
			run <= '0';
		when others=>
	end case;
end process;
end behavior;