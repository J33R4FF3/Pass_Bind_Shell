# Pass_Bind_Shell

Pass_Bind_Shell will spawn a simple simple bind shell on the victim and will require a password to connect to the bind shell. Connecting to the shell will not prompt for a password but it should be the first argument sent over the connection before continuing with any further commands. Note that providing an incorrect password will exit the bind shell. There is also no error handling in place.

The desired shell, port and password can be configured withing the arguments array.

## Compile

```bash
gcc Pass_Bind_Shell.c -o Filename
```
