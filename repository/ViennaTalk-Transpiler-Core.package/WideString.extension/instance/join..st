*ViennaTalk-Transpiler-Core
join: aCollection
	^ (aCollection anySatisfy: #isViennaTracingString)
		ifTrue: [ self asViennaTracingString join: aCollection ]
		ifFalse: [ super join: aCollection ]