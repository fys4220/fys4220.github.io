(rtos-semaphores-example)=
# Semaphore examples

## Protecting shared resources

As mentioned in {numref}`rtos-basic-example` the *OSTimeDlyHMSM* function is used to block the tasks for 3 seconds. Both tasks are using the same resource for writing to the standard output and thus there is a risk that both tasks will use this resources at the same time, resulting in a corrupted output. However, the execution time of the *printf* command in this example is in the order of a few hundered microseconds. The chance that the higher priority task may interrupt the lower priority task in the middle of a *printf* execution is therefore very low.

To better demonstrate this scenario we will have to increase the time it takes to write to the JTAG UART. In addition we can also increase the repetition rate of each task, that is, how often they run. This can be achieved by looping through each character of the text string and using the command *putchar* to write a single character at the time, and reducing the task's time delay. Modify both tasks according to the suggested code below. The use of the *strlen* function requires the *string.h* header file to be included (`#include <string.h>`).

```c
#define TASK1_PRIORITY      4
#define TASK2_PRIORITY      5

void task1(void* pdata)
{
  char text[] = "Hello from task1\n";
  int i;
  while (1)
  {
    for (i = 0; i < strlen(text); i++){
      putchar(text[i]);
    }
    //printf("Hello from task2\n");
    OSTimeDlyHMSM(0, 0, 0, 20);
  }
}

void task2(void* pdata)
{
  char text[] = "Hello from task2\n";
  int i;
  while (1)
  {
    for (i = 0; i < strlen(text); i++){
      putchar(text[i]);
    }
    //printf("Hello from task2\n");
    OSTimeDlyHMSM(0, 0, 0, 4);
  }
}
```

Compile the modified code and observe the result in the Nios-II terminal application.  

When running the code the output will sometimes be corrupted, e.g., like the output example shown below. That is, the higher priority task will interrupt the lower priority task before it has completed writing the full text string to the standard output. 


```c
Hello from Task2
Hello from Task1
Hello from Task2
Hello from Task2
Hello from Task2
HelloHello from Task1
 from Task2
Hello from Task2
Hello from Task2
Hello from Task1
Hello from Task2
Hello from Task2
```



Since both tasks are using the same resource we need to implement a mechanism that controls the access to this resource. In $\mu$C/OS-II this can be acheived by using a semaphore, where the semaphore needs to be aquired by each task before using the shared resource. When the task no longer needs the resources, the task needs to release the semaphore.


The relevant uC/OS-II functions to be used to declare, create, and use semaphores are shown below.

```c
//Declare a pointer of type OS_EVENT.
OS_EVENT *shared_jtag_sem;
```

```c
//create semaphores in the main() function before starting the multitasking system, and initialize to 1. That is, the semaphore is available from start. If initialize to 0, the semaphore is not available from start.
shared_jtag_sem = OSSemCreate(1);
```

```c
//Prototype functions for OSSemPend and OSSemPost
void OSSemPend (OS_EVENT *pevent,
                INT16U    timeout,
                INT8U    *err);

INT8U OSSemPost(OS_EVENT *pevent);
```

More information about the function calls can be found in the $\mu$c/OS-II API reference section of the $\mu$C/OS-II user manual {cite}`ucosii-manual` [Direct Link](https://micrium.atlassian.net/wiki/spaces/osiidoc/pages/163887/C+OS-II+API+Reference)

Modify the code to use a semaphore called *shared_jtag_sem* to control the access to the JTAG UART. Compile and download the software to observe the difference with respect to not protecting the shared variable with a semaphore.

See also the recoded video lectures on semaphores:

- [Semaphores (8:58)](https://www.uio.no/studier/emner/matnat/fys/FYS4220/h21/forelesningsvideoer/rtos_semaphores.mp4) [(slides)](https://www.uio.no/studier/emner/matnat/fys/FYS4220/h21/lecture-slides/rtos_semaphores.pdf)
- [Example - semaphore (10:59)](https://www.uio.no/studier/emner/matnat/fys/FYS4220/h21/forelesningsvideoer/rtos_semaphore_example.mp4) [(slides)](https://www.uio.no/studier/emner/matnat/fys/FYS4220/h21/lecture-slides/rtos_semaphores_example.pdf)


````{admonition} Complete code example
:class: dropdown

```c
#include <stdio.h>
#include "includes.h"
#include <string.h>

#define TASK_STACKSIZE 1024  // Number of 32 bit words (e.g. 8192 bytes)
OS_STK task1_stk[TASK_STACKSIZE];
OS_STK task2_stk[TASK_STACKSIZE];

#define TASK1_PRIORITY      4
#define TASK2_PRIORITY      5

//Semaphore to protect the shared JTAG resource
OS_EVENT *shared_jtag_sem;

void task1(void* pdata)
{
  char text[] = "Hello from Task1\n";
  int i;
  alt_u8 error_code = OS_NO_ERR;
  while (1)
  {
    // Collect semaphore before writing to JTAG UART
    OSSemPend(shared_jtag_sem,0,&error_code);
    for (i = 0; i < strlen(text); i++){
      putchar(text[i]);
     
    }
    // Release semaphore
    OSSemPost(shared_jtag_sem);
    //printf("Hello from task2\n");
    OSTimeDlyHMSM(0, 0, 0, 20);
  }
}

void task2(void* pdata)
{
  char text[] = "Hello from Task2\n";
  int i;
  alt_u8 error_code = OS_NO_ERR;
  while (1)
  {
    // Collect semaphore before writing to JTAG UART
    OSSemPend(shared_jtag_sem,0,&error_code);
    for (i = 0; i < strlen(text); i++){
      putchar(text[i]);
    }
    // Release semaphore
    OSSemPost(shared_jtag_sem);
    //printf("Hello from task2\n");
    OSTimeDlyHMSM(0, 0, 0, 4);
  }
}

/* The main function creates two task and starts multi-tasking */
int main(void)
{


//create JTAG semaphore and initialize to 1
shared_jtag_sem = OSSemCreate(1);

OSTaskCreateExt(task1,
                    NULL,
                    (void *)&task1_stk[TASK_STACKSIZE-1],
                    TASK1_PRIORITY,
                    TASK1_PRIORITY,
                    task1_stk,
                    TASK_STACKSIZE,
                    NULL,
                    0);


    OSTaskCreateExt(task2,
                    NULL,
                    (void *)&task2_stk[TASK_STACKSIZE-1],
                    TASK2_PRIORITY,
                    TASK2_PRIORITY,
                    task2_stk,
                    TASK_STACKSIZE,
                    NULL,
                    0);


    OSStart();
    return 0;
}

```

````


## Synchronization of tasks

In the example above the semaphore was used to protect the access to a shared resource. In addition a semaphore can also be used to synchronize the execution of a task with another task or event. In {numref}`embedded-interrupt` we implemented interrupt handling for an external push button. In this case we can make use of a semaphore to execture a task every time the push button generates is pressed. 

When used for synchronization a semaphore must be initialize to 0, and then made available (posted) from the interrupt handling routine on an active interrupt. The task being synchronized to the interrupt must wait for the semaphore (pend).

Your task will now be to synchronize *task1* from the example above with the interrupt generated by the push button. Try to solve the problem by yourself before you look at the solution example below. 

````{admonition} Complete code example
:class: dropdown

```c
#include <stdio.h>
#include "includes.h"
#include <string.h>
#include "altera_avalon_pio_regs.h" //access to PIO macros

#define TASK_STACKSIZE 1024  // Number of 32 bit words (e.g. 8192 bytes)
OS_STK task1_stk[TASK_STACKSIZE];
OS_STK task2_stk[TASK_STACKSIZE];

#define TASK1_PRIORITY      4
#define TASK2_PRIORITY      5

//Semaphore to protect the shared JTAG resource
OS_EVENT *shared_jtag_sem;

//Synchronization semaphore
OS_EVENT *shared_key1_sem;

//Gobal variable to hold the value of the edge capture register.
volatile int edge_capture;

//The interrupt service routine 
static void handle_interrupts(void* context)
{   
    //Cast context to edge_capture's type
	//Volatile to avoid compiler optimization
    //this will point to the edge_capture variable.
	volatile int* edge_capture_ptr = (volatile int*) context;

	//Read the edge capture register on the PIO and store the value
    //The value will be stored in the edge_capture variable and accessible
    //from other parts of the code.
	*edge_capture_ptr = IORD_ALTERA_AVALON_PIO_EDGE_CAP(PIO_IRQ_BASE);

	//Write to edge capture register to reset it
	IOWR_ALTERA_AVALON_PIO_EDGE_CAP(PIO_IRQ_BASE,0);

  // Post the semaphore to synchronize with task1
  OSSemPost(shared_key1_sem);

}

// Register the interrupt with the CPU
static void init_interrupts()
{
	//Recast the edge_capture point to match the
	//alt_irq_register() function prototypo
	void* edge_capture_ptr = (void*)&edge_capture;

	//In this case we enable only the interrupt connected to the push button
	IOWR_ALTERA_AVALON_PIO_IRQ_MASK(PIO_IRQ_BASE,0x1);

	//Reset the edge capture register
	IOWR_ALTERA_AVALON_PIO_EDGE_CAP(PIO_IRQ_BASE,0);

	//Register the interrupt handler in the system
    //The ID and PIO_IRQ number is available from the system.h file.
	alt_ic_isr_register(PIO_IRQ_IRQ_INTERRUPT_CONTROLLER_ID,
			PIO_IRQ_IRQ, handle_interrupts, edge_capture_ptr, 0x0);


}



void task1(void* pdata)
{
  char text[] = "Hello from Task1 on interrupt!\n";
  int i;
  alt_u8 error_code = OS_NO_ERR;
  while (1)
  {
    // Wait for the sempahore from interrupt handling routine before executing the task
    OSSemPend(shared_key1_sem,0,&error_code);

    // Collect semaphore before writing to JTAG UART
    OSSemPend(shared_jtag_sem,0,&error_code);
    for (i = 0; i < strlen(text); i++){
      putchar(text[i]);
     
    }
    // Release semaphore
    OSSemPost(shared_jtag_sem);
    //printf("Hello from task2\n");

    // The task will only be exectuted when the semaphore is available.
    // The PEND function will make sure that the task is blocked 
    // and the OSTimeDlyHMSM is no longer needed.
    //OSTimeDlyHMSM(0, 0, 0, 20);
  }
}

void task2(void* pdata)
{
  char text[] = "Hello from Task2\n";
  int i;
  alt_u8 error_code = OS_NO_ERR;
  while (1)
  {
    // Collect semaphore before writing to JTAG UART
    OSSemPend(shared_jtag_sem,0,&error_code);
    for (i = 0; i < strlen(text); i++){
      putchar(text[i]);
    }
    // Release semaphore
    OSSemPost(shared_jtag_sem);
    //printf("Hello from task2\n");

    OSTimeDlyHMSM(0, 0, 0, 4);
  }
}

/* The main function creates two task and starts multi-tasking */
int main(void)
{


//create JTAG semaphore and initialize to 1
shared_jtag_sem = OSSemCreate(1);

//create synchronization semaphore and initialize to 0
shared_key1_sem = OSSemCreate(0);

//Initialize interrupt
init_interrupts();


OSTaskCreateExt(task1,
                    NULL,
                    (void *)&task1_stk[TASK_STACKSIZE-1],
                    TASK1_PRIORITY,
                    TASK1_PRIORITY,
                    task1_stk,
                    TASK_STACKSIZE,
                    NULL,
                    0);


    OSTaskCreateExt(task2,
                    NULL,
                    (void *)&task2_stk[TASK_STACKSIZE-1],
                    TASK2_PRIORITY,
                    TASK2_PRIORITY,
                    task2_stk,
                    TASK_STACKSIZE,
                    NULL,
                    0);


    OSStart();
    return 0;
}

```

````






