Extension { #name : #FileReference }

{ #category : #'*ViennaTalk-Engine-Pharo6' }
FileReference >> binaryWriteStream [
	^ filesystem binaryWriteStreamOn: self path
]
