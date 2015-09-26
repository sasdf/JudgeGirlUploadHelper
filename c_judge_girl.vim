let g:JudgeGirlUploadHelperDir="~/JudgeGirlUploadHelper"

function JGLoadProblem(cid, pid)
    let l:dpm="silent exec \"! " . g:JudgeGirlUploadHelperDir . "/problem.sh " . a:cid . " " . a:pid . "\""
    execute l:dpm
    silent! wincmd l
    let l:pfn="12split " . g:JudgeGirlUploadHelperDir . "/Userdata/Problems/".a:cid."-".a:pid
    execute l:pfn
    set wfh
    redraw!
endfunction

function JGList(f)
    let l:ll="silent exec \"! " . g:JudgeGirlUploadHelperDir . "/list.sh " . a:f . "\""
    execute l:ll
    let l:vsp="topleft 40vsplit " . g:JudgeGirlUploadHelperDir . "/Userdata/list"
    execute l:vsp
    set wfw
    redraw!
endfunction

function JGSubmit()
    let l:sbt="! " . g:JudgeGirlUploadHelperDir . "/submit.sh %"
    execute l:sbt
endfunction

command -nargs=0 JGAllList :call JGList(0)
command -nargs=0 JGl :call JGList(0)
nnoremap <buffer> <F7> :JGl<CR>

command -nargs=0 JGUnpassedList :call JGList(1)
command -nargs=0 JGup :call JGList(1)
nnoremap <buffer> <F8> :JGup<CR>

command -nargs=* JGloadProblem :call JGLoadProblem(<f-args>)
command -nargs=* JGlp :call JGLoadProblem(<f-args>)

nnoremap <buffer> <F9> :w<CR>:call JGSubmit()<CR>
