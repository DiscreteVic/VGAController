LIBRARY ieee ;
USE ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use STD.textio.all;
use ieee.std_logic_textio.all;

ENTITY GraphicRAM IS
    PORT ( 
        clk: IN STD_LOGIC;
        r, g, b : OUT STD_LOGIC_VECTOR(3 downto 0);
        row : IN STD_LOGIC_VECTOR(9 downto 0);
        col : IN STD_LOGIC_VECTOR(9 downto 0));
END GraphicRAM ;

ARCHITECTURE LogicFunction OF GraphicRAM IS

    file file_mem : text;

    type mem_t is array(0 to 479) of STD_LOGIC_VECTOR(2560 downto 0);
    signal ramR, ramG, ramB: mem_t;
    attribute ram_init_file : string;
    attribute ram_init_file of ramR : signal is "memR.mif";
    attribute ram_init_file of ramG : signal is "memG.mif";
    attribute ram_init_file of ramB : signal is "memB.mif";

    
    signal pixR, pixB, pixG: unsigned(3 downto 0);
    signal idxCol : integer := 0;
    signal idxRow : integer := 0;
    signal staticValue : STD_LOGIC_VECTOR(11 downto 0) := X"F00";





BEGIN


    idxCol <= to_integer(unsigned(col));
    idxRow <= to_integer(unsigned(row));

    pixR <= resize(shift_right(unsigned(ramR(idxRow)), idxCol) , 4);
    pixG <= resize(shift_right(unsigned(ramG(idxRow)), idxCol) , 4);
    pixB <= resize(shift_right(unsigned(ramB(idxRow)), idxCol) , 4);

    r <= STD_LOGIC_VECTOR(pixR);
    g <= STD_LOGIC_VECTOR(pixG); 
    b <= STD_LOGIC_VECTOR(pixB);

END LogicFunction ;