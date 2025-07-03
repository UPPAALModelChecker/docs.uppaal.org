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
java -jar \path\uppaal.jar [OPTION] ... [FILENAME]
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

