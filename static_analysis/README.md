Introduction
"You cannot defend what you do not understand. Static analysis is the art of understanding a program without ever running it and that changes everything."

Every piece of malware, every compiled exploit, every suspicious binary that arrives in a security investigation is just a file. Static analysis is the discipline of reading that file - its structure, its strings, its assembly code, its imports and extracting meaning before a single instruction executes.

In practice this matters in three critical scenarios. In malware analysis, you cannot safely run an unknown binary, so you must understand it statically first. In security auditing, you may not have source code but still need to verify behavior. In CTF challenges, exactly what this module's tasks simulate - the flag is always hidden somewhere in the binary, and the only way to find it is to read what the compiler left behind.

Tools like Ghidra, Radare2, and IDA Pro exist because disassembly and decompilation turn incomprehensible machine code into something a human can reason about. This module teaches that fundamental skill and connects directly to every security topic involving binaries, exploits, or malware.

