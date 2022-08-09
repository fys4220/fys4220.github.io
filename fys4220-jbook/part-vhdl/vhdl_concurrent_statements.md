# Concurrent statements

VHDL is a hardware description language. While code running on a processor is executed sequentially, a VHDL description is mapped onto hardware resources in an FPGA. This means that multiple instances of hardware functionality can be realised and operate concurrently. 

All statements in the architecture part of the VHDL description are concurrent statement. I.e., each statement implements a hardware functionality. This also means that the order of the statements in the architecture is irrelevant. 

 

A statement can be a simple connection like 

```{code-block} vhdl
A <= B;
```

where the signal B is connected to the signal A. This can be thought of as a simple connection or wire if you like. 

But a statement can also be more complex. It can include logic operations or be conditional

```{code-block} vhdl
A <= B and  C;

A <= B when S = '1' else C;
```
