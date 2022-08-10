(assignments-synchronous-logic)=
# Synchronous logic and test benches
In this problem you will first implement a 4-bit up-counter using a VHDL process statment. The up-counter shall be incremented using one of the onboard push buttons ( KEY1 ) as a *count enable*. A second push button ( KEY0 ) will be used to reset the up-counter asynchronously. You will then use a pre-made template to write a test bench that can be used to verify correct behaviour of the up-counter before finally programming the FPGA.


```{admonition} The learning outcome of this problem is to:
* be able to use the *process* statement in VHDL to describe synchronous logic,
* be able to write a basic adder or up-counter in VHDL making use of the *unsigned* signal type and the IEEE numeric standard library,
* understand the limitation of directly using an external push button as an enable to increase the counter value.
* be able to verify a design using through simulation and writing of a test bench design.
```


## Design a 4-bit up-counter with active low asynchronous reset

* To connect the two external push buttons to the FPGA you will have to add two ports in the entity description of your design.
* Since this will be a synchronous design it will make use of an external crystal to provide a reqular clock of 50 MHz that can be used by the FPGA design.

A up-counter is a piece of logic that increments a value when triggerd by an input condition to the up-counter.  When the input condition is not present, the counter needs to store the current value. To store a value in an FPGA a memory element is needed, and the most simple memory element that can be used in an FPGA is the register/flipflop of look-up table. A register can be instantiated, or made use of if, by using the *process* statement in VHDL in synchronous mode, that is, triggered by the rising or falling edge of a clock signal. In general, a up-counter can be described by the following or similar syntax in most programming languages:

```
counter = counter + 1
```

In VHDL we will use a signal object to implement the up-counter. The only syntax difference is to use the language specific assignment operator and add a semicolon at the end.

```vhdl
counter <= counter + 1;
```

Since this signal is not present at the port level of the design, it has to be declared as an internal signal. Arithmetic operations are not supported by the IEEE standard logic 1164 package. The solution is to use the IEEE numeric standard package and declare the signal of type *unsigned*. Some background on the numeric package [here](https://www.doulos.com/knowhow/vhdl/vhdl-vector-arithmetic-using-numeric_std/). This package also includes functions to convert between e.g., a standard logic vector and unsigned.

```vhdl
-- include the numeric std library
use ieee.numeric_std.all;

-- Declare the counter signal in the appropriate place
signal counter : unsigned(3 downto 0);
```


%```{admonition } Remark
%#VHDL has a well-designed package `IEEE.Numeric_Std` which creates two new data types unsigned and signed. However it #would sometimes be %convenient to do arithmetic on `std_logic_vector` directly - treating it as either two's complement #or unsigned. cite{doulos_vhdl_2008}
%#
%#In the past this has mainly been achieved by using the non-standard `std_logic_unsigned` and `std_logic_signed` #packages. VHDL-2008 %addresses this issue by adding two new standard arithmetic packages, `IEEE.Numeric_Std_Unsigned` #and `IEEE.Numeric_Std_Signed`.
%```

* Write the *process* statement that describes the 4-bit up-counter that is incremented when the external KEY1 is pressed. Remember to add the asynchronous reset. For more information on how to model counters in VHDL see chapter 9.4 in LaMeres, *Introduction to Logic Circuits & Logic Design with VHDL*.
* The value of the counter shall be shown on the 7-segment display. Modify the *with-select* statement to have the output of the counter control the value on the 7-segment display.



## Verify your design through simulations

Before downloading the new design to the FPGA we want to make sure that the design is working as expected. For this purpose we would like to be able to generate input stimuli / patterns to drive out system and to observe how the system and outputs respond to that stimuli. For this purpose HDL languages makes use of a concept called test benches. A test bench is typically a VHDL file or module that has no inputs or outputs. It is structured similarly to a standard VHDL file with a *Library and package*, an *entity* and and *architecture* part. The main difference is that the entity has no ports since it is only supposed to generate internal stimuli to drive and monitor the system under test which is declared as a component inside the test bench module. Another important difference is that a test bench will not be synthesized and downloaded to an FPGA. A test bench can therefore make use of the complete the VHDL language universe.

A simulation tool like Modelsim can be used to run the test bench and visualize its behaviour in a wave diagram format. Modelsim is a commercial tool, but a free version called *Modelsim-Intel FPGA Starter Edition* is included when downloading and installing the the Quartus Prime Lite Edition. The starter edition is limited to 10000 lines of code. Above this, the performance of the simulator is significantly reduced. An open-source alternative for the VHDL language is [GHDL](http://ghdl.free.fr) or [GHDL on Github](https://github.com/ghdl/ghdl). The outout of GHDL can be read and viewed by [GTKWave](http://gtkwave.sourceforge.net). Since Modelsim is already included in Quartus Prime Lite, and since is is the most used tool in industry, we will use Modelsim in FYS4220. You are however free to try out GHDL and GTKWave at your leisure.

A very brief introduction to test benches is given chapter 5.7 in n LaMeres, *Introduction to Logic Circuits & Logic Design with VHDL*.

* Create a new directory called *tb* in your project folder. Open your favorite text editor, and write the test bench template shown below into a file called `lab1_tb.vhd` in the tb directory.

```vhdl
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lab1_tb is
end;

architecture testbench of lab1_tb is

  -- Signal declarations
  -- The clk related signals is provided as an example
  signal clk          : std_logic;
  signal clk_ena      : boolean;
  constant clk_period : time := 20 ns;  -- 50 MHz
  -- Declare all the remaining required top level signals.



  -- Component declarations
  -- Declare the component to be tested.

begin

  -- Instantiate the port map for the unit under test.
  -- Keep the label name UUT
  UUT :


  -- create a 50 MHz clock
  -- The clk signal can be disabled or enabled by the clk_ena signal
  clk <= not clk after clk_period/2 when clk_ena else '0';


  -- Write the stimuli process

  stimuli_process : process
  begin
    -- set default values

    -- enable clk and wait for 3 clk periods

    -- assert arst_n for 3 clk periods

    -- deassert arst_n for 3 clk periods

    -- enable counter and wait for 20 clk_periods

    -- disable counter and wait for 5 clk_periods

    -- assert arst_n for 3 clk periods

    -- deassert arst_n for 10 clk periods

    -- disable clk

    -- end of simulation
    -- wait;
  end process stimuli_process;
end architecture testbench;
```

```{admonition} How to end a simulation
The stimuli process in a test bench is meant to run only once. To achieve this the process must use a *wait* statement at the end of the process. However, as long as there is activity on any of the signals the simulation will not end. A clock is in principle a continuously running signal. However, by using a clock enable signal, the clock can easily be disabled. Try to run your simulation without a wait statement or without disabling the clock and see what happens.
```


* Open Modelsim-Altera and create a new project (File-> New -> Project). Specify the folder simulation/modelsim as the Project Location as shown in {numref}`fig:assignments-create-modelsim-project`

```{figure} ../images/assignments_vsim_project.png
---
width: 500
align: center
name: fig:assignments-create-modelsim-project
---
Create Modelsim project.
```

* When asked to add items to the project choose “Add Existing File”, browse to the src and tb directories and add both the *lab1.vhd* and *lab1_tb.vhd*.

* The files have to be compiled in the correct order. E.g. *lab1_tb.vhd* is dependent on *lab1.vhd*, *lab1.vhd* therefore has to be compiled first. To compile right click on the file and choose (Compile -> Compile Selected).

* Start the simulation: (Simulate -> Start Simulation), and choose the design unit *lab1_tb.vhd* under the work library as shown in figure ref{numref}`fig:assignments-simulation`

```{figure} ../images/assignments_vsim_startsim.png
---
width: 500
align: center
name: fig:assignments-simulation
---
Choose the test bench entity to start the simuliation.
```

* Open the wave window if not already opened (View -> Wave).

* Add all the top level signals to the wave window by marking them in the objects window, right click and choose “Add Wave” shown in f{numref}`fig:assignments-addsignal`. To add the counter signal internal to the, right click on the *lab1* instance and choose the *counter* signal.

```{figure} ../images/assignments_vsim_addsignal.png
---
width: 500
align: center
name: fig:assignments-addsignal
---
Mark relevant signals to be added to the wave window.
```

* Run the simulation and verify that the design is working as expected. (Simulate -> Run -> Run -All).

* You should see a result similar to the wave diagram shown in figure {numref}`fig:assignments-result`

```{figure} ../images/assignments_vsim_result.png
---
width: 800
align: center
name: fig:assignments-result
---
Wave window simulation result. Right click on image and open in new Tab to enlarged.
```


The wave diagram in figure {numref}`fig:assignments-result` is the result of a simulation where the signal *counter* was declared without an initial value. This means that at the start of the simulation, the signal *counter* is undefined *'U'*.
For the assignment below where *1* is added to an undefined signal, the result of the assignment will still be undefined. In this assignment the an asynchronous reset signal shall be used to reset the counter. Thus, only when this reset signal becomes acitve, the counter will no longer be undefined.

```vhdl
counter <= counter + 1;
```

The undefined value can also be removed by providing the signal *counter* with an initial value when it is declared.

```vhdl
signal counter : unsigned(3 downto 0) := "0000";
```

Try to declare the signal with a default value, rerun the simulation and check the result.

## Compile the project
Before compiling the project you will need to add the new pin assignments to the Tcl-script script file. Remember to re-run the tcl-script before compiling the project. If you have used different identifier names for your port entries, make sure to match them with the one used in the Tcl-file.

```tcl
#50MHz clock MAX10_CLK1_50
set_location_assignment PIN_P11 -to clk

#External asynchronous inputs
#Push buttons for external reset and key
#key0 - used as reset
set_location_assignment PIN_B8 -to arst_n
#key1
set_location_assignment PIN_A7 -to ext_ena_n
```

In addition to the warnings seen when compiling the first project in this lab. assignment, you will now also see the warning ”Timing requirements not met”. This warning indicates that the design (in most cases) now has a register-to-register path that exceeds the clock period. However, we have not yet specified the actual clock period for our design and a default clock period of 1000 MHz have therefore been set by Quartus as a default value.

* Verify this setting by opening the compilation report and navigate to the ”Clocks” part of the Timing Analyzer. ”Processing -> Compilation Report” (Ctrl+R) as shown in {numref}`fig:assignments-clk1000`

```{figure} ../images/assignments_clk1000.png
---
width: 700
align: center
name: fig:assignments-clk1000
---
Compilation report.
```

Timing settings are critically important for a successful design. For this tutorial we will specify the correct clock frequency of 50 MHz by creating a basic Synopsys Design Constraints File (.sdc) that the Quartus Prime Timing Analyzer will use during design compilation. A Synopsys Design Constraints File is required by the Timing Analyzer to get proper timing constraints. Without it, the Compiler will not properly optimize the design.

To create an SDC, perform the following steps:

* Open the Quartus Prime Timing Analyzer by choosing Tools -> Timing Analyzer.
* Create the timing netlist by double clicking on ”Create Timing Netlist” under the Tasks pane.
* Choose File -> New SDC file. The SDC editor opens.
* Choose ”Edit -> Insert constraint -> Create clock”. This will open the window shown in {numref}`fig:assignments-getports`
* Fill in the clock name and correct period value corresponding to 50 MHz.
* You willl need to connect this generated clock to an actual target / port in your design. Click the button with the three dots right of the *Targets* field. Click the *List* button in the new window that just opened and select the *clk* port as shown in {numref}`fig:assignments-selectclock`. The corresponding SDC command is also shown.
* Click *OK* and then *Insert* and this SDC command will be added to the SDC editor.

```{figure} ../images/assignments_getports.png
---
width: 700
align: center
name: fig:assignments-getports
---
Create the clock. 
```

```{figure} ../images/assignments_selectclock.png
---
width: 700
align: center
name: fig:assignments-selectclock
---
Select the clock port.
```


* Save this file in your project directory with the name *de10-lite.sdc*.
* Add this file to the Quartus project: ”Project -> Add current file to project”.
* Close the SDC editor window and recompile the Quartus project.
* Verify that the warning ”Timing requirements not met” is no longer present and that the clock has been constraint to 50 MHz in the compliation report.

```{admonition} Tip
:class: tip
The short-cut to setting up the clock constraint is to create a file called *DE10-lite.sdc* in your *lab1* directory and then save the the following SDC command in the file.

```tcl
create_clock -name clk -period 20.000 [get_ports {clk}]
```


## Program the FPGA

* Open the Quartus programmer and download the recompiled design to your FPGA.
* Press KEY1 to start the counter.
* Press KEY0 to reset the counter


## Update the git repository

When you have completed this part of the lab, including your final documentation in the README.md file, make sure to update the git repository:

```bash
git add -A
git commit -am "Synchronous logic and test benches completed"
git push origin master
git tag -a synchronous-logic-test-benches -m "Synchronous logic and test benches completed"
git push origin synchronous-logic-test-benches
```