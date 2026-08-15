savedcmd_8188eu.o := x86_64-linux-gnu-ld -m elf_x86_64 -z noexecstack --no-warn-rwx-segments --strip-debug  -r -o 8188eu.o @8188eu.mod  ; /usr/src/linux-headers-6.18.12+kali-amd64/tools/objtool/objtool --hacks=jump_label --hacks=noinstr --hacks=skylake --ibt --orc --retpoline --rethunk --sls --static-call --uaccess --prefix=16  --link  --module 8188eu.o

8188eu.o: $(wildcard /usr/src/linux-headers-6.18.12+kali-amd64/tools/objtool/objtool)
