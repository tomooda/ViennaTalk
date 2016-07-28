class initialization
install
	(FileSystem workingDirectory / 'codemirror') exists
		ifFalse: [ self installCodemirror ]