LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY somasub IS
PORT	(	A,B		:	IN STD_LOGIC_VECTOR(4 DOWNTO 0);
			EnA, EnB, InvA, InvB, C0	:	IN STD_LOGIC;
			E		:	OUT STD_LOGIC;
			Rs		:  OUT STD_LOGIC_VECTOR(4 DOWNTO 0));
END somasub;
ARCHITECTURE func OF somasub IS

SIGNAL Ay, By  : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL C: STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL InvAn, InvBn: STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL Ai, Bi : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL EnAn, EnBn : STD_LOGIC_VECTOR(4 DOWNTO 0);

COMPONENT FA
PORT	(	Ai, Bi, Cin		:	IN STD_LOGIC;
			Cout, Si			:	OUT STD_LOGIC);
END COMPONENT;

BEGIN
	C(0) <= C0;
	EnAn <= EnA & EnA & EnA & EnA & EnA;
	EnBn <= EnB & EnB & EnB & EnB & EnB;
	Ai <= A AND EnAn;
	Bi <= B AND EnBn;
	InvAn <= InvA & InvA & InvA &InvA &InvA;
	InvBn <= InvB & InvB & InvB & InvB & InvB;
	By <= Bi XOR InvBn;
	Ay <= Ai XOR InvAn;
	FA0: FA PORT MAP (Ay(0), By(0), C(0), C(1), Rs(0));
	FA1: FA PORT MAP (Ay(1), By(1), C(1), C(2), Rs(1));
	FA2: FA PORT MAP (Ay(2), By(2), C(2), C(3), Rs(2));
	FA3: FA PORT MAP (Ay(3), By(3), C(3), C(4), Rs(3));
	FA4: FA PORT MAP (Ay(4), By(4), C(4), C(5), Rs(4));
	E <= C(5) XOR C(4);