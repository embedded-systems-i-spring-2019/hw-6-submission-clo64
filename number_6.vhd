-- Charles Owen
-- Ebmedded Systems
-- HW 6
-- Problem 6

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity number_6 is
    port(
    
    CLK     : in std_logic;
    X       : in std_logic;
    Z1, Z2  : out std_logic;
    Y       : out std_logic_vector(1 downto 0)
    
    );
end number_6;

architecture Behavioral of number_6 is

type state_type is (A, B, C, D);
attribute ENUM_ENCODING: STRING;
attribute ENUM_ENCODING of state_type: type
    is "00 01 11 10";
    
signal NS, PS   : state_type;

begin

synch_p: process (CLK, NS)
         begin
         
         if(rising_edge(CLK)) then PS <= NS;
         
         end if;
         
         end process;
         
comb_p: process (X, PS)
        begin
        
        case PS is
        
        when A => Z1 <= '1';
         if(X = '1') then NS <= A; Z2 = '0';
         else NS <= D; Z2 <= '0';
         end if;
         
        when B => Z1 <= '0';
         if(X = '1') then NS <= B; Z2 = '0';
         else NS <= C; Z2 = '0';
         end if;
         
        when C => Z1 <= '0';
         if(X = '1') then NS <= B; Z2 = '0';
         else NS <= A; Z2 = '1';
         end if;
         
        when D => Z1 <= '1';
         if(X = '1') then NS <= A; Z2 = '0';
         else NS <= B; Z2 = '0';
         end if;
                                                
        end process;
        
with PS select

    Y <= "00" when A,
         "01" when B,
         "11" when C,
         "10" when D,
         "00" when others;


end Behavioral;
