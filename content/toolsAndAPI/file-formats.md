---
title: File Formats
weight: 50
---

UPPAAL supports three file formats for models: XML, XTA and TA. XML and XTA files can be loaded and stored via the **Open Project**, **Open System**, **Save System**, and **Save System As** menus. When saving a file, the file type is determined by the file name extension used. Each format is explained in more details below.

Notice that the above mentioned file formats are mostly independent from the type of changes made to the syntax between UPPAAL 3.4 and UPPAAL 4.0.

In additon to the file formats for models, UPPAAL uses clear text query files for storing queries and the XTR file format for storing traces.

## XML

The newest format is XML based and files in this format have the ending <tt>.xml</tt>. This format supports all features of UPPAAL. Elements like templates, locations, edges and labels are described using _tags_. This format was introduced in the GUI in version 3.2\. As of version 3.4, the XML format is also supported by the verification engine. The GUI uses this format as its native file format. The addition of colors and notes on labels and edges, and the select expresssion on edges in UPPAAL 4.0 has resulted in the addition of a color attribute and two new label types. If these features are not used, the XML files generated by UPPAAL 4.0 are readable by UPPAAL 3.4.

The level of abstraction in the format is chosen so that the format is independent of the actual syntax of declarations, invariants, guards, etc. Thus all labels are simply treated as strings without structure. In a GUI, this is very important, since the user might enter arbitrary text into the label fields and the file format must be able to cope with this situation. Before the introduction of the XML format, the XTA format was used. With this format it was not possible to save syntactically incorrect systems, i.e., if the user made a mistake in the syntax of a label it was not possible to save this systems.

## XTA

The XTA format was introduced in version 3.0\. This format can only reliably store syntactically correct systems. Anonymous locations are not supported by this format (UPPAAL automatically assigns a unique name to anonymous locations when saved to an XTA file). Graphical information (coordinates) about the objects are stored in a separate UGI file, although this is transparent to the user. XTA files use the ending <tt>.xta</tt> and UGI files the ending <tt>.ugi</tt>.

In UPPAAL 4.0, the XTA format was extended with support for the select expression on edges. The UGI format was extended with support for the color attributes. If these features are not used, the XTA files generated by UPPAAL 4.0 are readable by UPPAAL 3.4.

## TA

The TA format is a subset of the XTA format and does not support the template concept nor does it contain any graphical information about the system. UPPAAL can no longer save files in this format, although TA files can still be read.

## Query files

Query files use a clear-text format listing all queries inleaved with comments. The format dates back to UPPAAL 2\. Files in this format have the file ending <tt>.q</tt>.

## Trace files

Traces can be stored using the XTR format and files in this format have the file ending <tt>.xtr</tt>. The format was introduced in UPPAAL 3.0.

XTR files are intimately linked to the model from which they were generated. Any change (other than layout and white space changes) in the model may render the trace file unreadable. Even reordering some variable declarations will break the link.

Our parser library, libutap, contains a small utility called <tt>tracer</tt>, which can read XTR files and translate them to a human readable format. The library and the utility are released under the LGPL license and may thus be used as a starting point for writing custom trace analysis tools. More information about the library can be found on the UPPAAL web page.