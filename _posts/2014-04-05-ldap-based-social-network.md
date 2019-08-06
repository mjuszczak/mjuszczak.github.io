---
title: "An LDAP-Based Social Network"
date: 2014-04-05
---

I've often thought about what decentralized and distributed social networks would look like. I know that services and protocols like [Diaspora](https://diasporafoundation.org/), [OAuth](http://en.wikipedia.org/wiki/OAuth), [OpenID](http://en.wikipedia.org/wiki/OpenID), and [XMPP (Jabber)](http://en.wikipedia.org/wiki/XMPP) technically live in this space, but let's pretend for a second that good old [OpenLDAP](http://www.openldap.org/) would actually scale as a distributed social platform. After all, it's already used for directory services worldwide, is often overlooked as one of the first well-known key->value datastores, and has a distributed hierarchical architecture, so why not explore the idea? Just for fun. Oh, and let's also ignore the fact that a social network has to reach critical mass to be successful, and there's not really an easy way to monetize distributed social networks. Seriously. Just pretend.

OpenLDAP is an implementation of the LDAP **(Lightweight Directory Access Protocol)** protocol. For the sake of this blog post, I'm not going to go into too many LDAP technical details, other than that LDAP allows data to be stored hierarchically in key->value form. Let's make an analogy: a tree trunk, numerous branches, twigs, and leaves. Each and every leaf can have numerous attributes attached to it, such as color, size, and shape. Let's take a look at a super-simplified sample LDAP tree. For the record, I've left out some metadata and such, so this **won't actually work if you try to use it.**

    dn: cn=matt,ou=people,dc=example,dc=com
    cn: matt
    gender: male
    birthday: 09/12/1983
    hobby: running
    hobby: hiking
    hobby: camping

    dn: ou=people,dc=example,dc=com
    ou: people

    dn: dc=example,dc=com
    dc: example

So what's going on here? Well, we've essentially created an LDAP tree:

- example.com
  - people
    - matt

... with *example.com* a branch, *people* a twig off of that branch, and *matt* as a leaf attached to that twig. In this case, that leaf has multiple properties: my birthday is September 12th, 1983, and I'm a male. I enjoy hiking, camping, and running. Think about how many other things I could store!

In this case, *example.com* is a branch, NOT a trunk. That's because if someone was looking for a record in another domain, an LDAP "subtree" can send that request upstream and have the request redirected to another location where the data is actually stored. Sound familiar? I bet it does if you're familiar with how the [Domain Name System (DNS)](http://en.wikipedia.org/wiki/Domain_Name_System) works.

So we've established two things: an LDAP tree is hierarchical, as in *I don't have what you're looking for, let me send you up the other branches until we find what you're looking for,* and you can store descriptive attributes about a "leaf", as in *name, birthday, gender, likes, dislikes, relationship status, and even a list of friends.*

So in the dream-world of an LDAP-based social network, there'd be a number of LDAP clusters sitting out there on the Internet. Folks would sign up at one of these highly available LDAP services and have a profile created that they could manage, which would contain their directory information as well as their "connections". For instance, example.com would run with records like:

    dn: uid=matt,ou=users,ou=link,ou=example,dc=com
    uid: matt
    gender: male
    hobby: running
    hobby: camping
    hobby: hiking
    connection: uid=mike,ou=users,ou=link,ou=example,dc=com
    connection: uid=john,ou=users,ou=link,ou=example,dc=com
    connection: uid=sue,ou=users,ou=link,ou=example,dc=com
    connection: uid=rob,ou=users,ou=link,ou=atopia,dc=net
    connection: uid=mark,ou=users,ou=link,ou=atopia,dc=net

In that example, I'd be "friends" with three local users, and two users on the atopia.net domain. Hey, this already looks an awful lot like how some corporate directories are setup today, right? Read on. On another note, I'm running out of sample domain names to use.

*Security* would be pretty important in a setup like this. [GPG](http://www.gnupg.org/) could be used to store encrypted data inside each LDAP record. At the most basic level, that data could be encoded only for "connections" that should have access to that data. The private keys would likely be stored within each user's LDAP record in a private attribute, so one would have to trust their own chosen LDAP provider. My LDAP provider could reach out to a friend's LDAP provider at any time, perhaps when I'm trying to access the data of those in my network, and decrypt the private data only meant for me. As for search, a centralized LDAP provider could host key->DN maps, so folks could perform searches by email address and/or some other key and find out the location of that user's data.

Realistically, there's a lot of challenges to this idea and it probably wouldn't work. However, LDAP was built to be a distributed directory service in its most basic form, and it'd be quite interesting to somehow power social interaction with it. If you find it hard to believe, consider it an overdue April fools joke. :)
