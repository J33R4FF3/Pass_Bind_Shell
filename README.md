# Pass_Bind_Shell

Pass_Bind_Shell is for use on Linux and will spawn a simple bind shell on the victim and will require a password to connect to the bind shell. Connecting to the shell will not prompt for a password but it should be the first argument sent over the connection before continuing with any further commands. Note that providing an incorrect password will exit the bind shell. There is also no error handling in place.

The desired shell, port and password can be configured within the arguments array.

For more information on the inner workings of the code, please read the blog [here](https://j33r4ff3.github.io/blog/Creating-TCP-Bind-Shell-with-C).

## Compile

```bash
gcc Pass_Bind_Shell.c -o Filename
```
or
```bash
nasm -felf64 Pass_Bind_Shell.nasm -o ObjectFile_Filename.o
ld ObjectFile_Filename.o -o Executable_Filename
```
