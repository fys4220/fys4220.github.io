(assignments-synchronization)=
# Synchronization and edge-detection 

```{admonition} Tip
:class:
Read the following resource before solving this problem: [Synchronization and Edge-detection](https://www.doulos.com/knowhow/fpga/synchronisation/).
```

When sampling a signal from an asynchronous domain (e.g. a button push) or a signal crossing a clock domain, it is required to synchronize the signal to avoid a metastable condition.

A synchronization register chain, or synchronizer, is defined as a sequence of registers that meets the following requirements:
* The registers in the chain are all clocked by the same clock or phase-related clocks.
* The first register in the chain is driven asynchronously or from an unrelated clock domain.
* Each register fans out to only one register, except the last register in the chain.


## Add synchronization registers

The *ext_ena_n* signal is connected to the push button and is an external asynchronous signal. It therefore needs to be synchronized.

* Add synchronization registers to this signals


## Add edge detection

The FPGA runs on a 50 MHz clock, which means that one clock period is 20 ns. When pressing the push button the signal will be much longer than one clock period. The counter will therefore not increment in steps of one. To achieve this, the counter needs to increment on a unique event and not the level of the enable signal. A unique event can be either the rising or falling edge of the enable signal. As the enable signal is not a dedicated clock signal, it is not possible to use the `rising_edge()` or `falling_edge()` statement.

* Write the necessary VHDL code to implement edge detection on the enable signal.
* Re-run the simulation and verify that the counter increments in steps of one.
* Re-program the FPGA and verify that this also works in practice.



## Update the git repository:

When you have completed this part of the lab make sure to update the git repository:

```bash
    git add -A
    git commit -am "Synchronization and edge-detection completed"
    git push origin master
    git tag -a synchronization-edge-detection -m "Synchronization and edge-detection completed"
    git push origin synchronization-edge-detection
```

%!bquestion
%Please answer these questions in the *readme.md* file. Make sure to include the questions to give your answer context and to provide a complete reference for later.

%!bsubex
%What is the purpose of synchronization registers and when do you need to use them?
%!esubex

%!equestion
