library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Fibonacci_tb is
generic(M: integer:=15; --Cantidad de números de la serie deseados
        N: integer:=10); --Límite de bits
-- Port ( );
end Fibonacci_tb;

architecture Behavioral of Fibonacci_tb is

component Maquina_Fibonacci is 
  generic(M: integer:=10; 
          N:integer:=10); 
  Port (rst: in std_logic;
        clk: in std_logic;
        Fib_ValidOut: out std_logic;
        Fib_Out: out std_logic_vector(N-1 downto 0);
        num1: in std_logic_vector(N-1 downto 0);
        num2: in std_logic_vector(N-1 downto 0)
        );
end component;

signal clk, rst, Fib_ValidOut: std_logic;
signal Fib_Out, num1, num2: std_logic_vector(N-1 downto 0);
signal cont: integer:=0;
begin

num1<="0000000001"; --Primer número de tu serie (Aclaración, el num1 debe ser menor o igual que el num2 para un correcto funcionamiento)
num2<="0000000101"; --Segundo número de tu serie. El tamaño de los números debe ser igual al del tamaño de bits, es decir, si se tiene un N=4, y se quiere
                    --poner num1 como 5, se debe poner "0101", si N=5 y queremos poner num1 como 3 se pone "00011", etc...
Maquina: Maquina_Fibonacci generic map(M,N)
                           port map(rst,clk,Fib_ValidOut,Fib_Out,num1,num2);

        process
        begin
          rst <= '1';
          clk <= '0';
          wait for 10ns;
        
          loop
            clk <= '1';  
            wait for 5ns;
        
            rst <= '0';            
            wait for 5ns;
            
            clk <= '0';
            wait for 10ns;
            CONT <= CONT + 1;
            if CONT = M then
              wait; --El proceso se detiene una vez alcanzamos la cantidad de números deseada
            end if;
             
             --"Descomentar si se quiere que el programa se detenga en cuanto recibimos un numero inválido"
--            if Fib_ValidOut='0' then 
--              wait;                  
--            end if;                  

          end loop;
        end process;
end Behavioral;
