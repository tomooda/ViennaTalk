Extension { #name : #WideString }

{ #category : #'*ViennaTalk-Parser-Code Generators' }
WideString >> join: aCollection [
	^ (aCollection anySatisfy: #isViennaTracingString)
		ifTrue: [ self asViennaTracingString join: aCollection ]
		ifFalse: [ super join: aCollection ]
]
