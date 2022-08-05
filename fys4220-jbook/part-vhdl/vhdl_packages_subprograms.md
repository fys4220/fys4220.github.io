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

### Procedure
A procedure can be used to define an algorithm and is widely use to ease the writing and structuring of test benches.
The procedure accepts constants, variables and signals as object classes in its parameter list. Objects in the parameter list is separated with `;`. If the object class is not specified, a variable or constant is assumed depending on the mode (if `in` it is constant, if `out`/`inout` it is variable) Objects in the parameter list can have modes `in`, `out`, or `inout`. If mode is not specified the default is `in`. A procedure does not return a value, but may change the values of the paramteres passed to them. Procedures are synthesizable, provided that they do not detect clock edges or contain wait statements, i.e. the must not infer registers.

```vhdl
procedure <identifier> [ ( formal_parameter_list ) ] is
-- subprogram declaration part
begin
-- sequential statement
end [procedure] [identifier]
```




### Function
A function is an expression that defines a sequntial algorithm that computates of a value to be returned. It can produce only one return value and must contain a return statement. A function can only use parameters of type constant or signal with mode *in*, and cannot change the values of the parameters passed in the parameter list. Objects in the parameter list is separated with `;`. If the object class is not specified it is assumed to be of type constant and mode *in*. When a function is called the parameters are given the values of the actual parameters. Wait statements cannot be used in functions (functions execture in zero simulation time). Functions are most commonly used for logic functions, type conversions, and defining the meaning of an operator for a new type.

```vhdl
function <identifier> [ ( formal_parameter_list ) ]  return <type> is
-- subprogram declaration part
begin
-- sequential statement
end [function] [identifier]
```


## Example of package

In the introductory project assignment you are asked to write the description for a BCD to 7-segment decoder. This is typical example of a logic function that e.g. can be declared in a package for easy reuse.

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
  function bcd2seg7(signal bcd : in std_logic_vector(3 downto 0)) return std_logic_vector(7 downto 0) is
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

## Supporting videos


The following video briefly discusses the use of packages and sub-programs in VHDL.
<div class="video-container">
<iframe width="1920" height="806" src="https://www.youtube.com/embed/e_4ejwJdO9M" title="vhdl package subprograms" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

Video link: [https://www.youtube.com/watch?v=e_4ejwJdO9M](https://www.youtube.com/watch?v=e_4ejwJdO9M)

