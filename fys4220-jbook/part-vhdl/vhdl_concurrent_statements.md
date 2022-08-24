(vhdl-concurrent-statements)=
# Concurrent statements

VHDL is a hardware description language. While code running on a processor is executed sequentially, a VHDL description is mapped onto hardware resources in an FPGA. This means that multiple instances of hardware functionality can be realised and operate concurrently. 

All statements in the architecture part of the VHDL description are concurrent statement. I.e., each statement implements a hardware functionality. 

A statement can be a simple connection like 

```{code-block} vhdl
A <= B;
```

where the signal B is connected to the signal A. This can be thought of as a simple connection or wire if you like. 

But a statement can also be more complex. It can include logic operations or be conditional as shown in the code block below. Here the code will result in an AND-gate and a multiplexer.

```{code-block} vhdl
A <= B and C;

Y <= B when S = '1' else C;
```

Since each statement are concurrent and make up a separate piece of hardware, the order of the statements in the architecture is irrelevant: 

```{code-block} vhdl
B <= C;
A <= B;
```
is equivalent to 
```{code-block} vhdl
A <= B;
B <= C;
```

%This also means that the order of the statements in the architecture is irrelevant. 


```{admonition} Supplementary suggested reading
Read more about concurrent statements, signal assignments, and conditional assignments in sections 4.1--4.5 in {Download}` Mealy and Teppero, Free Range VHDL. <../docs/free_range_vhdl.pdf>` 
```
