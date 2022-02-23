Extension { #name : #WideString }

{ #category : #'*ViennaTalk-Engine-Core' }
WideString >> tfPointerAddress [

	^ (self encodeWith: OSEnvironment current defaultEncoding)
		  tfPointerAddress
]
