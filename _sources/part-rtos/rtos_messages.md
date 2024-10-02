(rtos-messages)=
# Messages

While a semaphore can be used to communicate the occurance of an event between to task, it can not contain more meaningful data. Instead, an RTOS typically provides messages as a service to communicate data between tasks. Depending on the RTOS, messages can be sub-divided into mailboxes and queues in the case of $\mu$C/OS-II. 


## Message mailbox

I $\mu$C/OS-II, a mailbox is a special memory location that one or more tasks can use to transfer data. A mailbox can only contain one message. The following video gives a brief introduction to mailboxes.

<div class="video-container">
<iframe width="806" height="451" src="https://www.youtube.com/embed/3oZxwjG0R9w" title="FYS4220 RTOS Message mailbox" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

[[Slides]](https://www.uio.no/studier/emner/matnat/fys/FYS4220/h22/lecture-slides/rtos_messages_mailbox.pdf)

The following video demonstrates and example of using a mailbox in $\mu$C/OS-II.

<div class="video-container">
<iframe width="806" height="451" src="https://www.youtube.com/embed/Zgm82MTwHVc" title="FYS4220 RTOS Message mailbox example" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

[[Slides]](https://www.uio.no/studier/emner/matnat/fys/FYS4220/h22/lecture-slides/rtos_messages_mailbox_example.pdf)

## Message queues

While a mailbox can only contain one message, a queue can contain multiple messages. The following video introduces queues.


<div class="video-container">
<iframe width="806" height="451" src="https://www.youtube.com/embed/_Son5I_xHvE" title="FYS4220 RTOS Queues" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>


[[Slides]](https://www.uio.no/studier/emner/matnat/fys/FYS4220/h22/lecture-slides/rtos_messages_queues.pdf)

The following video demonstrates an example of using queues in $\mu$C/OS-II.

<div class="video-container">
<iframe width="806" height="451" src="https://www.youtube.com/embed/l3yi_nF4Ea0" title="FYS4220 RTOS Queue example" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

[[Slides]](https://www.uio.no/studier/emner/matnat/fys/FYS4220/h22/lecture-slides/rtos_messages_queues_example.pdf)

