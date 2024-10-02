(rtos-intertask)=
# Intertask communication

When you write code for an embedded system it can be advantageous to split the different functions of the software into smaller tasks. As already seen, this can be easily achieved when using an RTOS. However, most likely these tasks are not completely isolated and need to communicate with each other. This communication is referred to as intertask communication, a mechanism serving to exchange information between tasks. Semaphores and messages are two of the most common services provided by an RTOS to do this. The following video will give an introduction to intertask communication, while the following sections will cover semaphores and messages, and one of the problems that may occure when using semaphores: priority inversion. 
<div class="video-container">
<iframe width="806" height="451" src="https://www.youtube.com/embed/Ioi89uZ6JE4" title="rtos intertask communication" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

[[Slides]](https://www.uio.no/studier/emner/matnat/fys/FYS4220/h22/lecture-slides/rtos_intertask_communication.pdf)




 ```{admonition} Supplementary suggested reading
uC/OS-II manual - Real-Time system Concepts
* [Available online as HTML and PDF](https://micrium.atlassian.net/wiki/spaces/osiidoc/overview)
 ```
