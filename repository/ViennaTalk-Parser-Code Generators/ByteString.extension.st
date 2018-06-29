Extension { #name : #ByteString }

{ #category : #'*ViennaTalk-Parser-Code Generators' }
ByteString >> join: aCollection [
	^ (aCollection anySatisfy: #isViennaTracingString)
		ifTrue: [ self asViennaTracingString join: aCollection ]
		ifFalse: [ super join: aCollection ]
]
