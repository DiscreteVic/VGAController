LIBRARY ieee ;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

ENTITY Top_Entity IS
    PORT ( 
        ADC_CLK_10 : IN STD_LOGIC ;
        MAX10_CLK1_50 : IN STD_LOGIC ;
        ARDUINO_IO : INOUT STD_LOGIC_VECTOR(15 downto 0) ;
        VGA_R : OUT STD_LOGIC_VECTOR(3 downto 0) ;
        VGA_G : OUT STD_LOGIC_VECTOR(3 downto 0) ;
        VGA_B : OUT STD_LOGIC_VECTOR(3 downto 0) ;
        VGA_HS : OUT STD_LOGIC ;
        VGA_VS : OUT STD_LOGIC ;
        KEY : IN STD_LOGIC_VECTOR(1 downto 0) ;
        LEDR : OUT STD_LOGIC_VECTOR(9 downto 0)) ;
END Top_Entity ;

ARCHITECTURE LogicFunction OF Top_Entity IS

 
    COMPONENT Prescaler is
        GENERIC(
            N : INTEGER);
        PORT ( 
            clk_in : IN STD_LOGIC;
            clk_out : OUT STD_LOGIC) ;
    END COMPONENT;

    COMPONENT VGA_synt is
        PORT ( 
            clk, reset: IN STD_LOGIC;
            red, green, blue : IN STD_LOGIC_VECTOR(3 downto 0);
            r, g, b : OUT STD_LOGIC_VECTOR(3 downto 0);
            hsync : OUT STD_LOGIC;
            vsync : OUT STD_LOGIC;
            row : OUT STD_LOGIC_VECTOR(9 downto 0);
            col : OUT STD_LOGIC_VECTOR(9 downto 0)) ;
    END COMPONENT;
    
    signal clk : STD_LOGIC;
    signal row : STD_LOGIC_VECTOR(9 downto 0);
    signal col : STD_LOGIC_VECTOR(9 downto 0);

    
    signal colorR : STD_LOGIC_VECTOR(3 downto 0) := X"F";
    signal colorG : STD_LOGIC_VECTOR(3 downto 0) := X"0";
    signal colorB : STD_LOGIC_VECTOR(3 downto 0) := X"0";
    

BEGIN

    G1: Prescaler generic map (1) port map (MAX10_CLK1_50, clk);
    G2: VGA_synt port map (clk,'0', colorR, colorG, colorB, VGA_R, VGA_G, VGA_B,VGA_HS, VGA_VS, row, col);
    


END LogicFunction ;