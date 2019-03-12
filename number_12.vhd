-- Charles Owen
-- Embedded Systems
-- HW 6
-- Problem 12

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity number_12 is 
    Port( 
  
    CLK         : in std_logic;
    X1, X2      : in std_logic;
    Z1, Z2      : out std_logic;
    Y           : out std_logic_vector(1 downto 0)
    
    );
end number_12;

architecture Behavioral of number_12 is

type state_type is (A, B, C);
attribute ENUM_ENCODING: STRING;
attribute ENUM_ENCODING of state_type: type
    is "11 01 00"; -- in order A, B, C
    
signal PS, NS   : state_type;

begin

synch_p: process (CLK, NS)
         begin
         
         if (rising_edge(CLK)) then
         
         PS <= NS;
         
         end if;
         
         end process;
         
comb_p: process (PS, X1, X1)
        begin
        
        case (PS) is
        
        when A => Z2 <= '1';
         if (X1 = '0') then NS <= A; Z1 <= '0';
         else NS <= B; Z1 <= '1';
         end if;
         
        when B => Z2 <= '0';
         if (X2 = '0') then NS <= C; Z1 <= '1';
         else NS <= A; Z1 <= '0';
         end if;
         
        when C => Z2 <= '1';
         if (X2 = '1') then NS <= C; Z1 <= '1';
         else NS <= A; Z1 <= '0';
         end if;
         
        end case;
        
        end process;
        
 with PS select
 
 Y <= "11" when A,
      "01" when B,
      "00" when C,
      "11" when others;


end Behavioral;
