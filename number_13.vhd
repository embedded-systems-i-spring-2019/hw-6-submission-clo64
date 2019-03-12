-- Charles Owen
-- Embedded Systems
-- HW 6
-- Problem 13

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity number_13 is
    Port (
    
    CLK         : in std_logic;
    X1, X2      : in std_logic;
    CS, RD      : out std_logic;
    Y           : out std_logic_vector(2 downto 0)
    
    );
end number_13;

architecture Behavioral of number_13 is

type state_type is (A, B, C);
attribute ENUM_ENCODING: STRING;
attribute ENUM_ENCODING of state_type: type
    is "001 010 100";
    
signal PS, NS   : state_type;

begin

synch_p: process (CLK, NS)
         begin
         
         if (rising_edge(CLK)) then
         
         PS <= NS;
         
         end if;
         
         end process;
         
comb_p: process (PS, X1, X2)
        begin
        
        case (PS) is
        
         when A => 
          if (X1 = '0') then NS <= B; CS <= '0'; RD <= '1';
          else NS <= C; CS <= '1';RD <= '0';
          end if;
          
         when B =>
          if (X1 = '0' or X1 = '1' or X2 = '0' or X2 = '1') then NS <= C; CS <= '1'; RD <= '1';
          end if;
          
         when C =>
          if (X2 = '0') then NS <= A; CS <= '0'; RD <= '0';
          else NS <= C; CS <= '0'; RD <= '1';
          end if;
          
         end case;  
        end process;
        
-- select simulated output below this line
 with PS select
   Y <= "001" when A,
        "010" when B,
        "100" when C,
        "001" when others;


end Behavioral;
