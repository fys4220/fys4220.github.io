# Description styles


<div class="video-container">
<iframe width="1012" height="759" src="https://www.youtube.com/embed/ZFT7vDt6U-U" title="VHDL description models" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

[Slides](https://www.uio.no/studier/emner/matnat/fys/FYS4220/h22/lecture-slides/vhdl_description_models.pdf)

The architecture body of a VHDL description can be divided in two sections:
* the declaration section,
* and the section between the keywords `begin`  and  `end architecture`.


```vhdl
architecture rtl of example is

-- Declaration section

begin

-- The internal implementation/description of the entity's functinality
-- All statements are concurrent statments

end architecture;
```

The declaration section is used to declare any objects that should only be used within this architecture. That is, these objects are not visible outside of the architecture. The section between `begin` and `end` is the area where the functionality of the system or modules is described. Any VHDL statement within this area are is concurrent statements, which means that each statement will be translated into a piece of logic that will be implemented into hardware resources of the FPGA. 

As mentioned in the section {ref}`vhdl-history`, VHDL was originally developed to document and describe the behaviour of a circuit. Tools to synthesize a VHDL description into actual hardware were only developed later, and only for a limted part of the language. Today VHDL is most commonly used to:
- Write a VHDL description that can be synthesized to run on an FPGA.
- Simulate and verify another VHDL description (usually another description that can be synthesized to hardware). In this case the extended VHDL language can be used.


The following coding styles are usually considered when writing a VHDL description:

* {ref}`vhdl-structural`
* {ref}`vhdl-data-flow`
* {ref}`vhdl-behavioral`

These are not exclusive to each other, but are instead often combined. For a VHDL decsription to be synthesized into FPGA hardware, the description has to be limited into using a syntax that can be translated into combinational logic operations and storage units (registers). This is referred to as a {ref}`vhdl-rtl` description.


% We design our digital circuit with RTL VHDL and test it with Behavioral VHDL.


%```{figure} ../images/vhdl_description_models.png
%---
%width: 80%
%align: center
%name: fig:vhdl-description-models
%---
%Overview of description models in VHDL label.
%```

(vhdl-structural)=
## Structural
A structural description is used when the architecture is used to interconnected submodules or components ("black boxes"). Relevant analogies can be the schematic entry, the [bread board](https://en.wikipedia.org/wiki/Breadboard), or printed circuit board (PCB), which are used to connect together components using wires or PCB traces. {numref}`fig:vhdl-cern-readout-pcb` shows an example of a complex PCB consisting of many interconnected ICs. The PCB does not reveal anything about the behaviour of the design, only how they are connected together.

%The reprogrammability of a PCB is also limited and the traces are fixed and the components are soldered on the board. A bread board could more easily be reprorammed by moving wires around and replacing the components, but

```{figure} ../images/vhdl_cern_sat_readout_pcb.jpg
---
width: 60%
align: center
name: fig:vhdl-cern-readout-pcb
---
An example of a complex PCB layout connecting multiple ICs together on a PCB. The PCB is designed by Jon Wikne (UiO) in 1989 and was used for the readout of a detector at CERN. The board is approximately 40 cm x 40 cm, and today this design could easily be implemented into a single FPGA.
```

Similarly, a structural design approach in VHDL is used to specify how components are interconnected. Figure {numref}`fig:vhdl-description-models-hierarchy` shows how the structural appoarch can be used to achieve a hierarchical design. Here the architecture makes use of other components that can be interconnected and where each component also has an internal entity and architecture description.

%#* Interconnection of components (black boxes)
%#* Concurrent execution of statements
%#* Can be used to create hierarchy in the code
%#* Keywords: **component** and **port map**


```{figure} ../images/vhdl_structural.png
---
width: 60%
align: center
name: fig:vhdl-description-models-hierarchy
---
Hierarchical structure of a design.
```

In VHDL the keywords `component` and `port map` are used to build structural designs. An example is shown below.

```vhdl
library IEEE;
use IEEE.std_logic_1164.all;

entity struct_ex is
  port (
    A_IN  : in  std_logic;
    B_IN  : in  std_logic;
    C_IN  : in  std_logic;
    Y_OUT : out std_logic
    );
end struct_ex;

architecture structural of struct_ex is
  -- Declare signals internal to this architecture
  -- These signals will be used to connect together the components declared below.
  signal int1 : std_logic;
  signal int2 : std_logic;
  signal int3 : std_logic;

  -- declare components which has already been described in another file
  component AND_GATE
    port (
      A, B : in  std_logic;
      Y    : out std_logic
      );
  end component;

  component OR_GATE
    port (
      A, B, C : in  std_logic;
      Y       : out std_logic
      );
  end component;

begin
  -- connect the components together using the VHDL port map functionality.
  A1 : AND_GATE port map(A => A_IN, B => B_IN, Y => int1);
  A2 : AND_GATE port map(A => B_IN, B => C_IN, Y => int2);
  A3 : AND_GATE port map(A => A_IN, B => C_IN, Y => int3);
  O1 : OR_GATE port map(A  => int1, B => int2, C => int3, Y => Y_OUT);

end architcture structural;
```

This structural description makes use of two different components, a 2-input and-gate and a 3-input or-gate. The components and signals used to interconnect the components are declared in the declaration section of the architcture while the implementation of the interconnections are described as concurrent statements between the *begin* and `end architcture` keywords. The `port map` statement is used to connect the ports of the component to the internal signals of the top level architecture. The and-gate and or-gate are described in a separate VHDL file. The advantage of an hierarchical approach is that components can easily be reused. E.g., the implementation above makes use of three and-gates and one or-gate to achieve the design shown in figure {numref}`fig:vhdl-description-models-schematic-tmr`. However, the VHDL description above does not reveal anything about the functionality or behaviour of the design, only how the components are interconnected.


```{figure} ../images/vhdl_tmr_structural.png
---
width: 80%
align: center
name: fig:vhdl-description-models-schematic-tmr
---
Schematic illustration of basic TMR logic.
```

(vhdl-data-flow)=
## Data-flow 
Data-flow modelling describes the flow of data using concurrent statements between the `begin` and `end architecture` area. Concurrent statements are executed in parallell and the order of the statements is irrelevant. The execution is event driven, which means that the statment is only executed if there is a transition/change on the input. In other words, whenever there is a change in any of the signals listed on the right-hand side of the signal assigment operator, the signal on the left-hand side of the operator is re-evaluated.

%* Describes flow of data using concurrent statements
%* Concurrent execution of statements
%* Statement ”activated” by change on input
%* No correspondence between the order of elements / statements in the code
%* Non-procedural


```vhdl
-- order of statements is irrelevant

-- Alternative A
B  <= C;  --evaluated if transition on C
A  <= B;  --evaluated if transition on B

-- is equivalent to

-- Alternative B
A  <= B;
B  <= C;
```

Both alternatives above will generate the same logic. However, in a case where there are multiple drivers for the same signal, this will result in a conflict that must be resolved.

```vhdl
architecture concurrent of multiple is

signal Z, A, B, C, D : std_logic;

begin

  Z <= A and B;
  Z <= C and D; -- Multiple signal assignments to the same signal are not allowed

end concurrent;
```

This can be resolved using e.g. a conditional statement like shown below.

```vhdl
architecture concurrent of multiple is

signal Z, A, B, C, D : std_logic;
signal ena: std_logic;

begin

  Z <= (A and B) when ena = '1' else  (C and D);

end concurrent;
```

The design above also shows an example of a conditional signal assignment using the `when - else` statement. The syntax for this statement is shown below:

```vhdl
result_signal <= expression_1 when condition_1 else
               expression_2 when condition_2 else
               expression_3 when condition_3 else
               :
               expression_n;
```

Another useful syntax that can be used as a concurrent statement in VHDL is the selected signal assignment:

```vhdl
with input_signal select
  result_signal <= expression_1 when condition_1,
                   expression_2 when condition_2,
                   expression_3 when condition_3,
                    :
                   expression_n when others;
```


The main difference between the `when - else` and `with - select` syntax is that the latter makes a decision based on the condition of only one input, while for the `when - else` multiple and different inputs can be evaluated. A `when - else` syntex can therefore be used to implement a nested conditional statement. A `with - select` corresponds more to a multiplexer functionality.


(vhdl-behavioral)=
## Behavioral

%#The data-flow model works well for small and relatively simple circuits. However, for more complex circuits it is often advantagous to instead use a behavioral description model approach.

A behavioral approach models the circuit at the highest absraction level. It describes how the circuit should behave, and can be considered to be more of an algorithmic appoarch -- without considering how it may be implemented in hardware. 

While the behavioral description style is extensively used to write test benches, it can be argued that it also can be used to implement hardware if constrained to a limited set the the VHDL language. The part of the VHDL langauge that can be tranlasted into hardware -- logic gates and registers. This is further discussed in the section {ref}`vhdl-rtl`.


%where the details of the final hardware implementation is less obvious. The synthesis tool decides the actual circuit implementation. However, in order for the algorithm to be synthesized into actual hardware, it needs to be constrainted by by the use of a clock. The operations carried out by the algorithm can then be synchronized to this clock, making it possible to translate into and run on FPGA hardware. This approach can be used to describe synchronous and sequential logic like for example a state machine, and can make use of high level syntax like `if - then - else` and `case` statements.


%* Describes circuit in terms of behaviour ( Algorithmic )
%  * Models how the circuit outputs will react to the circuit inputs
%  * step-by-step calculations / sequence of operations
%  * Sequential execution of statements within process
%* High abstraction level (no details of actual HW implementation)
%* Execution of a process is equivalent to a single concurrent statement.
%  * All VHDL processes execute concurrently
%  * Keywords: **process**
%* Procedural

Consider the example below where two different VHDL descriptions results in the same logic behavior. The first descriptions uses a basic data flow approach  with logic operations on the signals. The second description uses a process statement with an if-else syntax to decide which of the signals A or B is connected to Y. You can read more about the process statement in {numref}`vhdl-process`.

_Entity description:_

```vhdl
entity mux is
port(
  A, B, SEL : in std_logic;
  Y : out std_logic
  );
```

Example 1: Data-flow description:

```vhdl
architecture description_model of example is

begin

  Y <= ((not sel) and A ) or (sel and B);

end data_flow;
```


Example 2: A higher abstraction level description using the VHDL process statement:

```vhdl
architecture description_model of example is

begin

process(sel,A,B) is
begin
  if sel = '0' then
    Y <= A;
  else
    Y <= B;
  end if;
end process;

end behav;
```

```{admonition} Question
:class: tip
Both examples above will result in the same logic. Can you tell what type of logic behaviour or functionallity these description will implement? 

```{admonition} Answer!
:class: dropdown

Both describe the behaviour of a multiplexer where `A` is connected to `Y` if `sel` is low and `B` is connected to `Y` if `sel` is high. However, if you run these two descriptions through Quartus and look at the intepreted results in Quartus' netlist viewer, you would see the to different results shown below.

**Example 1**
:::{image} ../images/vhdl_mux_data_flow.png
:width: 60%
:align: center
:::
**Example 2**
:::{image} ../images/vhdl_multiplexer.png
:width: 48%
:align: center
:::

For Example 1, Quartus has understood the implemention on a gate level, while for Example 2, Quartus has in fact interpreted the behaviour as a multiplexer. Which is at a higher abstraction level. The focus in Example 2 is more on the functionality or behaviour of the design rather than how it will be implementation in hardware. 
```


(vhdl-rtl)=
## Register Transfer Level (RTL)
An FPGA is a matrix of interconnected logic blocks. A simplified schematic representation of a logic block is shown in {numref}`fig:vhdl-fpga-logic-block`. The two essential parts of a logic block is the look-up table (LUT) and the register. These can be configured to implement combinational and sequential logic.


```{figure} ../images/fpga_logic_block.png
---
width: 80%
align: center
name: fig:vhdl-fpga-logic-block
---
A basic schematic representation of the basic building block of and FPGA: The Logic block.
```

The process of translating or converting a VHDL description into FPGA hardware is referred to as FPGA synthesis. The task of the synthesis tool is to map the desribed functionality into the available hardware resources such LUTs and registers. LUTs for combinational logic and registers to store the result of a combinational operation. The result is system that can be describe in terms of units of data storage (registers) and transformation of date between these storage units(combinational logic).{cite}`ashenden`. This is referred to as a Register Transfer Level (RTL) description. {numref}`fig:vhdl-description-models-schematic-rtl` illustrates this flow or transfer of data between registers.

```{figure} ../images/vhdl_rtl.png
---
width: 100%
align: center
name: fig:vhdl-description-models-schematic-rtl
---
Illustration of the Register Transfer Level.
```

RTL is the style of code that is required for a synthesis tool to translate the VHDL description into hardware. RTL can be a mixture of the structural, data-flow, and a limited set of the behavioral styles.


----


%(vhdl-generics)=
%## Generic map


%It is often desirable to make certain elements of a design as general or generic as possible. VHDL provides us with a %mechanism called generics, to customize a component upon instantiation. This can be used to easily vary the behaviour %or structure of a module by changing the value of a generic parameter. In the example below an entity has been %declared with a generic parameter called *width*. This parameter is used to define the width of an input port. The %default value is optional.
%
%```vhdl
%entity flexible is
%  generic(width : integer := 8);
%  port(
%    data : in std_logic_vector(width-1 downto 0)
%    );
%end entity;
%```
%
%A generic is mapped similarly to a port when the component is instantiated as shown in the example code below. First %the component is declared and then its ports and generics are mapped in the architecture description. A constant is %here used to override the default value of the generic parameter. This demonstrates how a design easily can be %customized for different purposes without modifying the module description itself.
%
%```vhdl
%architecture struct of top_level is
%
%constant bus_width : integer := 16;
%
%signal data_bus : std_logic_vector(bus_width-1 downto 0);
%
%component flexible
%  generic (width : integer);
%  port(
%    data : in std_logic_vector(width-1 downto 0)
%    );
%
%
%begin
%
%inst: flexible
%  generic map(
%    width => bus_width
%    );
%  port map(
%    data => data_bus
%  );
%
%end architecture;
%```


%In addition, VHDL also offers a possibility to customize a component upon instantiation using the keywords `Generic` and `Generic map`. This is very much similar to how ports are declared and later mapped when a component is instantiated. A generic can be used to easily and globally change certain parameters of a design elements like for example the width of a `std_logic_vector` or the value of a constant


%Generics are mapped in a similar way as ports. It maps specific values to the specified generics of the component.


%#The tables below provide and overview of where the various VHDL statements can be used.
%#
%#
%#|--------------------c----------------c--------------|
%#| Non-procedural (data-flow)  | Procedural (sequential)  |
%#|------------l----------------------l---------------|
%#| Process statement           | If- then- else statement  |
%#| When else statement         | Case statement            |
%#| With select statement       | Variable declaration      |
%#| Signal declaration          | Variable assignment       |
%#| Block statement             | Loop statement            |
%#|                             | Return statement          |
%#|                             | Null statement            |
%#|                             | Wait statement            |
%#|-------------------------------------------------|
%##
%#
%#
%#|---------------------------------------------------|
%#| Allowed in both non-procedural and procedural part  |
%#|-----------------------l---------------------------|
%#| Signal assignment                                   |
%#| Declaration of types and constants                  |
%#| Function and procedure calls                        |
%#| Assert statements                                   |
%#|-----------------------|

```{admonition} Supplementary suggested reading:

Chapter 5, section 5.1 and 5.2, and chapter 9 and 10 {Download}`in Mealy and Teppero, Free Range VHDL. <../docs/free_range_vhdl.pdf>`
 
Chapter 5, section 5.6 *Structural design using components* in LaMeres {cite}`lameres`.
* [Direct link html-version](https://link-springer-com.ezproxy.uio.no/chapter/10.1007/978-3-030-12489-2_5#Sec1)
* [Direct link pdf-version](https://link.springer.com/content/pdf/10.1007%2F978-3-030-12489-2_5)
```
 
