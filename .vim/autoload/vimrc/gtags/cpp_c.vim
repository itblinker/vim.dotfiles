"----------------------------------
let s:cpo_save = &cpo | set cpo&vim
"----------------------------------

function! vimrc#gtags#cpp_c#new(...)
    if a:0 == 0
        return s:indexerFactory(s:defaultConfiguration())
    elseif a:0 == 1
        return s:indexerFactory(a:1)
    else
        call vimrc#exception#throw("improper number of arguments")
    endif
endfunction


function! s:defaultConfiguration()
    let l:obj = { 'dbpath' : {},
                \ 'pathList' : {},
                \ 'filetypes' : {},
                \}

    function l:obj.dbpath.get()
        return vimrc#cache#instance().fetch().'/gtags/cpp_c'
    endfunction

    function l:obj.pathList.include()
        return [ getcwd() ]
    endfunction

    function l:obj.pathList.exclude()
        return [ '*test_module*' ]
    endfunction

    function l:obj.filetypes.list()
        return ['*.cpp', '*.hpp','*.c', '*.h', '*.cc', '*.hh', '*.cxx', '*.hxx']
    endfunction

    return l:obj
endfunction


function! s:indexerFactory(configuration)

    let l:obj =  extend(a:configuration, {
                \ 'formatter' : {},
                \ 'exclude' : { 'flag' : 1 }
                \})

    function! l:obj.filelist()
        return self.dbpath.get().'/files.list'
    endfunction

    function! l:obj.logfileFilelist()
        return self.dbpath.get().'/log.files.list'
    endfunction

    function! l:obj.logfileIndexing()
        return self.dbpath.get().'/logs.gtags.indexing'
    endfunction

    function! l:obj.logfileUpdating()
        return self.dbpath.get().'/logs.gtags.updating'
    endfunction


    function! l:obj.formatter.paths(pathList)
        return join(a:pathList, ' ')
    endfunction

    function! l:obj.formatter.name(filetypes)
        return '-iname '''.a:filetypes.''''
    endfunction

    function! l:obj.formatter.names(filetypesList)
        return join(map(deepcopy(a:filetypesList), 'self.name(v:val)'), ' -o ')
    endfunction

    function! l:obj.formatter.excludePath(path)
        return '! -ipath '''.a:path.''''
    endfunction

    function! l:obj.formatter.exclude(pathList)
        return join(map(deepcopy(a:pathList), 'self.excludePath(v:val)'), ' ')
    endfunction

    function! l:obj.findCmd(paths, filetypes, pathsToIgnore)
        return 'find '.self.formatter.paths(a:paths)
                    \.' -type f \( '.self.formatter.names(a:filetypes).' \) '
                    \.self.formatter.exclude(a:pathsToIgnore)
                    \.' > '.self.filelist()
                    \.' 2>'.self.logfileFilelist()
    endfunction


    function! l:obj.isDbPathAvailable()
        return isdirectory(self.dbpath.get())
    endfunction

    function! l:obj.createDbPath()
        call mkdir(self.dbpath.get(), 'p')
    endfunction

    function! l:obj.setEnvironment()
		let $GTAGSFORCECPP = ''
		let $GTAGSROOT = getcwd()
		let $GTAGSDBPATH = self.dbpath.get()
    endfunction

    function! l:obj.createListOfFiles()
        if self.exclude.flag == 1
            execute 'silent! Start! '.self.findCmd(self.pathList.include(), self.filetypes.list(), self.pathList.exclude())
        else
            execute 'silent! Start! '.self.findCmd(self.pathList.include(), self.filetypes.list(), [])
        endif
    endfunctio

    function! l:obj.makeListOfFilesToTag()
        if ! self.isDbPathAvailable()
            call self.createDbPath()
        endif

        call self.createListOfFiles()
    endfunction

    function! l:obj.performFullTag()
        execute 'silent! Start! gtags --file '.self.filelist().' '.self.dbpath.get()
            \  .' --verbose --warning --statistics > '.self.logfileIndexing().' 2>&1'
    endfunction

    function! l:obj.areTagsAvailable()
        return  filereadable(self.dbpath.get().'/GTAGS') &&
              \ filereadable(self.dbpath.get().'/GRTAGS') &&
              \ filereadable(self.dbpath.get().'/GPATH')
    endfunction()

    function! l:obj.isFileShouldBeTag()
        call system('global -f '.expand('%:p'))

        return !v:shell_error
    endfunction


    "-------------
    "[API] indexer
    "-------------

    function! l:obj.tag()
        call self.makeListOfFilesToTag()
        call self.setEnvironment()
        call self.performFullTag()
    endfunction


    function! l:obj.startup()
        if self.areTagsAvailable()
            call self.setEnvironment()
        endif
    endfunction


    function! l:obj.exclude.turnOn()
        let self.flag = 1
    endfunction


    function! l:obj.exclude.turnOff()
        let self.flag = 0
    endfunction

    return l:obj
endfunction

"---------------------------------------
let &cpo = s:cpo_save | unlet s:cpo_save
"---------------------------------------
