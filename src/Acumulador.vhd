library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity Acumulador is
 generic(N: integer:=10); --Limite de bits (Se le da valor al implementar la maquina de fibonacci en el test bench)
 Port (ena: in std_logic;
       clk: in std_logic;
       rst: in std_logic;
       data_in: in std_logic_vector(N-1 downto 0);
       data_out: out std_logic_vector(N-1 downto 0)
       );
end Acumulador;

architecture Behavioral of Acumulador is

signal data_aux: unsigned (N-1 downto 0); --Usamos el cable data_aux para almacenar temporalmente el data out, y es unsigned para poder sumar cosas facilmente
                                          
begin

    process(clk) begin --Process para que a cada tiempo de reloj, segun las entradas, se resetee, sume, o no haga nada.
    if(rising_edge(clk)) then 
        if(rst = '1') then
            data_aux <= (others=>'0');           
        else   
              if(ena='1')then
                data_aux<=data_aux+unsigned(data_in);  
            end if;
        end if;        
    end if;
    end process;
    
    data_out<=std_logic_vector(data_aux); --Mantener el data_out actualizado constantemente, se castea a logic_vector
                                          --ya que data_aux es unsigned y data_out es logic_vector
end Behavioral;
