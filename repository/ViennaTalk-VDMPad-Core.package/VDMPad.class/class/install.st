class initialization
install
	(FileSystem / 'codemirror') exists ifFalse: [ self installCodemirror ]