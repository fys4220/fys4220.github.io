(embedded-memory-mapped)=
# Memory mapped interfaces

*Memory mapped I/O (MMIO)* is a method of performing input/output between the central processing unit (CPU) and peripheral devices in a computer. Memory mapped I/O uses the same regular address space to address both memory and I/O devices. The memory and registers of the I/O devices are mapped to (associated with) address values. This means that when an address is accessed by the CPU, it may refer to a portion of the physical RAM, or it may refer to a memory region connected to I/O devices. Thus, the CPU instructions used to access the memory can also be used to access peripheral devices, and areas of the CPU addressable space must be reserved for I/O rather than memory.



<div class="video-container">
<iframe width="806" height="605" src="https://www.youtube.com/embed/qNs9rQnNODI" title="embedded memory mapped" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

[[Slides]](https://www.uio.no/studier/emner/matnat/fys/FYS4220/h22/lecture-slides/embedded_memory_mapped.pdf)

## The Avalon interface

The Nios II architecture supports separate instruction and data busses, classifying it as a [Harvard architecture](https://en.wikipedia.org/wiki/Harvard_architecture) cite. Both the instruction and data buses are implemented as Avalon memory mapped (Avalon-MM) master ports that adhere to the Avalon-MM  interface specification.

<div class="video-container">
<iframe width="946" height="710" src="https://www.youtube.com/embed/jiTtDPerlyk" title="embedded avalon interface" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

[[Slides]](https://www.uio.no/studier/emner/matnat/fys/FYS4220/h21/lecture-slides/embedded_niosii_avalon_bus.pdf)

```{admonition} Comment to video
From 8:22 this video covers the implementation of an I2C-master, which was used previously in this course. Although we are using a UART controller for the embedded systems project in 2021, the explanations and general concepts are still highly relevant. 
```




The Nios-II CPU uses the [Avalon-MM interface](https://www.intel.com/content/dam/www/programmable/us/en/pdfs/literature/manual/mnl_avalon_spec.pdf) to provide memory mapped read and write access to peripheral devices. The following Avalon interfaces are available:

* Avalon Clock Inteface
  * drives and receives clocks
* Avalon Reset Interface
  * provides reset connectivity
* Avalon Memory-Mapped Inteface (Avalon MM)
  * address-based read/write interface (typical of master-slave connections)
* Avalon Streaming Inteface (Avalon ST)
  * support unidirectional flow of data
* Avalon Conduit Interface
  * for individual signals or group of signals that do not fit into any of the other Avalon Interface types. Conduit signals can be exported to make external connections. That is connections outside of the Nios II system.
* Avalon interrupt interface:
  * allows components to signal events to other components

{numref}`fig:embedded-avalon-mm` shows a typical system, highlighting the Avalon-MM slave interface connection to the interconnect fabric.

```{figure} ../images/embedded_avalon_mm.png
---
width: 60%
align: center
name: fig:embedded-avalon-mm
---
Example of Avalon MM-system
```

Avalon-MM interfaces range from simple to complex and typically include only the signals required for the specific component logic that is being implemented. All components must include the Avalon Clock and Reset interfaces. Avalon interfaces are an open standard, that is no license or royality is required to develop and sell products that use, or are based on Avalon interfaces.

More information about the Avalon memory mapped interfaces can be found in Chapter 3 of the [Avalon Interface Specificiation document by Intel](https://www.intel.com/content/dam/www/programmable/us/en/pdfs/literature/manual/mnl_avalon_spec.pdf)


## An Avalon MM module example
The CPU of a Microcontroller system has different regions of its memory reserved for different perpipherals like GPIO ADC, UART, I2C, SPI, Timers and others.  These peripherals occupy an specified address area of the CPU's memory and can be accessed by using the systems standard read and write operations. The peripherals therefore need to have a set of registers that is part of the addressable memory space of the CPU. 

To create a register in VHDL we need to make use a clocked process statment. Every signal assignment within a `rising_edge` condition of a clocked proccess will use a flip-flop in one of the FPGAs logic blocks. 

```vhdl
library ieee;
use ieee.std_logic_1164.all;

entity test is
  port(
    clk        : in std_logic;
    write_data : in std_logic_vector(31 downto 0)
  );
end entity;

architecture rtl of test is
    signal data_reg : std_logic_vector(31 downto 0);
begin
    p_reg: process(clk)
    begin
        if rising_edge(clk) then
            data_reg <= write_data;    
        end if;
    end process;
end architecture;
```

If the signal assignment is a vector, as in the example above, each bit position of the vector will result in a flipflop. A 32-bit vector will therefore use 32 flip-flops.

The registers can be made addressable by enclosing then in a conditional statement like e.g., the case-statement. To adhere to the Avalon standard we also need to include a write enable.

```vhdl
library ieee;
use ieee.std_logic_1164.all;

entity test is
  port(
    clk          : in std_logic;
    write_enable : in std_logic;
    write_data   : in std_logic_vector(31 downto 0);
    address      : in std_logic_vector(1 downto 0)
  );
end entity;

architecture rtl of test is
    signal data_reg1 : std_logic_vector(31 downto 0);
    signal data_reg2 : std_logic_vector(31 downto 0);
    signal data_reg3 : std_logic_vector(31 downto 0);
    signal data_reg4 : std_logic_vector(31 downto 0);

begin
  p_reg: process(clk)
    begin
      if rising_edge(clk) then
        if write_enable = '1' then
          case address is
            when "00" =>
              data_reg1 <= write_data;
            when "01" =>
              data_reg2 <= write_data;
            when "10" =>
              data_reg3 <= write_data;
            when "11" =>
              data_reg4 <= write_data;
          end case;
        end if;    
      end if;
  end process;
end architecture;
```

The example above implements four writable 32-bit registers. The example can be expanded to also make the registers readable. 

```vhdl
library ieee;
use ieee.std_logic_1164.all;

entity test is
  port(
    clk          : in std_logic;
    write_data   : in std_logic_vector(31 downto 0);
    read_data    : out std_logic_vector(31 downto 0);
    address      : in std_logic_vector(1 downto 0);
    read_enable  : in std_logic;
    write_enable : in std_logic
  );
end entity;

architecture rtl of test is
    signal data_reg1 : std_logic_vector(31 downto 0);
    signal data_reg2 : std_logic_vector(31 downto 0);
    signal data_reg3 : std_logic_vector(31 downto 0);
    signal data_reg4 : std_logic_vector(31 downto 0);


begin
  p_reg: process(clk)
    begin
      if rising_edge(clk) then
        -- Write to registers
        if write_enable = '1' then 
          case address is
            when "00" =>
              data_reg1 <= write_data;
            when "01" =>
              data_reg2 <= write_data;
            when "10" =>
              data_reg3 <= write_data;
            when "11" =>
              data_reg4 <= write_data;
          end case;
        end if;
        -- Read from registers
        if read_enable = '1' then 
          case address is
            when "00" =>
              read_data <= data_reg1;
            when "01" =>
              read_data <= data_reg2;
          end case;
        end if;
      end if;
  end process;
end architecture;
```

The last modification that is needed to adhere to the Avalon standard is to add a reset. For this example an asynchronous active low reset will be used.

```vhdl
library ieee;
use ieee.std_logic_1164.all;

entity test is
  port(
    clk          : in std_logic;
    arst_n       : in std_logic;
    write_data   : in std_logic_vector(31 downto 0);
    read_data    : out std_logic_vector(31 downto 0);
    address      : in std_logic_vector(1 downto 0);
    read_enable  : in std_logic;
    write_enable : in std_logic
  );
end entity;

architecture rtl of test is
    signal data_reg1 : std_logic_vector(31 downto 0);
    signal data_reg2 : std_logic_vector(31 downto 0);
    signal data_reg3 : std_logic_vector(31 downto 0);
    signal data_reg4 : std_logic_vector(31 downto 0);


begin
  p_reg: process(clk)
    begin
      if arst_n = '0' then
        data_reg1 <= (others => '0');
        data_reg2 <= (others => '0');
      elsif rising_edge(clk) then
        -- Write to registers
        if write_enable = '1' then 
          case address is
            when "00" =>
              data_reg1 <= write_data;
            when "01" =>
              data_reg2 <= write_data;
            when "10" =>
              data_reg3 <= write_data;
            when "11" =>
              data_reg4 <= write_data;
          end case;
        end if;
        -- Read from registers
        if read_enable = '1' then 
          case address is
            when "00" =>
              read_data <= data_reg1;
            when "01" =>
              read_data <= data_reg2;
            when "10" =>
              read_data <= data_reg3;
            when "11" =>
              read_data <= data_reg4;
          end case;
        end if;
      end if;
  end process;
end architecture;
```


%#In the 2. part of the [Advanced test benches](Advanced-test-benches) assignment %you will design a component (system IP) that can be memory mapped to the Nios II %CPU.
%
%A Nios II memory mapped system component contains two parts:
%* Internal hardware modules for desired functionality
%* An Avalon-MM interface to communicate with the Nios II computer.
%
%For the FYS4220 embedded systems project the desired functionality will be the I2C %module and the communication interface will consist of
%* an Avalon memory mapped register interface
%  * chipselect, write, read, address, writedata, readdata
%* an Avalon clock interfaces (clock),
%* an Avalon reset interface (reset)
%* a Conduit interface for exporting the SDA and SCL lines.
%
%
%The required signals are shown in figure ref{fig:i2c_avalon_mm}. In addition to %interfacing the CPU, the I2C module also needs to interface the external I2C %devices. For this purpose an Avalon Conduit interface will be used to export the %SDA and SCL lines.
%#("Conduit translates to pipe":"https://translate.google.com/#view=home&%op=translate&sl=fr&tl=en&text=conduit").
%
%FIGURE:[${FIGPATH}embedded_i2c_avalon_mm_if, width=700 frac=0.8] I2C avalon memory %mapped interface. label{fig:i2c_avalon_mm}
%
%More information about the Avalon memory mapped interfaces can be found in chapter %3 of the Avalon Interface Specificiation document by Intel cite%{avalon_specification}.
%
%The CPU communicates with the respecitve memory mapped components on the Avalon bus %by reading from and writing to the component's register interface. This register %interface is mapped to the CPU's address space, and each register has its own %address value. A basic example of how such a register interface can be implemented %in VHDL is shown below:

