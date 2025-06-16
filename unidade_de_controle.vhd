library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entidade da Unidade de Controle (UC)
entity unidade_de_controle is
    port (
        F                   : in  std_logic_vector(2 downto 0);
        EnA, EnB, InvA, InvB, Co : out std_logic;
        O                   : out std_logic_vector(1 downto 0)
    );
end entity unidade_de_controle;

architecture behavioral of unidade_de_controle is
    -- Sinal interno para a saída do decodificador 3-para-8
    -- D(i) fica ativo quando F = i
    signal D : std_logic_vector(7 downto 0);

begin
    -- Bloco 1: Decodificador Padrão 3-para-8
    -- Habilita uma única saída D(i) de acordo com a entrada F
    process(F)
    begin
        case F is
            when "000" => D <= "00000001"; -- D0: Clear
            when "001" => D <= "00000010"; -- D1: A-B
            when "010" => D <= "00000100"; -- D2: B-A
            when "011" => D <= "00001000"; -- D3: A+B
            when "100" => D <= "00010000"; -- D4: A XOR B
            when "101" => D <= "00100000"; -- D5: A OU B
            when "110" => D <= "01000000"; -- D6: A E B
            when "111" => D <= "10000000"; -- D7: Preset
            when others => D <= (others => '0');
        end case;
    end process;

    -- Bloco 2: Lógica de Controle
    -- Gera os sinais de controle a partir das saídas D do decodificador,
    -- usando lógica OU conforme especificado.

    -- EnA: Habilitado para A-B, B-A, A+B e todas as operações lógicas.
    EnA <= D(1) or D(2) or D(3) or D(4) or D(5) or D(6);

    -- EnB: Habilitado para A-B, B-A, A+B, lógicas, e para o Preset (para gerar '11111').
    EnB <= D(1) or D(2) or D(3) or D(4) or D(5) or D(6) or D(7);

    -- InvA: Inverte A apenas para a operação B-A (B + not A + 1).
    InvA <= D(2);

    -- InvB: Inverte B para A-B (A + not B + 1) e para o Preset.
    InvB <= D(1) or D(7);

    -- Co: Carry de entrada '1' é necessário para as subtrações (comp. de 2).
    Co <= D(1) or D(2);

    -- Lógica do seletor do MUX (O), baseada na tabela da Figura 6/7.
    -- O1 é '1' para RE (D6) e RXOR (D4).
    O(1) <= D(4) or D(6);
    -- O0 é '1' para ROU (D5) e RXOR (D4).
    O(0) <= D(4) or D(5);

end architecture behavioral;