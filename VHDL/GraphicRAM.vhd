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

    type mem_t is array(0 to 307200) of STD_LOGIC_VECTOR(11 downto 0);
    signal ram: mem_t;
    attribute ram_init_file : string;
    attribute ram_init_file of ram : signal is "mem.mif";

    
    signal pix: unsigned(11 downto 0);
    signal pixR, pixB, pixG: unsigned(3 downto 0);
    signal idxCol : integer := 0;
    signal idxRow : integer := 0;
    signal staticValue : STD_LOGIC_VECTOR(11 downto 0) := X"F00";





BEGIN


    idxCol <= to_integer(unsigned(col));
    idxRow <= to_integer(unsigned(row));

    pix <= unsigned(ram((idxRow*640)+idxCol));

    pixR <= resize(shift_right(unsigned(pix), 8), 4);
    pixG <= resize(shift_right(unsigned(pix), 4), 4);
    pixB <= resize(unsigned(pix), 4);

    b <= STD_LOGIC_VECTOR(pixB);
    g <= STD_LOGIC_VECTOR(pixG);
    r <= STD_LOGIC_VECTOR(pixR); 

END LogicFunction ;