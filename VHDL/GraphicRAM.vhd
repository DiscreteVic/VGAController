LIBRARY ieee ;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use STD.textio.all;
use ieee.std_logic_textio.all;

ENTITY GraphicRAM IS
    PORT ( 
        clk: IN STD_LOGIC;
        r, g, b : OUT STD_LOGIC_VECTOR(3 downto 0);
        row : OUT STD_LOGIC_VECTOR(9 downto 0);
        col : OUT STD_LOGIC_VECTOR(9 downto 0));
END GraphicRAM ;

ARCHITECTURE LogicFunction OF GraphicRAM IS
    type memRAM is array (0 to 639, 0 to 479) of STD_LOGIC_VECTOR(11 downto 0);
    signal gMem : memRAM;
    signal idxCol : integer := 0;
    signal idxRow : integer := 0;
    
    PROCESS
    BEGIN 
        file_open(file_mem, "mem.txt", read_mode);

        WHILE NOT endfile(file_mem) LOOP
            IF idxCol <= 639 and idxRow <= 479
                THEN
                    read(file_mem, gMem(idxCol, idxRow))
                    idxCol <= idxCol + 1;
                ELSE IF idxCol > 639 
                    THEN 
                        idxCol <= 0;                            
                        IF idxRow > 479
                            THEN idxRow <= 0;
                            ELSE 
                                THEN idxRow <= idxRow + 1;
                        ELSE IF;
                END IF;
            END IF;

        END LOOP;

        file_close(file_mem)
    END PROCESS ;


END LogicFunction ;