# Operators

## Arithmetic operators

The following arithmetic operators are available in VHDL:



| Operator character | Arithmetic operation |
| ------------------ | -------------------- |
| +                  | Addition             |
| -                  | Subtraction          |
| *                  | Multiplication       |
| /                  | Division             |

Arithmetic operations cannot be used directly on objects of the type *std_logic*. When doing arithmetic operations, it is instead recommended to declare the object using the type *usigned* , *signed* , or *integer*, for which these arithmetic operators are defined when using the library:

```vhdl
ieee.numeric_std.all;
```

Some background on the numeric package can be [here](https://www.doulos.com/knowhow/vhdl/vhdl-vector-arithmetic-using-numeric_std/). This package also includes functions to convert between e.g. a standard logic vector and unsigned.

## Logic operators 

The following logic operators are available in VHDL and defined in the *ieee.std_logic_1164* packages:

```vhdl
not, and, nand, or, nor, xor, xnor
```

Logical operators do not have precedence except for *not*.

```vhdl
Y <= A xor B and c; -- this line will generate an error.

Y <= A xor (B and C); -- this line will be processed succesfully
```

On the other hand when using *not*, both of the lines below will be processed successfully. Still, it is recommended to be generous with parantehsis for readability.

```vhdl
-- these two statements are identical
-- not has precedence over and
not A and B;
(not A) and B;
```


## Relational operations

The following relational operator can be used in VHDL:

| Operator character | Arithmetic operation     |
| ------------------ | ------------------------ |
| =                  | Equality                 |
| /=                 | Inequality               |
| <                  | Smaller than             |
| <=                 | Smaller than or equal to |
| >                  | Larger than              |
| >=                 | Larger than or equal to  |


The operands must both be of the same type, and the result is a Boolean value (true/false)

_Example (incorrect):_

```vhdl
signal test : std_logic;
-----------------------
if test = 1 then -- This will give an error.
```


This will given an error because *test* is *std_logic* while *1* is an integer. Instead the signal should be declared as *integer* or *unsigned*:

_Example (correct):_
```vhdl
signal test : integer;

if test = 1 then
```

_Example (correct):_
```vhdl
signal test : unsigned;
-----------------------
if test = 1 then
```

or the use of the number *1* should indicate that it is a *std_logic* by enclosing the *1* in '', like '1'.


_Example (correct):_

```vhdl
signal test : std_logic;
-----------------------
if test = '1' then
```


## Operator priority 

List of operator priorities from high to low:

```vhdl
1. **, abs, not
2. *, /, mod, rem
3. +, - (unary versions)
4. +, -, &
5. sll, srl, sla, sra, rol, ror
6. =, /=, <, <=, >, >=, ?=, ?/=, ?<, ?<=, ?>, ?>=
7. and, or, nand, nor, xor, xnor
```

Be careful when you are typing expressions; make sure to use enough parenthesis.