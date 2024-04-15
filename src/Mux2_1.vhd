library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Mux2_1 is
  generic(N: integer:=10); --Limite de bits, se le da valor al implementar la maquina de fibonacci en el test bench
  Port (a: in std_logic_vector(N-1 downto 0);
        b: in std_logic_vector(N-1 downto 0);
        sel: in std_logic;
        s: out std_logic_vector(N-1 downto 0)
        );
end Mux2_1;

architecture Behavioral of Mux2_1 is

begin
    
    s<=a when sel='0' else b;
    
end Behavioral;
