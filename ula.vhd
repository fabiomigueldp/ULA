library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entidade de Topo da ULA (Top-Level Entity - TLE)
entity ULA is
    port (
        A, B : in  std_logic_vector(4 downto 0);
        F    : in  std_logic_vector(2 downto 0);
        S    : out std_logic_vector(4 downto 0);
        E    : out std_logic
    );
end entity ULA;

architecture structural of ULA is
    -- Declaração de todos os componentes que serão instanciados
    component unidade_logica is
        port ( A : in  std_logic_vector(4 downto 0); B : in  std_logic_vector(4 downto 0);
               RE : out std_logic_vector(4 downto 0); RXOR : out std_logic_vector(4 downto 0); ROU : out std_logic_vector(4 downto 0) );
    end component;

    component unidade_aritmetica is
        port ( A : in  std_logic_vector(4 downto 0); B : in  std_logic_vector(4 downto 0);
               EnA : in  std_logic; EnB : in  std_logic; InvA : in  std_logic; InvB : in  std_logic; Co : in  std_logic;
               Rs : out std_logic_vector(4 downto 0); E : out std_logic );
    end component;

    component unidade_de_controle is
        port ( F : in  std_logic_vector(2 downto 0);
               EnA : out std_logic; EnB : out std_logic; InvA : out std_logic; InvB : out std_logic; Co : out std_logic;
               O : out std_logic_vector(1 downto 0) );
    end component;

    component multiplexador is
        port ( Rs : in  std_logic_vector(4 downto 0); ROU : in  std_logic_vector(4 downto 0);
               RE : in  std_logic_vector(4 downto 0); RXOR : in  std_logic_vector(4 downto 0);
               O : in  std_logic_vector(1 downto 0);
               S : out std_logic_vector(4 downto 0) );
    end component;

    -- Sinais internos para interligar os componentes
    -- Saídas da Unidade Lógica
    signal s_RE, s_RXOR, s_ROU : std_logic_vector(4 downto 0);
    -- Saída da Unidade Aritmética
    signal s_Rs              : std_logic_vector(4 downto 0);
    -- Sinais de controle da Unidade de Controle
    signal s_EnA, s_EnB, s_InvA, s_InvB, s_Co : std_logic;
    signal s_O                 : std_logic_vector(1 downto 0);

begin
    -- Instanciação da Unidade de Controle
    UC_inst: entity work.unidade_de_controle
        port map (
            F    => F,
            EnA  => s_EnA,
            EnB  => s_EnB,
            InvA => s_InvA,
            InvB => s_InvB,
            Co   => s_Co,
            O    => s_O
        );

    -- Instanciação da Unidade Lógica
    UL_inst: entity work.unidade_logica
        port map (
            A    => A,
            B    => B,
            RE   => s_RE,
            RXOR => s_RXOR,
            ROU  => s_ROU
        );

    -- Instanciação da Unidade Aritmética
    UA_inst: entity work.unidade_aritmetica
        port map (
            A    => A,
            B    => B,
            EnA  => s_EnA,
            EnB  => s_EnB,
            InvA => s_InvA,
            InvB => s_InvB,
            Co   => s_Co,
            Rs   => s_Rs,
            E    => E -- A saída de erro 'E' da UA vai direto para a saída da ULA
        );

    -- Instanciação do Multiplexador
    MUX_inst: entity work.multiplexador
        port map (
            Rs   => s_Rs,
            ROU  => s_ROU,
            RE   => s_RE,
            RXOR => s_RXOR,
            O    => s_O,
            S    => S -- A saída 'S' do MUX é a saída final da ULA
        );

end architecture structural;