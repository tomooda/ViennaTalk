private
directory
	^ directory ifNil: [ directory := FileSystem root parent ]