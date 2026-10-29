---
title: UPPAAL
weight: 10
---

UPPAAL can be executed from the command line using the following command on unix:

```shell
uppaal [OPTION] ... [FILENAME]
```

On windows, the following command can be used (for instance, using "Run" from the Start Menu):

```shell
java -jar /path/uppaal.jar [OPTION] ... [FILENAME]
```

where <tt>path</tt> is the complete path to the <tt>uppaal.jar</tt> file (it might also be necessary to specify the complete path to the <tt>java</tt> executable).

The optional filename refers to a model to be loaded at startup.

The available command line options are:

`--antialias on|off`
: (default `on`) turns antialiasing on or off in the automata rendering.

`--engineName [filename]`
: The name of verification server (default is `server` on Unix and `server.exe` on Windows) to be used by the GUI.

`--enginePath [path]`
: The path to the verification server (e.g. bin-Windows) to be used by the GUI.

`--help`
: Displays a summary of options.

`--serverHost [name]`
: Host name of remote machine running verification server.

`--serverPort [number]`
: Port number used by verification server on remote machine.

`--export templateName filename.ext`
: Export the named template to a graphics file. The graphics format is determined by the filename extension, and EPS will be used instead if format is not recognized. Use <tt>system</tt> keyword to export all templates where the filenames will be taken from the template name.

`--psColors on|off`
: Selects whether to export automata in color or greyscale EPS.

## Remote Engine

UPPAAL GUI can be configured to use the engine on a remote machine using Secure Shell ([`ssh`](https://man7.org/linux/man-pages/man1/ssh.1.html)).

This guide assumes:
 * The remote machine is called `bigpc` and a shell can be started using `ssh bigpc` without entering password.
   - Use [`ssh-keygen`](https://www.man7.org/linux/man-pages/man1/ssh-agent.1.html), [`ssh-copy-id`](https://man7.org/linux/man-pages/man1/ssh-copy-id.1.html), [`ssh-agent`](https://www.man7.org/linux/man-pages/man1/ssh-agent.1.html) and [`ssh-add`](https://man7.org/linux/man-pages/man1/ssh-add.1.html) to setup passwordless connection using ssh keys.
   - Add any extra settings to [`~/.ssh/config`](https://man7.org/linux/man-pages/man5/ssh_config.5.html) (`%USERPROFILE%/.ssh/config` on Windows) like `Hostname` (the real address), `User`, `IdentityFile`, `Port`, `ProxyJump`/`ProxyCommand`.
 * The remote machine has UPPAAL installed in `/opt/local/uppaal-5.0.0-linux64`.
 * The *locally installed* UPPAAL version **matches** the UPPAAL version installed on the *remote machine*.
   - Installations may differ in operating system and architecture, but the UPPAAL versions must match.
   - Mixed versions can work, but can also behave erratically and crash spectacularly.

Steps:
1. In UPPAAL menu choose `Edit` > `Engines` to invoke `Edit Engine Connections` dialog.
   - Click `Add Command`, observe a new entry of type "Command" added.
   - Type "UPPAAL-5.0.0 on bigpc" into `Title` field to identify this connection.
   - Type `ssh bigpc /opt/local/uppaal-5.0.0-linux64/bin/server.sh` into `Command` field.
   - Click `Save` to close the dialog.
2. Choose `Edit` > `Engine` > `UPPAAL-5.0.0 on bigpc`.
3. Choose `View` > `Reload` to reload the connection.
4. If everything was setup correctly the status bar at the bottom should show the version rather than an error.

GUI may prompt for license as the license information is managed on the engine server side.
