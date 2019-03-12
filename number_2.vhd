-- Charles Owen
-- Embedded Systems
-- HW6
-- Problem 2


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity HW6 is
    Port(
    
    CLK     : in std_logic;
    X1, X2  : in std_logic;
    Y       : out std_logic_vector(1 downto 0);
    Z       : out std_logic
    
    );
end HW6;

architecture Behavioral of HW6 is

type state_type is (A, B, C);
attribute ENUM_ENCODING: STRING;
attribute ENUM_ENCODING of state_type: type is "10 11 01";
signal PS, NS : state_type;

begin

sync_proc: process(CLK, NS)
           begin
           
           if (rising_edge(CLK)) then PS <= NS;
           end if;
           
           end process;
           
comb_proc: process(CLK, PS, X1, X2)
           begin
           
           Z <= '0';
           
           case PS is
           when A =>
            if(X1 = '0') then 
            NS <= A;
            Z <= '0';
            elsif(X1='1') then 
            NS <= C;
            Z <= '0';
            end if;
          
           when B =>
            if(X2 = '0') then 
            NS <= A;
            Z <= '1';
            elsif(X2 = '1') then 
            NS <= B;
            Z <= '0';
            end if;
          
           when C =>    
            if(X2 = '0') then
            NS <= A;
            Z <= '0';
            elsif(X2 = '1') then
            NS <= B;
            Z <= '0';
            end if;
            
           when others =>
            Z <= '1'; NS <= A; 
            
            end case;
           
           end process;
           
with PS select
    Y <= "10" when A,
         "11" when B,
         "01" when C,
         "10" when others; 

end Behavioral;
