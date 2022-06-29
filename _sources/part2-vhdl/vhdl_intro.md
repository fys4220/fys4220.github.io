# The case for HDL 

Why should we use a Hardware Description Language (HDL)? Today the various development tools may provide a possibility to draw and connect the logic building blocks by using a schematic editor through a graphical user interface like shown in {numref}`quartus_schematic`.


<!-- ```{figure} docs/figures/quartus_schematic.png
---
width: 100%
align: center
name: quartus_schematic
---
Quartus Prime Lite schematic editor.
``` -->


While this may provide a pleasing visual overview of your design, it comes with some disadvantages like lack of portability across platforms, lack of maintainability, and potentially a very complex diagram for large designs. The better solution is therefore to describe the design using a Hardware Description Languages (HDLs) like e.g. VHDL or Verilog. Using VHDL, the design in {numref}`quartus_schematic` can be described as shown below.

```vhdl
library ieee;
use ieee.std_logic_1164.all;

-- The entity describes the interface
-- between the outside and the internal
-- functionality.
entity majority_voter is
  port(
    A   : in  std_logic;
    B   : in  std_logic;
    C   : in  std_logic;
    Y   : out std_logic
    );
end majority_voter;

-- The architecture describes the internal functionality
architecture design of majority_voter is
begin

-- This is the main functionality.
Y <= (A and B) or (A and C) or (B and C);

end architecture;
```

The overhead in number of lines for this simple design may seem large.  However, the more complex the design, the smaller the relative overhead. The VHDL description below can be stored as a readable text format in a file with the extension *.vhd*. This comes with the added bonus that the file can be put under version control using e.g. Git. An essential and important practice when developing code based projects.