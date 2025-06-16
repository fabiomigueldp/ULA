library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entidade de um somador completo de 1 bit (Full Adder)
entity full_adder is
    port (
        a, b, cin : in  std_logic;
        sum, cout : out std_logic
    );
end entity full_adder;

-- Arquitetura com as equações lógicas padrões de um somador completo
architecture behavioral of full_adder is
begin
    sum <= a xor b xor cin;
    cout <= (a and b) or (cin and (a xor b));
end architecture behavioral;