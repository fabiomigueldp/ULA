library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entidade do Habilitador.
-- Se enable = '1', saida = entrada.
-- Se enable = '0', saida = "00000".
entity habilitador is
    port (
        entrada : in  std_logic_vector(4 downto 0);
        enable  : in  std_logic;
        saida   : out std_logic_vector(4 downto 0)
    );
end entity habilitador;

architecture behavioral of habilitador is
begin
    saida <= entrada when enable = '1' else (others => '0');
end architecture behavioral;