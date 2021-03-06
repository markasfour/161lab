library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity my_alu is
generic(NUMBITS : natural := 32);
    Port ( A : in  STD_LOGIC_VECTOR(NUMBITS - 1 downto 0);	
           B : in  STD_LOGIC_VECTOR(NUMBITS - 1 downto 0);
           opcode : in  STD_LOGIC_VECTOR(3 downto 0);
           result : out  STD_LOGIC_VECTOR(NUMBITS + 3 downto 0);
           carryout : out  STD_LOGIC;
           overflow : out  STD_LOGIC;
           zero : out  STD_LOGIC);
end my_alu;

signal Aout : std_logic_vector(NUMBITS -1 downto 0);
signal Bout : std_logic_vector(NUMBITS -1 downto 0);
signal Rout : std_logic_vector(NUMBITS -1 downto 0);

architecture structural of my_alu is
	
	bcd_binA:bcd_bin
	port map (
		I => A;
		opcode => opcode;
		O => Ain;
	);
	
	bcd_binB:bcd_bin
	port map (
		I => B;
		opcode => opcode;
		O => Bin;
	);
	
	alu:bin_alu
	port map (
		A => Ain;
		B => Bin;
		opcode => opcode;
		overflow => overflow;
		carryout => carryout;
		zero => zero;
		result => Rout;
	);
	
	bin_bcdOut:bin_bcd
	port map (
		I => Rout;
		opcode => opcode;
		O => result;
	);
	
end architecture structural;
