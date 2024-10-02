(vhdl-generics)=
# Generic map


It is often desirable to make certain elements of a design as general or generic as possible. VHDL provides a mechanism called *generics*, to customize a component upon instantiation. This can be used to easily vary the behaviour or structure of a module by changing the value of a generic parameter. In the example below an entity has been declared with a generic parameter called `width`. This parameter is used to define the width of an input port. Specifying a default value, in this case 8, is optional.

```vhdl
entity flexible is
  generic(width : integer := 8);
  port(
    data : in std_logic_vector(width-1 downto 0)
    );
end entity;
```

A generic is mapped similarly to a port when the component is instantiated as shown in the example code below. First the component is declared and then its ports and generics are mapped in the architecture description. A constant is here used to override the default value of the generic parameter. This demonstrates how a design easily can be customized for different purposes without modifying the module description itself.

```vhdl
architecture struct of top_level is

constant bus_width : integer := 16;

signal data_bus : std_logic_vector(bus_width-1 downto 0);


begin

inst: entity work.flexible
  generic map(
    width => bus_width
    );
  port map(
    data => data_bus
  );

end architecture;
```

A generic map can also be very useful when you want to generate several instances of the same module. Combined with a `for generate` statement this can be achieved as shown below.

```{code-block} vhdl
g_modules: for i in 0 to no_modules-1 generate
  inst: entity work.super_design
    port map(
     A(i) => A(i),
     B(i) => B(i),
    );
end generate;
```



%In addition, VHDL also offers a possibility to customize a component upon instantiation using the keywords `Generic` and `Generic map`. This is very much similar to how ports are declared and later mapped when a component is instantiated. A generic can be used to easily and globally change certain parameters of a design elements like for example the width of a `std_logic_vector` or the value of a constant


%Generics are mapped in a similar way as ports. It maps specific values to the specified generics of the component.
