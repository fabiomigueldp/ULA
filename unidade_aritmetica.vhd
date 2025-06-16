library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entidade da Unidade Aritmética (UA)
entity unidade_aritmetica is
    port (
        A, B          : in  std_logic_vector(4 downto 0);
        EnA, EnB      : in  std_logic;
        InvA, InvB    : in  std_logic;
        Co            : in  std_logic;
        Rs            : out std_logic_vector(4 downto 0);
        E             : out std_logic
    );
end entity unidade_aritmetica;

architecture structural of unidade_aritmetica is
    -- Declaração dos componentes que serão utilizados
    component habilitador is
        port ( entrada : in  std_logic_vector(4 downto 0); enable  : in  std_logic; saida : out std_logic_vector(4 downto 0) );
    end component;

    component inversor_controlado is
        port ( entrada : in  std_logic_vector(4 downto 0); invert  : in  std_logic; saida   : out std_logic_vector(4 downto 0) );
    end component;

    component somador_5bits is
        port ( A, B : in  std_logic_vector(4 downto 0); Cin  : in  std_logic; S    : out std_logic_vector(4 downto 0); Cout : out std_logic );
    end component;

    -- Sinais internos para conectar os componentes, conforme diagrama
    signal s_Ai, s_Bi : std_logic_vector(4 downto 0); -- Saídas dos Habilitadores
    signal s_Ay, s_By : std_logic_vector(4 downto 0); -- Saídas dos Inversores (entradas do somador)
    signal s_carry_out : std_logic; -- Carry out do somador (não usado para overflow de 2-comp)

begin
    -- Instanciação dos componentes
    Habilitador_A: entity work.habilitador
        port map ( entrada => A, enable => EnA, saida => s_Ai );

    Habilitador_B: entity work.habilitador
        port map ( entrada => B, enable => EnB, saida => s_Bi );

    Inversor_A: entity work.inversor_controlado
        port map ( entrada => s_Ai, invert => InvA, saida => s_Ay );

    Inversor_B: entity work.inversor_controlado
        port map ( entrada => s_Bi, invert => InvB, saida => s_By );

    Somador: entity work.somador_5bits
        port map ( A => s_Ay, B => s_By, Cin => Co, S => Rs, Cout => s_carry_out );

    -- Lógica de detecção de Overflow (E) para aritmética de complemento de 2
    -- O bit 4 é o bit de sinal. Overflow ocorre quando:
    -- 1. Soma de dois positivos resulta em um negativo.
    --    (sinal A = 0, sinal B = 0) -> (sinal S = 1)
    -- 2. Soma de dois negativos resulta em um positivo.
    --    (sinal A = 1, sinal B = 1) -> (sinal S = 0)
    -- As entradas para esta lógica são s_Ay e s_By, as entradas REAIS do somador.
    E <= (s_Ay(4) and s_By(4) and not Rs(4)) or (not s_Ay(4) and not s_By(4) and Rs(4));

end architecture structural;