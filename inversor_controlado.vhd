library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entidade do Inversor Controlado.
-- Se invert = '1', saida = NOT entrada.
-- Se invert = '0', saida = entrada.
entity inversor_controlado is
    port (
        entrada : in  std_logic_vector(4 downto 0);
        invert  : in  std_logic;
        saida   : out std_logic_vector(4 downto 0)
    );
end entity inversor_controlado;

architecture behavioral of inversor_controlado is
begin
    saida <= not entrada when invert = '1' else entrada;
end architecture behavioral;