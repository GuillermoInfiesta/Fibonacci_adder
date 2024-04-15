library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Acumulador_tb is
generic( N:integer:=6);
--  Port ( );
end Acumulador_tb;

architecture Behavioral of Acumulador_tb is
component Acumulador is
 generic(N: integer:=10);
 Port (ena: in std_logic;
       clk: in std_logic;
       rst: in std_logic;
       data_in: in std_logic_vector(N-1 downto 0);
       data_out: out std_logic_vector(N-1 downto 0)
       );
end component;

signal ena,clk,rst: std_logic;
signal data_in, data_out: std_logic_vector(N-1 downto 0);

begin

Acc: Acumulador generic map(N)
                port map(ena=>ena, clk=>clk, rst=>rst, data_in=>data_in, data_out=>data_out);
    process begin
    clk<='0';
    wait for 10ns;
    clk<='1';
    wait for 10ns;
    end process;

    process begin
      rst<='1'; ena<='0'; data_in<="000101";
      wait for 15ns;
      rst<='0'; ena<='1';
      wait for 20ns;
      data_in<="000111";
      wait for 20ns;
      data_in<="001000"; ena<='0';
      wait for 20ns;
      data_in<="010101"; ena<='1';
      wait;
    end process;
    
end Behavioral;
