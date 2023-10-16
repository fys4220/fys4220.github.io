(vhdl-packages)=
# Packages and subprograms

## Packages

Packages in VHDL provide an important way of organzing commonly used objects, data types, component declarations, signals and subprograms (function, procedure) that can be shared among different VHDL design units. It is simply a way of grouping a collection of related declarations that serve a common purpose. In this way you avoid repeating declarations as well as reducing the probability of mistakes. The *ieee.std_logic_1164* is one example of a predefined package in VHDL. It is also possible to write user defined packages. If multiple VHDL design units tend to use the same declarations, it may be favorable to create your own package that can be easily reused for future designs. The package can be placed in a separate VHDL file and referenced via the keyword `use` and the library to which the package has been compiled, typically the `work` library.

```vhdl
use work.user_pkg.all;
```

A package consists of a *declaration* part and a *body*. The package declaration specifies the external view while the implementation is defined in the package body.

```vhdl
library ieee;
use ieee.std_logic_1164.all;

package <identifer> is
-- Declaration
end [package] [identifier];

package body <package name> is
-- Implementation
end [package] [identifier];
```


## Subprograms 

When writing complex VHDL descriptions it can be useful to divide or structure the code into manageable smaller units or sections. Structuring the code into design units is one such approach, but VHDL also provides *subprograms* for this purpose. Subprograms are a mechanism for representing commonly used logic functions or sequential statements. VHDL has two kinds of subprograms, *functions* and *procedures*. These are most commonly defined or declared in a package, but can also be defined in the declaration part of an architecture or process. Statements within a subprogram are sequential regardless of where the subprogram is invoked. It may be useful to think of subprograms as processes that operate only on their inputs, and for the case of procedures on their outputs.

(vhdl-packages-procedure)=
### Procedure
A procedure can be used to define an algorithm and is widely use to ease the writing and structuring of test benches.
The procedure accepts constants, variables, and signals as object classes in its parameter list. Objects in the parameter list is separated with `;`. If the object class is not specified, a variable or constant is assumed depending on the mode (if `in` it is a constant, if `out`/`inout` it is a variable). Objects in the parameter list can have modes `in`, `out`, or `inout`. If the mode is not specified the default is `in`. A procedure does not return a value, but may change the values of the parameters passed to them. Procedures are synthesizable, provided that they do not detect clock edges or contain wait statements, i.e., they must not infer registers, but describe combinational logic. However, procedures are mostly used for test benches. 
```vhdl
procedure <identifier> [ ( formal_parameter_list ) ] is
-- subprogram declaration part
begin
-- sequential statement
end [procedure] [identifier]
```




### Function
A function is an expression that defines a sequential algorithm that computes of a value to be returned. It can produce only one return value and must contain a return statement. A function can only use parameters of type constant or signal with mode *in*, and cannot change the values of the parameters passed in the parameter list. Objects in the parameter list is separated with `;`. If the object class is not specified it is assumed to be of type constant and mode *in*. When a function is called, the parameters are given the values of the actual parameters. Wait statements cannot be used in functions (functions execute in zero simulation time). Functions are most commonly used for describing combinational logic, type conversions, or defining the meaning of an operator for a new type.

```vhdl
function <identifier> [ ( formal_parameter_list ) ]  return <type> is
-- subprogram declaration part
begin
-- sequential statement
end [function] [identifier]
```


## Example of package


### Function
The example below shows how function can be used to describe the binary coded decimal to 7-segment decoder. This is typical example of a logic function that e.g., can be declared in a package for easy reuse.

```vhdl
-- Library and package part
library ieee;
use ieee.std_logic_1164.all;

package user_pkg is
  -- The function needs to be declared here to be visible outside the package
  function bcd2seg7(signal bcd : in std_logic_vector(3 downto 0)) return std_logic_vector;

end package;

package body user_pkg is
  -- implementation details of BCD to 7-segment decoder
  function bcd2seg7(signal bcd : in std_logic_vector(3 downto 0)) return std_logic_vector is
  begin
    case bcd is
      when "0000" => return "01000000";
      when "0001" => return "01111001";
      when "0010" => return "00100100";
      when "0011" => return "00110000";
      when "0100" => return "00011001";
      when "0101" => return "00010010";
      when "0110" => return "00000010";
      when "0111" => return "01111000";
      when "1000" => return "00000000";
      when "1001" => return "00010000";
      when "1010" => return "00001000";
      when "1011" => return "00000011";
      when "1100" => return "01000110";
      when "1101" => return "00100001";
      when "1110" => return "00000110";
      when "1111" => return "00001110";
      when others => return "01111111";
    end case;
  end function;
end;
```


In the main design entity this function can be used as demonstrated below.

```vhdl
-- Library and package part
library ieee;
use ieee.std_logic_1164.all;
-- include user defined package
use work.user_pkg.all;

-- entity description
entity example is
  port (
    sw   : in  std_logic_vector(3 downto 0);
    hex0 : out std_logic_vector(7 downto 0)  -- 7-segment display
    );
end entity example;


-- architecture
architecture rtl of example is

  -- declartion area

begin
  -- make use of function declared and implemented in user_pkg.vhd
  hex0 <= bcd2seg7(sw);

end architecture;
```

(vhdl-package-example-procedure)=
### Procedure
The example below shows how a procedure can be declared in a package and used to automate the test stimuli on the input of a RX UART module.
```{code-block} vhdl
library ieee;
use ieee.std_logic_1164.all;

package tb_support_pkg is

  constant GC_SYSTEM_CLK : integer := 50_000_000;
  constant GC_BAUD_RATE : integer := 115_200;

  --clock generation parameters
  signal clk : std_logic;
  signal clk_enable : boolean := false;
  constant clk_period : time := 20 ns;
  constant C_BIT_PERIOD : time := clk_period * GC_SYSTEM_CLK/GC_BAUD_RATE;

  -- Support procedure to write serial data
  procedure uart_write_data (
    constant data : in std_logic_vector(7 downto 0); -- data
    signal serial_data : out std_logic; -- serial RX line out
    constant inject_error_stop_bit : boolean := false; -- Error in stop bit
    constant inject_error_start_bit : boolean := false -- Error in start bit
  );

end package;

package body tb_support_pkg is
  -- Support procedure to write serial data
  procedure uart_write_data (
    constant data : in std_logic_vector(7 downto 0); -- data
    signal serial_data : out std_logic; -- serial RX line out
    constant inject_error_stop_bit : boolean := false; -- Error in stop bit
    constant inject_error_start_bit : boolean := false -- Error in start bit
  ) is
  begin

    -- Send start bit with or without error
    if inject_error_start_bit then
      serial_data <= '1';
    else
      serial_data <= '0';
    end if;
    wait for C_BIT_PERIOD;

    -- Send the data bits LSB first
    for bit_pos in 0 to data'length - 1 loop
      serial_data <= data(bit_pos);
      --report "Writint bit " & integer'image(bit_pos) & " of value " & std_logic'image(data(bit_pos)) ;
      wait for C_BIT_PERIOD;
    end loop;

    -- Send stop bit with or without error
    if inject_error_stop_bit then
      serial_data <= '0';
    else
      serial_data <= '1';
    end if;
    wait for C_BIT_PERIOD;

    -- Return to default value for RX.
    serial_data <= '1';
  end procedure;
end;

```
The procedure *uart_write_data* can then be easily used in the stimuli process of the main test bench. 

```{code-block} vhdl
library ieee;
use ieee.std_logic_1164.all;
use work.tb_support_pkg.all;

entity rx_uart_tb is
end entity;

architecture tb of rx_uart_tb is

  signal areset_n : std_logic;
  signal rx_data : std_logic_vector(7 downto 0);
  signal rx_data_valid : std_logic;
  signal rx_busy : std_logic;
  signal rx : std_logic;
  signal rx_err : std_logic;

begin
  -- create the system clock
  clk <= not clk after clk_period/2 when clk_enable else '0';
  
  -- include the dut
  dut : entity work.rx_uart(rtl)
    generic map(
      GC_SYSTEM_CLK => GC_SYSTEM_CLK,
      GC_BAUD_RATE => GC_BAUD_RATE
    )
    port map(
      clk => clk,
      areset_n => areset_n,
      rx_data => rx_data,
      rx_busy => rx_busy,
      rx_err => rx_err,
      rx => rx
    );

  -- Generate the main test stimuli
  p_stimuli : process
  begin
    report "Starting simulation of RX UART";
    areset_n <= '1';
    clk_enable <= true;
    wait for 100 ns;

    -- toggle restet for at least a few clock cycles
    areset_n <= '0';
    wait for clk_period * 5;
    areset_n <= '1';
    wait for 100 ns;
    
    -- Write the data 0x55 to the RX input
    uart_write_data(x"55", rx);
    -- make sure the data has been received and busy is set
    wait for clk_periods*2; 
    -- make sure transaction has been completed
    -- and busy is low before checking received byte
    if rx_busy = '1' then
      wait until rx_busy = '0';
      report "rx_busy goes low - new data has been received";
    end if;

    -- check if correct value has been received by the rx moduel
    assert rx_data = x"55" -- report if not equal to expected byte.
    report "Incorrect byte received!"
      severity warning;

    -- Wait some additional time to allow visual inspection in wave diagram
    wait for 200 ns;
    clk_enable <= false;
    wait;

  end process;

end architecture;
```

<!--
```{admonition} Supplementary suggested reading:

Chapter 5, section 5.1 in LaMeres {cite}`lameres`.
* [Direct link html-version](https://link-springer-com.ezproxy.uio.no/chapter/10.1007/978-3-030-12489-2_5#Sec1)
* [Direct link pdf-version](https://link.springer.com/content/pdf/10.1007%2F978-3-030-12489-2_5)
```
-->


## Supporting videos


The following video briefly discusses the use of packages and sub-programs in VHDL.
<div class="video-container">
<iframe width="1920" height="806" src="https://www.youtube.com/embed/e_4ejwJdO9M" title="vhdl package subprograms" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>


