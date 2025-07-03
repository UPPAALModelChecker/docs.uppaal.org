---
title: Socketserver
weight: 40
---

To start a remote server, use the `socketserver` binary (included for Linux, SunOS and MacOS). To use a remote server, see the section on [command line options](/toolsandapi/uppaal/) for the GUI.

The <tt>socketserver</tt> can be executed from the command line using one of the following commands:

```shell
socketserver [-p<P1>] [-s<P2>]
socketserver -h
```

The available command line options are:

`-h`
: Prints a brief description of the command line options.

`-p`
: Set port in server mode (default is `2350`).

`-s`
: Set filename of server binary to P2.

The `socketserver` will load the `server` from the directory where it was invoked, and act as a proxy.
