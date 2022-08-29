(vhdl-testbenches)=
# Testbenches

For any development it is important to test and verify your solution before it is deployed in the field. This is no different for FPGAs where it is required to simulate your design before downloading and running it on the FPGA. In this section we will introduce the concept of testbenches in VHDL. Testbenches are the standard approach to simulate and verfiy your HDL design, and are used to apply stimuli to the inputs of a design and observe the ouputs to verify correct behaviour. This is illustrated in figure {numref}`fig:vhdl_testbench`. 

```{figure} ../images/vhdl_testbench.png
---
width: 70%
align: center
name: fig:vhdl_testbench
---
A top-level view on testbenches.
```

Testbenches can be written in VHDL. A VHDL testbench is not meant to run on hardware and can therefore take advantage of the full extent of the VHDL language. In constrast, the design under test, which will run on the FPGA, is restricted to VHDL written at the RTL-level level (see section {ref}`vhdl-rtl`).  

For a VHDL testbench it is e.g., possible to write a statment like shown below.

```{code-block} vhdl
A <= '0';
wait for 20 ns;
A <= '1';
wait for 20 ns;
```
This will force a value to the signal A which first is '0' for 20 ns and then '1' for 20 ns as shown in figure {numref}`fig:vhdl_testbench_wavedrom_basic`.

```{figure} ../images/vhdl_testbench_wavedrom_basic.png
---
width: 70%
align: center
name: fig:vhdl_testbench_wavedrom_basic
---
A wave diagram of the code block above.
```

This is a simple example of how e.g., an input stimuli can be described using VHDL. However, the synthesis tool is not able to translate the `wait for 20 ns` statement into any hardware resource on an FPGA. An FPGA does not have any inherently concept or understanding of time specified in this manner. This can only be done by providing the FPGA with a dedicated external clock signal. E.g., a signal that changes between a low and high value at a fixed regular interval. By connecting this clock signal to the the internal registers of an FPGA, your design can now be synchronized to this signal, allowing it to update internal states and values on every clinternal states and values on every clock cycle. 
%If your design needs to wait for a time period which is longer than the clock cycle, you will have to implement counters 


## Basic example: half adder

Consider that you want to verify the correct behaviour of the half adder circuit shown in the code block below.

```{code-block} vhdl
-- Filename: half_adder.vhd
library ieee;
use ieee.std_logic_1164.all;

entity half_adder is
port(
  A : in std_logic;
  B : in std_logic;
  SUM : out std_logic;
  COUT : out std_logic
  );
end entity;

architecture rtl of half_adder is

begin

  SUM <= A xor B;
  COUT <= A and B;

end architecture;

```


To build a testbench to verify this design you will make use to the structural description style introduced in section {ref}`vhdl-structural`. Since the half adder is already described as a complete component with an entity and related architecture, we can simply reuse this design in a new VHDL file. The first step is to prepare the testbench VHDL-file. To distinguish the two files and entities, it is common to add *tb* as a prefix or postfix to the name of the design under test, and use this as the name of the testbench file. In this example add *tb* as a postfix. 

```{code-block} vhdl
-- Filename: halv_adder_tb.vhd
library ieee;
use ieee.std_logic_1164.all;

-- The entity declaration of
-- a testbench is empty.
entity half_adder_tb is
end entity;

architecture tb of half_adder_tb is

begin

end architecture;

```

This is the basic skeleton of a general VHDL file. However, different from the VHDL description of the component under test, the testbench has no ports, i.e., the entity declaration is empty. This makes sense if you compare to the diagram in figure {numref}`fig:vhdl_testbench`. While the component under test may have both inputs and outputs, a testbench is not dependent on outside signal to run. All necessary functionality is generated within the architecture of the testbench. The entity declaration can therefore be left empty. 

The testbench can in many ways be compared to a physical test setup on a lab bench, where signal generators are used provide test signals to a component, and an oscilloscope is used to monitor the outputs of the component. The purpose of the VHDL testbench is to act as the signal generator and oscilloscope, and simulate the behaviour of the VHDL design under test. 

To include the VHDL design to be tested in the testbench, we can make use of the *component* and *port map* statments as shown in section {numref}`fig:vhdl_testbench`, or we can take advantage of the possibility to do a so called direct instantiation. This uses a slightly different syntax for the *port map* statement at the benefit of not having to use the *component* statement. 


```{code-block} vhdl
-- Filename: half_adder_tb.vhd
library ieee;
use ieee.std_logic_1164.all;

-- The entity declaration of
-- a testbench is empty.
entity half_adder_tb is
end entity;

architecture tb of mux_tb is

  -- Signals to be connected to the 
  -- design under test.
  signal A : std_logic;
  signal B: std_logic;
  signal SUM: std_logic;
  signal COUT: std_logic;

begin

  -- Direct instantiation of 
  -- the design under test
  dut: entity work.half_adder(rtl) 
    port map(
      A => A,
      B => B,
      SUM => SUM,
      COUT => COUT
    );


end architecture;

```

If not specified, the design will be compiled into a library called *work*. To reuse this desing, we have to specify the name of the entity and the library where it can be found. An entity can be connected to multiple architectures, if this is the case, we also have to specify the name of the architecture, in this case *rtl*. Otherwise, it will automatically pick the last architecture which was compiled last. It is therefore a good habit to always specify the architecture, even though only one is available. 
%When using a component declarations, it is not possible to specify which architecture.


At the testbench level, we also need to declare signals that will be connected to the design under test, and that will provide stimuli to the inputs, and be monitored for expected values on the outputs. 

The next step is to generate the appropriate stimuli to test the design. For this we will make use of the *process* statement. The process statement is described in more detail in the section {ref}`vhdl-process`. For now you can think of the *process* as a possibility to describe a sequential behaviour. While all statementes inside the architecture of a VHDL file are concurrent statements, including the *process* statement, statements which are inside a process are read sequentially. 


```{code-block} vhdl
-- Filename: half_adder_tb.vhd
library ieee;
use ieee.std_logic_1164.all;

-- The entity declaration of
-- a testbench is empty.
entity half_adder_tb is
end entity;

architecture tb of half_adder_tb is

  -- Signals to be connected to the 
  -- design under test.
  signal A : std_logic;
  signal B: std_logic;
  signal SUM: std_logic;
  signal COUT: std_logic;

begin

  -- Direct instantiation of 
  -- the design under test
  dut: entity work.half_adder(rtl) 
    port map(
      A => A,
      B => B,
      SUM => SUM,
      COUT => COUT
    );
  
  -- The process is a concurrent
  -- statement inside the architecture
  p_stimuli: process
  begin 
    -- Inside the process, the statements are
    -- read sequentially and updated when the
    -- simulation time progresses.
    
    -- Set initial values for the inputs
    A <= '0';
    B <= '0';
    -- Progress simulation time
    wait for 50 ns;
    -- Update signal values
    A <= '1';
    B <= '0';
    -- Progress simulation time
    wait for 50 ns;
    A <= '0';
    B <= '1';
    -- Progress simulation time
    wait for 50 ns;
    A <= '1';
    B <= '1';
    -- Progress simulation time
    wait for 50 ns;
    -- stop the process
    wait; --halts the process forever.

  end process;

end architecture;

```
```{admonition} How to end a simulation
The stimuli process in a testbench is meant to run only once. To achieve this the process must use a *wait* statement at halt the process. Otherwise the process would continue to repeat it self as an infinit loop. 
```
<!--
However, as long as there is activity on any of the signals the simulation will not end. A clock is in principle a continuously running signal. However, by using a clock enable signal, the clock can easily be disabled. Try to run your simulation without a wait statement or without disabling the clock and see what happens.
-->
```{admonition} Supplementary suggested reading:

Chapter 5, section 5.7 in LaMeres {cite}`lameres`.
* [Direct link html-version](https://link-springer-com.ezproxy.uio.no/chapter/10.1007/978-3-030-12489-2_5#Sec)
* [Direct link pdf-version](https://link.springer.com/content/pdf/10.1007%2F978-3-030-12489-2_5)
```


## Simulate in Modelsim

The testbench is now ready to be simulated using e.g., Modelsim. A simulation tool like Modelsim can be used to run the test bench and visualize its behaviour in a wave diagram format. Modelsim is a commercial tool, but a free version called *Modelsim-Intel FPGA Starter Edition* is included when downloading and installing the the Quartus Prime Lite Edition. The starter edition is limited to 10000 lines of code. Above this, the performance of the simulator is significantly reduced. An open-source alternative for the VHDL language is [GHDL](http://ghdl.free.fr) or [GHDL on Github](https://github.com/ghdl/ghdl). The output of GHDL can be read and viewed by [GTKWave](http://gtkwave.sourceforge.net). Since Modelsim is already included in Quartus Prime Lite, and since it is one of the most used tool in industry, we will continue to use Modelsim in this course.

In the following description the files are organized as shown below. Design files and testbench files are often separated into different folders. It is also good practice to create a separate folder where the simulations are run. 

```
|-- fys4220_half_adder
    |-- src
        |-- half_adder.vhd
    |-- tb
        |-- half_adder_tb.vhd
    |-- sim
        |-- half_adder.mpf  

```

A new project called *half_adder* is create in Modelsim (File-> New -> Project) and the folder *sim* is used as the Project Location as shown in {numref}`fig:vhdl-testbench-create-modelsim-project`

```{figure} ../images/vhdl_testbench_create_modelsim_project.png
---
width: 50%
align: center
name: fig:vhdl-testbench-create-modelsim-project
---
Create Modelsim project.
```

The source file and testbench file can be added to the project by choosing "Add Existing File" during the setup of the project, or through the menu bar (Project -> Add to Project -> Existing File).


The files have to be compiled in the correct order. *half_adder_tb.vhd* is dependent on *half_adder.vhd*, *half_adder.vhd* therefore has to be compiled first. To compile right click on the file and choose (Compile -> Compile Selected).

If Modelsim does not report any erros the simulation can now be started choosing (Simulate -> Start Simulation) from the menu and choosing the test bench unit *half_adder_tb.vhd* under the work library as shown in figure {numref}`fig:vhdl-testbenches-vsim-startsim`.

```{figure} ../images/vhdl_testbenches_vsim_startsim.png
---
width: 60%
align: center
name: fig:vhdl-testbenches-vsim-startsim
---
Choose the test bench entity to start the simuliation.
```

In Modelsim the wave viewer can be used to visualize the values of the input and ouput signals. If the wave viewer is not opened automatically this can ddbe done by choosing (View -> Wave) from the menu bar. At this point no signals are added to the wave viewer. Mark the relevant signals, right click and choose "Add Wave" as shown in figure {numref}`fig:vhdl-testbench-vsim-add-signal`. 


```{figure} ../images/vhdl_testbenches_vsim_add_signal.png
---
width: 100%
align: center
name: fig:vhdl-testbench-vsim-add-signal
---
Mark relevant signals to be added to the wave window.
```

The simulation can now be run (Simulate -> Run -> Run -All) and you should see a similar results to the wave diagram shown in figure {numref}`fig:vhdl_half_adder_simulation`.


```{figure} ../images/vhdl_half_adder_simulation.png
---
width: 100%
align: center
name: fig:vhdl_half_adder_simulation
---
The Modelsim wave viewer showing the result of the simulation of the half adder.
```

To verify the correct behaviour of the half adder, we need to manually inspect the wave diagrams in the wave viewer. This is a very basic level of verification where only the stimuli on the inputs are automated. 

% ADD asserts

% Then add write to file

% then add procedures

## Self-checking testbenches


## Supporting videos


The following video discusses testbenches in VHDL. 
<div class="video-container">
<iframe width="1920" height="806" src="https://www.youtube.com/embed/spEkb2cXZPg" title="vhdl testbenches" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

[Slides](https://www.uio.no/studier/emner/matnat/fys/FYS4220/h22/lecture-slides/vhdl_testbenches.pdf)

