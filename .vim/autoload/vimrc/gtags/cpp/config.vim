"----------------------------------
let s:cpo_save = &cpo | set cpo&vim
"----------------------------------

"
" API
"
function! vimrc#gtags#cpp#config#factory()
    return s:configurationFactory()
endfunction
"

let s:toml_lib  = vital#vimrc#new().import('Text.TOML')

function! s:configurationFactory()
    let l:obj = {}

    function! l:obj.tomlProjectConfigFile()
        return self.dbpath().'/indexerConfig.toml'
    endfunction

    function! l:obj.initTomlProjectConfigFile(tomlFile)
        try
            if !isdirectory(fnamemodify(a:tomlFile, ':p:h'))
                call mkdir(fnamemodify(a:tomlFile, ':p:h'), 'p')
            endif

            let l:lib = vital#vimrc#new().import('Vim.Buffer')
            call l:lib.open(a:tomlFile, 'split')
            call l:lib.edit_content(
                                    \ [
                                    \ '#',
                                    \ '[[find]]',
                                    \ '  path = "./"',
                                    \ '  names   = []',
                                    \ '  inames  = ['.vimrc#cpp#manager#instance().extensions_format_toml().']',
                                    \ '  [find.exclude]',
                                    \ '    paths = []',
                                    \ '  [find.exclude.dir]',
                                    \ '    patterns  = []',
                                    \ '    ipatterns = ["test_modules", "test_module"]',
                                    \ '  [find.exclude.file]',
                                    \ '    patterns  = []',
                                    \ '    ipatterns = []',
                                    \ '#'
                                    \])
            silent write | bwipe
            filetype detect
        catch
            call vimrc#exception#throw('cannot create toml config for gtag cpp indexer')
        endtry
    endfunction

    function! l:obj.editTomlProjectConfigFile(tomlFile)
        execute 'edit '.self.tomlProjectConfigFile()
    endfunction


    function! l:obj.setupTomlConfFile()
        if !filereadable(self.tomlProjectConfigFile())
            call self.initTomlProjectConfigFile(self.tomlProjectConfigFile())

            if confirm("<gtags-cpp-indexer> created | edit config?: ", "&Yes\n&No", 1) == 1
                call self.editTomlProjectConfigFile(self.tomlProjectConfigFile())
            endif

        endif
    endfunction

    "
    " API
    "
    function! l:obj.dbpath()
        return vimrc#cache#instance().fetch().'/gtags/cpp'
    endfunction
    "

    function! l:obj.findParameters()
        return s:toml_lib.parse_file(self.tomlProjectConfigFile()).find
    endfunction

    "
    " constructor
    "
    call l:obj.setupTomlConfFile()
    "

    return l:obj
endfunction

"---------------------------------------
" TEST
"
"let s:config = vimrc#gtags#cpp#config#factory()
"---------------------------------------

"---------------------------------------
let &cpo = s:cpo_save | unlet s:cpo_save
"---------------------------------------
