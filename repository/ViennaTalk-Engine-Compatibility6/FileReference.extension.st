Extension { #name : #FileReference }

{ #category : #'*ViennaTalk-Engine-Compatibility6' }
FileReference >> binaryWriteStream [
	^ filesystem binaryWriteStreamOn: self path
]
