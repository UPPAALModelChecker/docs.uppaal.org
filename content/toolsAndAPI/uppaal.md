---
title: UPPAAL
weight: 10
---

UPPAAL can be executed from the command line using the following command on unix:

> <tt>uppaal [OPTION] ... [FILENAME]</tt>

On windows, the following command can be used (for instance, using "Run" from the Start Menu):

> <tt>java -jar \path\uppaal.jar [OPTION] ... [FILENAME]</tt>

where <tt>path</tt> is the complete path to the <tt>uppaal.jar</tt> file (it might also be necessary to specify the complete path to the <tt>java</tt> executable).

The optional filename refers to a model to be loaded at startup.

The available command line options are:

<dl>

<dt><tt>--antialias on|off</tt></dt>

<dd>(default <tt>on</tt>) turns antialiasing on or off in the automata rendering.</dd>

<dt><tt>--engineName <filename></tt></dt>

<dd>The name of verification server (default is <tt>server</tt> on Unix and <tt>server.exe</tt> on Windows) to be used by the GUI.</dd>

<dt><tt>--enginePath <path></tt></dt>

<dd>The path to the verification server (e.g. bin-Windows) to be used by the GUI.</dd>

<dt><tt>--help</tt></dt>

<dd>Displays a summary of options.</dd>

<dt><tt>--serverHost <name></tt></dt>

<dd>Host name of remote machine running verification server.</dd>

<dt><tt>--serverPort <no></tt></dt>

<dd>Port number used by verification server on remote machine.</dd>

<dt><tt>--export templateName filename.ext</tt></dt>

<dd>Export the named template to a graphics file. The graphics format is determined by the filename extension, and EPS will be used instead if format is not recognized. Use <tt>system</tt> keyword to export all templates where the filenames will be taken from the template name.</dd>

<dt><tt>--psColors on|off</tt></dt>

<dd>Selects whether to export automata in color or greyscale EPS.</dd>

</dl>
