(project-rtos)=
# RTOS 
In this part of the embedded system project you will build the final software application to read out accelerometer sensor data and present this data on the host PC. The software application running on the microcontroller system will use a real-time operating system kernel to split the required functionality into smaller units (tasks), and intertask communication services to communicate data between tasks.

```{admonition} Preparation
Before continuing you should work through the example described in {numref}`rtos-basic-example` and {numref}`rtos-semaphores-example`.

These examples will provide you with the basics of how to write a uC/OS-II software application.

You should also study the datasheet of the ADXL345 {cite}`adxl345-datasheet`, and in particular the sections:

* Theory of operation (p. 13–14)
* Serial communication (p. 15–22)
* Register map (p. 23–27)

```



## Tasks

The main tasks of the software application is to:

* Correctly configure the ADXL345 accelerometer.
* Read out the X-, Y-, Z-data regsiters of the ADXL345.
* Send the accelerometer data over the UART to the host PC.

The configuration will only be performed once at the start of the program, while the readout of data will be performed continuously. Reading data from the accelerometer and writing data to the UART are two operations that naturally can be split into two different tasks. These two tasks will be linked by a message sent from the accelerometer read tasks to the uart send task that contains a new packet of accelerometer data, see Figure {numref}`fig:project-rtos-two-tasks`



```{figure} ../images/project_rtos_two_tasks
---
width: 50%
align: center
name: fig:project-rtos-two-tasks
---
One tasks reads data from the accelerometer and sends the data to another tasks that which again sends the data over the UART to the host PC.
```
