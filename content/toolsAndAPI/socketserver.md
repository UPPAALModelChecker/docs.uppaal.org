---
title: Socketserver
weight: 40
---

To start a remote server, use the `socketserver` binary (included for Linux, SunOS and MacOS). To use a remote server, see the section on [command line options](/toolsandapi/uppaal/) for the GUI.

The <tt>socketserver</tt> can be executed from the command line using one of the following commands:

> <tt>socketserver [-p<P1>] [-s<P2>]</tt>  
> <tt>socketserver -h</tt>

The available command line options are:

<dl>

<dt><tt>-h</tt></dt>

<dd>Prints a brief description of the command line options.</dd>

<dt><tt>-p</tt></dt>

<dd>Set port in server mode (default is 2350).</dd>

<dt><tt>-s</tt></dt>

<dd>Set filename of server binary to P2.</dd>

</dl>

The <tt>socketserver</tt> will load the <tt>server</tt> from the directory where it was invoked, and act as a proxy.