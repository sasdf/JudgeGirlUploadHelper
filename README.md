# Judge Girl Upload Helper
Command Line script for compiling, running, and uploading code to judgegirl server.

## Requirement
- curl
- Shell (eg. bash)

## Usage
- jguh.sh code.c

## Installation
- Just place the script wherever you want, and don't forget to add the execute permission flag.

- Note. After Execution, the script will create 3 files(judgeGirlCookies, judgeGirlCid, judgeGirlPid) at same directory of the script to store userdata. It is highly recommend to make a new directory and move the script into it.

## CID? PID?
- The URL of judgegirl problem's page is: http://judgegirl.csie.org/problem/(cid)/(pid)

- For example, The URL of first problem on judgegirl is "http://judgegirl.csie.org/problem/0/3".It means the cid of this problem is 0, and the pid is 3.

## Logout
- Delete the file "judgeGirlCookies" at same directory of the script.

## Vim Integration
###~/.vimrc (Create one if not exists)
- filetype plugin on

###~/.vim/ftplugin/c/c_judge_girl.vim (Create one if not exists)
- nnoremap \<buffer\> key :w\<CR\>:! DirToScript/jguh.sh %\<CR\>

For example:
- nnoremap \<buffer\> \<F9\> :w\<CR\>:! ~/JudgeGirlUploadHelper/jguh.sh %\<CR\>

Press the key you define(which is F9 in above example) in normal mode of vim and enjoy it~~

## Sublime Integration
