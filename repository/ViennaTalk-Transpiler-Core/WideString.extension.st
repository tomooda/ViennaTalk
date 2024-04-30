Extension { #name : 'WideString' }

{ #category : '*ViennaTalk-Transpiler-Core' }
WideString >> join: aCollection [
	^ (aCollection anySatisfy: #isViennaTracingString)
		ifTrue: [ self asViennaTracingString join: aCollection ]
		ifFalse: [ super join: aCollection ]
]
