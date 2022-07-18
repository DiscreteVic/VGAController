LIBRARY ieee ;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

ENTITY VGA_synt IS
    PORT ( 
        clk, reset: IN STD_LOGIC;
        red, green, blue : IN STD_LOGIC_VECTOR(3 downto 0);
        r, g, b : OUT STD_LOGIC_VECTOR(3 downto 0);
        hsync : OUT STD_LOGIC;
        vsync : OUT STD_LOGIC;
        row : OUT STD_LOGIC_VECTOR(9 downto 0);
        col : OUT STD_LOGIC_VECTOR(9 downto 0)) ;
END VGA_synt ;

ARCHITECTURE LogicFunction OF VGA_synt IS

    signal vOn, vVer, vHor : STD_LOGIC;
    signal hCounter, vCounter : STD_LOGIC_VECTOR(9 downto 0);

BEGIN

    h_Sync: PROCESS (clk, reset)
            BEGIN 
                IF reset='1'
                    THEN hCounter <= (others => '0');
                    ELSE IF (clk'event and clk='1')
                        THEN IF hCounter=799
                            THEN hCounter <= (others => '0');
                            ELSE hCounter <= hCounter + 1;
                        END IF;
                    END IF;
                END IF ; 
            END PROCESS ;
        
            PROCESS (hCounter)
            BEGIN 
                vHor <= '1';
                col <= hCounter;
                IF hCounter>639
                    THEN vHor <= '0';
                        col <= (others => '0');
                END IF; 
            END PROCESS ;
    
    v_Sync: PROCESS (clk, reset)
            BEGIN 
                IF reset='1'
                    THEN vCounter <= (others => '0');
                    ELSE IF (clk'event and clk='1')
                        THEN IF hCounter=699
                            THEN IF vCounter=524
                                THEN vCounter <= (others => '0');
                                ELSE vCounter <= vCounter + 1;
                            END IF;
                        END IF;
                    END IF;
                END IF ; 
            END PROCESS ;
        
            PROCESS (vCounter)
            BEGIN 
                vVer <= '1';
                row <= vCounter(9 downto 0);
                IF vCounter>479
                    THEN vVer <= '0';
                        row <= (others => '0');
                END IF; 
            END PROCESS ;
    
    sync:   PROCESS (clk, reset)
            BEGIN 
                IF reset='1'
                    THEN hsync <= '0';
                        vsync <= '0';
                    ELSE IF (clk'event and clk='1')
                        THEN IF (hCounter<=755 and hCounter>=659)
                            THEN hsync <= '0';
                            else hsync <= '1';
                        END IF;
                        IF (vCounter<=494 and vCounter>=493)
                            THEN vsync <= '0';
                            else vsync <= '1';
                        END IF;                            
                    END IF ;
                END IF ;
            END PROCESS ;

    vOn <= vHor and vVer;

    colors: PROCESS(clk, reset)
            BEGIN
                IF (clk'event and clk='1')
                THEN IF vON = '1' 
                    THEN r <= red;
                        g <= green;
                        b <= blue;
                    ELSE  r <= X"0";
                        g <= X"0";
                        b <= X"0";
                    END IF;
                END IF;
            END PROCESS;

END LogicFunction ;