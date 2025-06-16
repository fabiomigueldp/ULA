library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entidade do Multiplexador 4 para 1 de 5 bits
entity multiplexador is
    port (
        Rs, ROU, RE, RXOR : in  std_logic_vector(4 downto 0);
        O                 : in  std_logic_vector(1 downto 0); -- Sinal de seleção O(1)O(0)
        S                 : out std_logic_vector(4 downto 0)
    );
end entity multiplexador;

architecture behavioral of multiplexador is
begin
    -- Seleciona a entrada a ser enviada para a saída S com base no seletor O
    -- A ordem das entradas (Rs, ROU, RE, RXOR) segue a tabela da Figura 6
    with O select
        S <= Rs   when "00",
             ROU  when "01",
             RE   when "10",
             RXOR when "11",
             (others => 'X') when others; -- Valor indefinido para combinações não usadas
end architecture behavioral;