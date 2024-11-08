---
title: Edit Menu
weight: 20
---
The Edit menu offers a set of commands supported in the system editor. The items are:

  * **Undo:** reverses the most recent editing action. This function is only available in the editor.
  * **Redo:** re-applies the editing action that has most recently been reversed by the Undo action. This function is only available in the editor.
  * **Cut:** removes the selected text and places it in the clipboard. There must be an active text selection.
  * **Copy:** places a copy of the selected text in the clipboard. There must be an active text selection.
  * **Paste:** places text in the clipboard at the cursor location in the currently active editor. There must be text in the clipboard, and an editor must be active.
  * **Delete:** delete selected text. There must be an active text selection.
  * **Select all:** selects all text or all elements in the automaton.
  * **Find:** searches for the text occurances *locally* and *globally* (`Control`+`Shift`+`F`)
  * **Replace:** searches and replaces the text occurances *locally* and *globally* (`Control`+`Shift`+`R`)
  * **Insert Template:** adds a new empty template to the system description.
  * **Remove Template:** removes the currently selected template from the system description. There must be a template selected.
  * **Engine:** selects the engine to connect to:
    - `Bundled` is the `server` found in the UPPAAL installation directory (cannot be changed).
    - `Remote` is the `sockerserver` process accepting and relaying commands on a remote machine using TCP/IP protocol. See [socketserver](/toolsandapi/socketserver) for more details on how to launch it.

    Note that the GUI and server versions must match.
  * **Engines...** invokes an engine connection dialog to edit the engine selection in the **Engine** menu.
    The dialog allows to customize engine connections:
     - Address and port number for the remote connection.
     - Specific engine server commands, including remote server through `ssh`, e.g.:  `ssh bigmachine uppaal/bin/server`
