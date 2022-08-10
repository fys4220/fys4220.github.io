(assignments-seven-segment-display)=
# Combinational logic 
In this problem you will use four of the slide switches to control one of the 7-segment displays on the DE10-Lite board. Each of the slide switches will represent one bit in a 4-bit binary number. A single seven segment display can be used to show integer numbers from 1 to 9. Your task will be to write the VHDL description for the combinational logic that converts the binary coded numbers to their corresponding integer value on the seven segment display.

```{admonition} The learning outcome of this problem is to:
* be able to write basic combinational logic using the selected signal assignment (*with-select*) in VHDL,
* and to control a 7-segment display.
```


## Preparing the project

* A Binary-Coded Decimal (BCD) to 7-segment decoder shall be added to the VHDL design file from {numref}`assignments-first-project` using *selected signal assignment (with-select)*.
* To connect the 7-segment decoder to the external 7-segment display you will need to:
  * modify the entity description by adding an additional output port vector using the suggested identifier name *hex0*,
  * make sure that the new output ports will be connected to the correct pins by adding the required pin assignments in the DE10-lite-pinning Tcl-script.
  * Remember to re-run the Tcl-script after saving the file (Tools -> Tcl Script).
  * You can verify that the correct pinning assignment has been performed in the pinning assignment editor.
  

Check the DE10-Lite User Manual on information on how to use the 7-segment display.


```{admonition} Tip
:class: tip
For more information about the selected signal assigment see Mealy and Tappero, *Free Range VHDL* section 4.5, p. 42, or search the Internet.
```

## Program the FPGA
Return to Quartus, make use of the knowledge aquired in {numref}`assignments-first-project` to compile the design and program the FPGA. Verify that you can use the switches to set the correct number on the 7-segment display.


## Update the git repository
When you have completed this part of the lab make sure to update the git repository:

```bash
git add -A
git commit -am "Seven segment display completed"
git push origin master
git tag -a seven-segment-display -m "Seven segment display completed"
git push origin seven-segment-display
```
