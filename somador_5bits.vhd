library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entidade do somador de 5 bits, conforme especificado
entity somador_5bits is
    port (
        A, B : in  std_logic_vector(4 downto 0);
        Cin  : in  std_logic;
        S    : out std_logic_vector(4 downto 0);
        Cout : out std_logic
    );
end entity somador_5bits;

-- Arquitetura estrutural que instancia 5 somadores de 1 bit
architecture structural of somador_5bits is
    -- Componente do somador de 1 bit
    component full_adder is
        port (
            a, b, cin : in  std_logic;
            sum, cout : out std_logic
        );
    end component;

    -- Sinal interno para conectar o carry out de um estágio ao carry in do próximo
    signal s_carry : std_logic_vector(5 downto 0);

begin
    -- O carry de entrada do somador é o carry de entrada do primeiro bit (LSB)
    s_carry(0) <= Cin;

    -- Gera 5 instâncias do full_adder, uma para cada bit
    gen_full_adders: for i in 0 to 4 generate
        fa_inst: entity work.full_adder
            port map (
                a    => A(i),
                b    => B(i),
                cin  => s_carry(i),
                sum  => S(i),
                cout => s_carry(i+1)
            );
    end generate gen_full_adders;

    -- O carry de saída do somador é o carry de saída do último bit (MSB)
    Cout <= s_carry(5);

end architecture structural;