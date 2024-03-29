(embedded-interrupt)=
# Interrupt handling

Sometimes it is necessary to temporarily interrupt the ongoing task being executed by the CPU. These interrupts can be both synchronous and asynchonrous. Synchronous interrupts are produced by the CPU, i.e., they are produced by software. Synchronous interrupts are often referred to as exceptions or events. They are synchronous because the are only issued after the execution of an ongoing task has been completed.  

Asynchronous interrupts are signals generated by hardware circuits both inside and outside of the CPU chip. They are asynchronous because they are generated from a circuit which is independent from the execution flow of the processor. An asynchronous interrupt will therefore alter the normal sequence of instructions executed by the CPU. 

Source: Chapter 4 Interrupts and Exceptions in {cite}`linuxkernel`.

Interrupts are useful to handle external asynchronous events. Since the CPU does not know when these events will take place, it can not easily be timed into the software flow. Consider an external key press, e.g., from a keyboard or from a push button, which is the example we will demonstrate here. For the CPU to detect this key press, it would need to read the input at regular intervals to check for a changes. This approach is often referred to as polling. It is not very effective as requires CPU execution time and resources every time it polls for a change. Most polls will return with no change, and therefore waste resources. Instead, by using interrupts, the CPU will only spend time on this event when it actually occures. For the CPU to be able to handle interrupts, dedicated hardware and interrupt handling is required. 

%https://www.oreilly.com/library/view/understanding-the-linux/0596002130/ch04.html

```{admonition} Interrupt vs polling
- Polling
    - The driver read the status of a register on a regular basis
- Interrupt
    - Hardware comonent sends a signal to the driver
    - The driver informs the CPU that the HW component is ready to be accessed.
```



(embedded-interrupt-api)=
## Interrupt handling API for Nios II 
The Nios II Hardware Abstraction Layer (HAL) provides an enhanced application program interface (API) for writing, registering and managing Interrupt Service Routines (ISRs). This API is compatible with both internal and external hardware interrupt controllers. It includes the following types of routines:
- Routines called to register and ISR
- Routines called by an ISR to manage its environment
- Routines called to control the ISR behaviour

Enhanced HAL Interrupt API Functions:
- *alt_ic_isr_register()* – Register a specific ISR function
- *alt_ic_irq_enable()* – Enable a specific interrupt
- *alt_ic_irq_disable()* – Disable a specific interrupt
- *alt_ic_irq_enabled()* – Determine if a specific interrupt is enabled
- *alt_irq_disable_all()* – Disable all maskable interrupts
- *alt_irq_enable all()* – Enable all maskable interrupts

Using the enhanced HAL API to implement ISRs requires the following steps:
- Write the ISR that handles hardware interrupts for a specific device
- Register the ISR with the HAL by calling the alt_ic_isr_register() function. This function enables hardware interrupts.

The prototype for alt_ic_isr_register() is:

```c
int alt_ic_isr_register(alt_u32 ic_id,
                        alt_u32 irq,
                        alt_isr_func isr,
                        void *isr_context,
                        void* flags)
```

The function has the following parameters:

- ic_id is the interrupt controller identifier (ID) as defined in system.h
- irq is the hardware interrupt number for the device
- isr is a pointer to the ISR function that is called in response to IRQ number irq
- isr_context points to a data structure associated with the device driver instance. Passed as the input argument to the ISR function to pass context-specific information to the ISR
- flags is reserved

