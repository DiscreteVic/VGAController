LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY Top_Entity IS
    PORT ( 
        ARDUINO_IO : INOUT STD_LOGIC_VECTOR(15 downto 0) ;
        KEY : IN STD_LOGIC_VECTOR(1 downto 0) ;
        LEDR : OUT STD_LOGIC_VECTOR(9 downto 0)) ;
END Top_Entity ;

ARCHITECTURE LogicFunction OF Top_Entity IS

    COMPONENT ledTest is
        PORT ( 
            testKey : IN STD_LOGIC ;
            testLed : OUT STD_LOGIC );
    END COMPONENT;

BEGIN

    G1: ledTest port map (KEY(0), ARDUINO_IO(13));

END LogicFunction ;