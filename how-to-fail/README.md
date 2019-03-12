this directory contains the function `ERR` showcased in the video:  
# [HOW TO SUCCESSFULLY FAIL [bash][dunst]](https://youtu.be/yKFEpv6Wlao)  

recommended reading:  

http://wiki.bash-hackers.org/howto/redirection_tutorial  

https://stackoverflow.com/a/23550347  
```
>&2 echo "error" The operator >&2 literally
means redirect the address of file descriptor 1
(stdout) to the address of file descriptor 2
(stderr) for that command1. Depending on how
deeply you want to understand it, read this:

To avoid interaction with other redirections use subshell

(>&2 echo "error")
```


https://stackoverflow.com/a/4332530  
`tput` commands to change colors and appearance of terminal output.  

https://unix.stackexchange.com/a/389498
the mysterious test `[ -t 1 ]` , that let us know if a script is executed from a terminal or not.
