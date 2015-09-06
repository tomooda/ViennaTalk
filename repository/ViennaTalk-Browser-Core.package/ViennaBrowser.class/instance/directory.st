private
directory
	^ directory ifNil: [ directory := FileSystem workingDirectory parent parent parent ]