# Judge Girl Upload Helper
Command Line script for compiling, running, and uploading code to judgegirl server.

## Requirement
- curl
- Shell (eg. bash)
- perl

## Usage
```
problem.sh cid pid   # print problem's description.
list.sh 0            # Show all problems' list.
list.sh 1            # Show unpassed problems' list.
submit.sh code.c     # Compile, test, and Submit your code.
```

## CID? PID?
- The URL of judgegirl problem's page is: http://judgegirl.csie.org/problem/(cid)/(pid)

- For example, The URL of first problem on judgegirl is "http://judgegirl.csie.org/problem/0/3".It means the cid of this problem is 0, and the pid is 3.

## Logout
- Delete the file "judgeGirlCookies" at Userdata directory.

## Vim Integration
Append following line to ~/.vimrc
- `filetype plugin on`

move c_judge_girl.vim to ~/.vim/ftplugin/c/
- change the variable `g:JudgeGirlUploadHelperDir` to the directory the scripts located.

Usage
- Press F7 to show the list of all problems. 
- Press F8 to show the list of unpassed problems. 
- Press F9 to test & submit your code.

## Sublime Integration
