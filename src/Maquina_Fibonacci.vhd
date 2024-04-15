library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Maquina_Fibonacci is
  generic(M: integer:=10; --Cantidad de numeros de la serie deseados (Se le da valor en el test bench)
          N:integer:=10); --Limite de bits (Se le da valor en el test bench)
  Port (rst: in std_logic;
        clk: in std_logic;
        Fib_ValidOut: out std_logic;
        Fib_Out: out std_logic_vector(N-1 downto 0);
        num1: in std_logic_vector(N-1 downto 0);
        num2: in std_logic_vector(N-1 downto 0)
        );
        
end Maquina_Fibonacci;

architecture Behavioral of Maquina_Fibonacci is

type state_type is (S2,S1,S0);
signal ns: state_type;
signal cs: state_type :=S0;
component Acumulador is 
generic(N: integer:=10);
Port (ena: in std_logic;
      clk: in std_logic;
      rst: in std_logic;
      data_in: in std_logic_vector(N-1 downto 0);
      data_out: out std_logic_vector(N-1 downto 0)
      );
end component;

component Mux2_1 is 
generic(N: integer:=10);
Port (a: in std_logic_vector(N-1 downto 0);
      b: in std_logic_vector(N-1 downto 0);
      sel: in std_logic;
      s: out std_logic_vector(N-1 downto 0)
      );
end component;

signal data_in1: std_logic_vector(N-1 downto 0);
signal data_in2: std_logic_vector(N-1 downto 0);
signal data_out1: std_logic_vector(N-1 downto 0);
signal data_out2: std_logic_vector(N-1 downto 0);
signal en1: std_logic; --Enable del acumulador 1
signal en2: std_logic; --Enable del acumulador 2
signal M1_sel, M2_sel, M3_sel: std_logic; --Los selectores para los multiplexores
signal Fib_ValidOutaux: std_logic; --Cable para almacenar temporalmente el valid, y asi poder la condición explicada mas adelante de que una vez sale un valid = 0, el resto de valids de ahi en adelante también lo son
begin

Acc1: Acumulador
    generic map(N)
    port map(ena=>en1,clk=>clk,rst=>rst,data_in=>data_in1,data_out=>data_out1); 

Acc2: Acumulador
    generic map(N)
    port map(ena=>en2,clk=>clk,rst=>rst,data_in=>data_in2,data_out=>data_out2); 

Mux1: Mux2_1 
    generic map(N)
    port map(a=>num1,b=>data_out2,sel=> M1_sel,s=> data_in1);
   
Mux2: Mux2_1 
    generic map(N)
    port map(a=>num2,b=>data_out1,sel=>M2_sel,s=>data_in2);
    
Mux3: Mux2_1 
    generic map(N)
    port map(a=>data_out1,b=>data_out2,sel=>M3_sel,s=>Fib_Out);
      
      process(clk) begin --Process que se activa a cada tiempo de reloj y varia los valores de los enables y selectores
      if(rising_edge(clk)) then
        if(rst='1') then
            cs<=S0;   
            M1_sel<='0'; M2_sel<='0'; M3_sel<='0'; en1<='1'; en2<='0';        
        else
            case cs is
                when S0=> M1_sel<='1'; M2_sel<='0'; M3_sel<='0';en1<=not en1;en2<=not en2;
                cs<=S1;
                when S1=> M1_sel<='1'; M2_sel<='1'; M3_sel<='1';en1<=not en1;en2<=not en2;
                cs<=S2;
                when S2=> M3_sel<= not M3_sel;en1<=not en1;en2<=not en2;
          
            end case;
        end if;
      end if;
      
      end process;
      
      process(data_out1, data_out2)begin  --Este process se usará siempre que se haga algun cálculo en los acumuladores, para comprobar si el numero a mostrar es válido o no
      if(Fib_ValidOutaux/='0') then --Condicion para que una vez nos encontramos un numero no valido no se puedan tener válidos mas adelante.
        if(M3_sel='0')then --Según que numero se vaya a mostrar queremos analizar si uno es mayor que otro o viceversa, por eso usmos el selector del tercer mux como referencia
            if(data_out1>data_out2 or data_out1=data_out2) then--Por ejemplo, si vamos a mostrar el numero que viene del acumulador1, significa que ya se ha actualizado su valor
                Fib_ValidOutaux<='1';                          --por lo cual para que sea valido deberá ser mayor o igual al del otro acumulador.
            else
                Fib_ValidOutaux<='0';
                end if;
        else
            if(data_out2>data_out1 or data_out1=data_out2) then
                Fib_ValidOutaux<='1';
            else 
                Fib_ValidOutaux<='0';
                end if;
        end if;
        end if;
      end process;
      Fib_ValidOut<=Fib_ValidOutaux; --Actualizar el valor del Fib_ValidOut constantemente
     
end Behavioral;
