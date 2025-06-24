---
title: Socketserver
weight: 40
---

To start a remote server, use the `socketserver` binary (included for Linux, macOS, SunOS).
To use the remote server, see the section on [Edit > Engine](/gui-reference/menu-bar/edit/) for the GUI.

The `socketserver` can be run from the command line on a remote machine using one of the following commands:

```
Synopsis:
  socketserver [-n] [-p<P1>] [command]...
  socketserver -h
  h : Print this help screen
  n : Run in native mode
  p : Set port in server mode (default is 2350)
  d : Write communication to debug files in current directory
  m : Write communication standard out
  [commmand] : A series of argv to execute as the server command
```

The available command line options are:

`-h`
: Prints a brief description of the command line options.

`-p`
: Sets TCP/IP server port to listen to (default is 2350).

`-d`
: write the engine communication to debug files in the current directory (useful in debugging).

`-m`
: write the engine communication to standard output (usefull in debugging).

The `socketserver` runs the `server` from the directory where it was invoked, and acts as a proxy on TCP/IP port.
