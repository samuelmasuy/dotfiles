let g:terraform_fmt_on_save=1
let g:tf_fmt_autosave = 0
let g:nomad_fmt_autosave = 0
autocmd BufNewFile,BufRead *.hcl setf conf
autocmd BufNewFile,BufRead *.hcl setlocal expandtab shiftwidth=2 tabstop=2
