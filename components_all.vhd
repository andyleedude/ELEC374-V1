library ieee;
use ieee.std_logic_1164.all;

package components_all is 


component encoder32to5 is port(
		input : in std_logic_vector(31 downto 0);
		output: out std_logic_vector(4 downto 0)
);
end component encoder32to5;
-------------------------------------------------

--------------------------------------------------
component register64bit is Port(
D : in std_logic_vector (63 downto 0);
ld : in std_logic; 
clr : in std_logic;
clk : in std_logic;
Q0: out std_logic_vector (31 downto 0);
Q1: out std_logic_vector (31 downto 0)
); 

end component register64bit; 
---------------------------------------------
component register32bit is Port(
D : in std_logic_vector (31 downto 0);
ld : in std_logic; 
clr : in std_logic;
clk : in std_logic;
Q: out std_logic_vector (31 downto 0)); 

end component register32bit;
--------------------------------------------------
component MDR is port(
MDMux_read, MDR_enable, clr, clk: in std_logic;
MDR_in1, MDR_in2: in std_logic_vector(31 downto 0); --1 is from bus, 2 is from memory 
MDR_out: out std_logic_vector(31 downto 0)
);
end component MDR;
-------------------------------------------------

component the_bus is port (
		muxIn0		: in std_logic_vector (31 downto 0);
		muxIn1		: in std_logic_vector (31 downto 0);
		muxIn2		: in std_logic_vector (31 downto 0);
		muxIn3		: in std_logic_vector (31 downto 0);
		muxIn4		: in std_logic_vector (31 downto 0);
		muxIn5		: in std_logic_vector (31 downto 0);
		muxIn6		: in std_logic_vector (31 downto 0);
		muxIn7		: in std_logic_vector (31 downto 0);
		muxIn8		: in std_logic_vector (31 downto 0);
		muxIn9		: in std_logic_vector (31 downto 0);
		muxIn10		: in std_logic_vector (31 downto 0);
		muxIn11		: in std_logic_vector (31 downto 0);
		muxIn12		: in std_logic_vector (31 downto 0);
		muxIn13		: in std_logic_vector (31 downto 0);
		muxIn14		: in std_logic_vector (31 downto 0);
		muxIn15		: in std_logic_vector (31 downto 0);
		muxIn16		: in std_logic_vector (31 downto 0);
		muxIn17		: in std_logic_vector (31 downto 0);
		muxIn18		: in std_logic_vector (31 downto 0);
		muxIn19		: in std_logic_vector (31 downto 0);
		muxIn20		: in std_logic_vector (31 downto 0);
		muxIn21		: in std_logic_vector (31 downto 0);
		muxIn22		: in std_logic_vector (31 downto 0);
		muxIn23		: in std_logic_vector (31 downto 0);
		muxIn24		: in std_logic_vector (31 downto 0);
		muxIn25		: in std_logic_vector (31 downto 0);
		muxIn26		: in std_logic_vector (31 downto 0);
		muxIn27		: in std_logic_vector (31 downto 0);
		muxIn28		: in std_logic_vector (31 downto 0);
		muxIn29		: in std_logic_vector (31 downto 0);
		muxIn30		: in std_logic_vector (31 downto 0);
		muxIn31		: in std_logic_vector (31 downto 0);
		encoder32In	: in std_logic_vector(31 downto 0);
		BusMuxOut	: out std_logic_vector(31 downto 0)
);
end component the_bus;
--------------------------------------------------------

component rol32 IS
	PORT
	(
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		distance		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		result		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
end component rol32;
---------------------------------------------------------
component ror32 IS
	PORT
	(
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		distance		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		result		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
end component ror32;
-----------------------------------------------------
component lpm_add_sua IS
	PORT
	(
		add_sub		: IN STD_LOGIC ;
		dataa		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		datab		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		overflow		: OUT STD_LOGIC ;
		result		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
END component lpm_add_sua;
-------------------------------------------------------
component lpm_divida IS
	PORT
	(
		denom		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		numer		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		quotient		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
		remain		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
END component lpm_divida;
-----------------------------------------------------
component booth_logic is port(
MUcand : in std_logic_vector(31 downto 0);
MUer : in std_logic_vector(31 downto 0);
product : out std_logic_vector(63 downto 0)
);
end component booth_logic;
------------------------------------------------------
component alu is port(
A : in std_logic_vector(31 downto 0);	
B : in std_logic_vector(31 downto 0);	
ALU_sel : in std_logic_vector(4 downto 0);
overflow : out std_logic;	
C : out std_logic_vector(63 downto 0)	
);
end component alu; 
--------------------------------------------------------
component ALU_path is port(
clk, clr, Y_enable, Z_enable: in std_logic;
In1, In2: in std_logic_vector(31 downto 0);
PC_plus: in std_logic;
ALU_sel: in std_logic_vector(4 downto 0);
overflow: out std_logic;
ToLow, ToHi: out std_logic_vector(31 downto 0)
);
end component ALU_path;
----------------------------------------------------
component lpm_mua IS
	PORT
	(
		data0x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data1x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data2x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data3x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data4x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data5x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data6x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data7x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data8x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data9x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data10x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data11x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data12x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data13x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data14x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data15x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data16x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data17x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data18x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data19x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data20x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data21x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data22x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data23x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data24x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data25x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data26x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data27x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data28x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data29x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data30x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data31x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);

		sel		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		result		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);

END component lpm_mua;
-----------------------------------------------------------
component negate32 is port(
	input: in std_logic_vector(31 downto 0);
	output : out std_logic_vector(31 downto 0)	
);
end component negate32;
----------------------------------------------------------
component shr32 is port(
	input0 : in std_logic_vector(31 downto 0);	
	input1 : in std_logic_vector(31 downto 0);	
	output : out std_logic_vector(31 downto 0)	
);
end component shr32;
------------------------------------------------------------
component shl32 is port(
	input0 : in std_logic_vector(31 downto 0);	
	input1 : in std_logic_vector(31 downto 0);	
	output : out std_logic_vector(31 downto 0)
);
end component shl32;
----------------------------------------------------
component R0 is port(
	input: in std_logic_vector (31 downto 0);
	R0in: in std_logic;
	clr: in std_logic;
	clk: in std_logic;
	BAout: in std_logic;
	output : out std_logic_vector (31 downto 0)
);
end component R0;
---------------------------------------------------------
component sel_and_encode is port (
	IR_in: in std_logic_vector(31 downto 0);
	Gra: in std_logic;
	Grb: in std_logic;
	Grc: in std_logic;
	Rin: in std_logic;
	Rout: in std_logic;
	BAout: in std_logic;
	C_extended: out std_logic_vector(31 downto 0);
	R_in: out std_logic_vector(15 downto 0);
	R_out: out std_logic_vector(15 downto 0)
);
end component sel_and_encode;
---------------------------------------------------------
component conff_logic is port (
	clk : in std_logic;
	clr: in std_logic;
	C2_bits: in std_logic_vector(1 downto 0);
	Busmux_in: in std_logic_vector(31 downto 0);
	Con_in: in std_logic;
	Q: out std_logic
);
end component conff_logic;
-----------------------------------------------------------
component Ram512x32 IS
	PORT
	(
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		rdaddress		: IN STD_LOGIC_VECTOR (8 DOWNTO 0);
		rden		: IN STD_LOGIC  := '1';
		wraddress		: IN STD_LOGIC_VECTOR (8 DOWNTO 0);
		wren		: IN STD_LOGIC  := '0';
		q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
end component Ram512x32;
---------------------------------------------------------

component RAM_512x32 is port(
   data	: in std_logic_vector(31 downto 0);
   address	: in std_logic_vector(8 downto 0);
   wren	: in std_logic;
	rden	: in std_logic;
   q	: out std_logic_vector(31 downto 0)
);
end component RAM_512x32;
-------------------------------------------------

component Ram_mod IS
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (8 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		rden		: IN STD_LOGIC  := '1';
		wren		: IN STD_LOGIC ;
		q			: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
END component Ram_mod;
-----------------------------------------------------
TYPE state IS (reset_state0, reset_state1, fetch0, fetch1, fetch2, fetch3, add3, add4, add5, sub3, sub4, sub5, mul3, mul4, mul5, mul6, and3, and4, and5, or3, or4, or5, div3, div4, div5, div6, andi3, andi4, andi5, ori3, ori4, ori5, branch3, branch4, jr3, jal3, jal4, in3, mfhi3, mflo3, shr3, shr4, shr5, shl3, shl4, shl5, ror3, ror4, ror5, rol3, rol4, rol5, neg3, neg4, not3, not4, ld3, ld4, ld5, ld6, ld7, ldi3, ldi4, ldi5, ldr2, ldr3, ldr4, ldr5, ldr6, addi3, addi4, addi5, out3, st3, st4, st5, st6, str3, str4, str5, str6, nop, halt);
------------------------------------------------------
component control_unit is port (
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
end component control_unit; 

end package;