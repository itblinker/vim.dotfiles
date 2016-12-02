"----------------------------------
let s:cpo_save = &cpo | set cpo&vim
"----------------------------------

"
" API
"
function! vimrc#gtags#cpp#indexer#new(...)
    if a:0 == 0
        return s:indexerFactory(vimrc#gtags#cpp#config#factory())
    elseif a:0 == 1
        return s:indexerFactory(a:1)
    else
        call vimrc#exception#throw("improper number of arguments")
    endif
endfunction
"

function! s:indexerFactory(configuration)
    let l:obj = extend({}, {'configuration' : a:configuration})

    function! l:obj.fileslist()
        return self.configuration.dbpath().'/files.list'
    endfunction

    function! l:obj.logfileslist()
        return self.configuration.dbpath().'/log.files.list'
    endfunction

    function! l:obj.logfileIndexing()
        return self.configuration.dbpath().'/logs.gtags.indexing'
    endfunction


    function! l:obj.createFileListCommand()
        return vimrc#find#instance().cmd(self.configuration.findParameters())
               \.' > '.self.fileslist().' 2> '
               \.self.logfileslist()
    endfunction


    function! l:obj.fullTagCommand()
        return 'gtags --file '.self.fileslist().' '.self.configuration.dbpath()
               \.' --verbose --warning --statistics > '.self.logfileIndexing().' 2>&1'
    endfunction


    function! l:obj.isDbPathAvailable()
        return isdirectory(self.configuration.dbpath())
    endfunction

    function! l:obj.createDbPath()
        call mkdir(self.configuration.dbpath(), 'p')
    endfunction


    function! l:obj.updatePaths()
        if !self.isDbPathAvailable()
            call self.createDbPath()
        endif
    endfunction


    function! l:obj.setEnvironment()
		let $GTAGSFORCECPP = ''
		let $GTAGSROOT = getcwd()
		let $GTAGSDBPATH = self.configuration.dbpath()
    endfunction

    function! l:obj.updateEnvironment()
		let $GTAGSROOT = getcwd()
		let $GTAGSDBPATH = self.configuration.dbpath()
    endfunction

    function! l:obj.execute(...)
        for item in a:000
            silent call dispatch#start_command(1, item)
        endfor

        redraw!
    endfunction

    "
    " API
    "
    function! l:obj.tag()
        call self.updatePaths()
        call self.execute(self.createFileListCommand(), self.fullTagCommand())
        call self.setEnvironment()
    endfunction


    function! l:obj.filetype_autocmd()
        call self.updateEnvironment()
    endfunction

    return l:obj
endfunction


"
" TEST
"
"let s:instance = vimrc#gtags#cpp#indexer#new()
"call s:instance.tag()
"call s:instance.filetype_autocmd()

"---------------------------------------
let &cpo = s:cpo_save | unlet s:cpo_save
"---------------------------------------
