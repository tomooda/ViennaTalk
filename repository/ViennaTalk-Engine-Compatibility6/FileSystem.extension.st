Extension { #name : #FileSystem }

{ #category : #'*ViennaTalk-Engine-Compatibility6' }
FileSystem >> binaryWriteStreamOn: aResolvable [
	"Resolve the argument into an absolute path and open a file handle on the file
	at that path. Ask the handle to give us a read stream for reading the file."

	^ (self open: aResolvable writable: true) binaryReadStream.
]
