library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entidade da Unidade Lógica (UL)
entity unidade_logica is
    port (
        A, B : in  std_logic_vector(4 downto 0);
        RE   : out std_logic_vector(4 downto 0); -- Saída da operação E (AND)
        RXOR : out std_logic_vector(4 downto 0); -- Saída da operação XOR
        ROU  : out std_logic_vector(4 downto 0)  -- Saída da operação OU (OR)
    );
end entity unidade_logica;

-- Arquitetura que realiza as 3 operações lógicas bit-a-bit concorrentemente.
architecture behavioral of unidade_logica is
begin
    RE   <= A and B;
    RXOR <= A xor B;
    ROU  <= A or B;
end architecture behavioral;