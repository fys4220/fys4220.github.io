(rtos-intro)=
# RTOS

It is time to start introducing the concept of real-time systems. 

Coming from the FPGA hardware side, we can argue that we already are working in real-time. Our hardware runs on a fast clock (50 MHz in our case) and performs assignments and task on every clock cycle. These assignments are also performed in concurrently. It is not possible to get more real-time than this. 

What is then a real-time system and why do we need one? The short answer is that developing a control system in HDL/hardware is generally considered to be more complicated compared to software development. For many applications there is also no need to have a time resolution in the nanosecond range.

A system may have multiple tasks with different priorities and different response time requirements. A single super loop architecture combined with interrupt handling for high priority tasks may solve the task at hand in many cases. However, more complex systems may still benefit from dividing the software tasks into smaller units. A dedicate schedular is then responsible for deciding which task to run at any given time.  While any operating system will include a task schedular, a real-time kernel's schedular is optimised to be time deterministic. That is, making sure that not only the result of an operation is correct, but also that the result is delivered as close as possible to the expected/planned time. 

In the real-time part of FYS4220 we will cover the basic concepts of tasks and scheduling as well as intertask communications. For the project we will make use of a commercially available real-time kernel to organise the tasks of reading out data from the accelerometer and sending the data to the host PC. 

The following video gives and introduction to real-time operating systems.

<div class="video-container">
<iframe width="806" height="453" src="https://www.youtube.com/embed/flqJUxNL7nM" title="rtos basic concept 2021" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

[[Slides]](https://www.uio.no/studier/emner/matnat/fys/FYS4220/h22/lecture-slides/rtos_basic_concept.pdf)

```{admonition} Supplementary suggested reading

- Chapter 10 - Operating systems in Programming Embedded Systems, 2nd Edition by Michael Barr and Anthony Massa.
  - [Link to UiO library listing](https://bibsys-almaprimo.hosted.exlibrisgroup.com/primo-explore/fulldisplay?docid=BIBSYS_ILS71529520750002201&context=L&vid=UIO&lang=no_NO&search_scope=default_scope&adaptor=Local%20Search%20Engine&isFrbr=true&tab=default_tab&query=any,contains,Programming%20Embedded%20Systems)
  - [Direct link O'Reilly page](https://learning.oreilly.com/library/view/programming-embedded-systems/0596009836/ch10.html)
  - All though written in 2006, and using a different hardware system than for FYS4220, this book cover many general aspects that still are valid. 
 

- uC/OS-II manual - Real-Time system Concepts
  - [Available online as HTML and PDF](https://micrium.atlassian.net/wiki/spaces/osiidoc/overview)
```
