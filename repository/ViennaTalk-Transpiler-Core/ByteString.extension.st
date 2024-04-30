Extension { #name : 'ByteString' }

{ #category : '*ViennaTalk-Transpiler-Core' }
ByteString >> join: aCollection [
	^ (aCollection anySatisfy: #isViennaTracingString)
		ifTrue: [ self asViennaTracingString join: aCollection ]
		ifFalse: [ super join: aCollection ]
]
