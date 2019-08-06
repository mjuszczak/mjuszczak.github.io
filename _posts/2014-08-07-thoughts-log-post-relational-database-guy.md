---
title: "Thoughts on 'The Log' Post from a Relational Database Guy"
date: 2014-08-07
---

Back in December 2013, [Jay Kreps](https://www.linkedin.com/in/jaykreps) at LinkedIn wrote an utterly brilliant and thought-provoking post in the LinkedIn Engineering blog on "[The Log: What every software engineering should know about real-time data's unifying abstraction.](http://engineering.linkedin.com/distributed-systems/log-what-every-software-engineer-should-know-about-real-time-datas-unifying)" It's taken me awhile to circle back to this and actually record my thoughts.

As someone who has a lot of experience with relational databases and database replication, I felt that the analogies that Jay drew - especially those regarding RDBMS - were extremely helpful in wrapping my mind further around new ideas in the realms of real-time and distributed data, key-value stores, etc. Many of us with roots in the RDBMS world are anxious about the new-and-different up-and-coming ways of "doing data." The "big picture" insights in this piece offer a conceptual framework that is both interesting and useful.

When I first started reading I was pretty intimidated by the technical level of the discussion. But please don't let that deter you from checking this out! The further you read into the piece the cooler it gets...

From this perspective, data is basically just data. And data models and specialized data systems are basically just different views and indexes on top of data. "Producer" and "consumer" systems can put data in log files and take them out, respectively, without knowing anything about the system of origin.

Those of us with relational database backgrounds can grasp all this from the standpoint of replication logs and how they work. Serving distributed systems makes replication asynchronous, but ideally you're still reading and writing in a standard format, without having to worry about what's going on on the "producer" end. The log can be the same for every system, with log data served by system-specific "serving nodes" within a "serving layer."

Probably my favorite analogy in this blog points out that the US Census is a good example of batch data collection. Why does it still work like that, with so much brute-force data gathering? Wouldn't it be easier to establish and keep a journal of births, deaths and relocations that could produce population counts in real-time?

Another thing I really like about this post are the author's thoughts on potential future directions. He posits three possibilities for the evolution of logs:

- A continuation of the status quo; that is, "the separation of systems remains more or less as it is for a good deal longer."
- A "reconsolidation" towards unifying "uber-systems" embodying greater generality, in which many of today's specialized data processing functions are merged.
- The ultimate unbundling of data infrastructure into a collection of services and application-facing APIs, not unlike the Java stack.

This reminds me of the history of cloud computing: how things start off at A and go to B and then "regress" back to A in a new light. In the days of the mainframe everything was offsite; then computing power was brought in-house for a variety of reasons; then it arched back out to the cloud again; and now it's being drawn back into private dedicated infrastructure (that is, organizations are moving back to having their own, dedicated hardware).

One way to look at it is that it's all about relinquishing control and then getting it back and then relinquishing it again in exchange for new capabilities and then getting control back again... What is central becomes distributed, and so it goes. Instead of having twenty different systems that need to be integrated, why not have one uber-system that does it all - especially if the data store can become generic enough to support all the different indexes and views that enterprises increasingly require?

As any technology progresses it gets easier and easier to setup. So if we stop focusing on a specific data storage technology and instead start offering a collection of commodity, black-box, building-block data services, then all we have to do is couple things together. So things might evolve that way.

But I don't think things are likely to stay as they are now for long. Many of us are intensely focused on setting up various individual, distributed technologies. I think largely this stems from the pain people are experiencing with traditional systems. As clear winners emerge among these distributed solutions, it's likely that they will become more and more generic and we can increasingly fall back on them to get the job done.

But don't take my word for it - read Jay's post and draw your own conclusions. Don't forget to watch Ren & Stimpy's "The Log Song" when you've reached the end.
