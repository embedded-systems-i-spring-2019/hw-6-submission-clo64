-- Charles Owen
-- Embedded Systems
-- HW 6
-- Number 4


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity number_4 is
    Port(
    
    CLK          : in std_logic;
    Z1, Z2       : out std_logic;
    Y            : out std_logic_vector(1 downto 0);
    X1, X2, INIT : in std_logic

    );
end number_4;

architecture Behavioral of number_4 is

type state_type is (A, B, C);
signal PS, NS   : state_type;

begin

sync_p  : process(CLK, NS, INIT)
          begin
          
          if(INIT = '1') then PS <= A; -- Treating INIT as a reset, because not sure what to do.
          elsif(rising_edge(CLK)) then PS <= NS; -- sent email to inqurie but didn't hear back
          end if;
          
          end process;
          
comb_p  : process(PS, X1, X2)
          begin
          
          case (PS) is
          when A => Z1 <= '0';
           if (X1 = '1') then NS <= B; Z2 <= '1';
           else NS <= C; Z2 <= '0';
           end if;
          
          when B => Z1 <= '1';
           if (X1 = '1') then NS <= A; Z2 <= '0';
           else NS <= C; Z2 <= '1';
           end if;
           
           
          when C => Z1 <= '1';
           if (X1 = '1') then NS <= B; Z2 <= '1';
           else NS <= A; Z2 <= '1';
           end if;
          end case;
          
          end process;
          

end Behavioral;
