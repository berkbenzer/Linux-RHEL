
SOURCE: https://cromwell-intl.com/open-source/performance-tuning/disks.html


Deadline Scheduler
The deadline algorithm attempts to limit the maximum latency and keep the humans happy. 
Every I/O request is assigned its own deadline and it should be completed before that timer expires.
Two queues are maintained per device, one sorted by sector and the other by deadline. 
As long as no deadlines are expiring, the I/O requests are done in sector order to minimize head motion and provide best throughput.

1: People use your system interactively. Your work load is dominated by interactive applications, either users who otherwise may complain of sluggish performance or databases with many I/O operations.
2: Read operations happen significantly more often than write operations, as applications are more likely to block waiting to read data.
3: Your storage hardware is a SAN (Storage Area Network) or RAID array with deep I/O buffers.
Red Hat uses deadline by default for non-SATA disks starting at RHEL 7. IBM System z uses deadline by default for all disks.

CFQ Scheduler
The CFQ or Completely Fair Queuing algorithm first divides processes into the three classes of Real Time, Best Effort, and Idle.
Real Time processes are served before Best Effort processes, which in turn are served before Idle processes. Within each class, 
the kernel attempts to give every thread the same number of time slices. Processes are assigned to the Best Effort class by default, 
you can change the I/O priority for a process with ionice. The kernel uses recent I/O patterns to anticipate whether an 
application will issue more requests in the near future, and if more I/O is anticipated, the kernel will wait even though other 
processes have pending I/O.
CFQ can improve throughput at the cost of worse latency. Users are sensitive to latency and will not like the result
when their applications are bound by CFQ.
Reasons to use the CFQ scheduler:
1: People do not use your system interactively, at least not much. Throughput is more important than latency, 
but latency is still important enough that you don't want to use NOOP.
2: You are not using XFS. According to xfs.org, the CFQ scheduler defeats much of the parallelization in XFS.
Red Hat uses this by default for SATA disks starting at RHEL 7. And they use XFS by default...

 
NOOP Scheduler
The NOOP scheduler does nothing to change the order or priority, it simply handles the requests in the order they were submitted.
This can provide the best throughput, especially on storage subsystems that provide their own queuing such as solid-state drives, intelligent RAID controllers with their own buffer and cache, and Storage Area Networks.
This usually makes for the worst latency, so it would be a poor choice for interactive use.
Reasons to use the noop scheduler include:
1: Throughput is your dominant concern, you don't care about latency. Users don't use the system interactively.
2: Your work load is CPU-bound: most of the time we're waiting for the CPU to finish something, I/O events are relatively 
small and widely spaced.







