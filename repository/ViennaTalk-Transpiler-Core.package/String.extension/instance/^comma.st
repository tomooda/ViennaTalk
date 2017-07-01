*ViennaTalk-Transpiler-Core
, aString
	^ aString isViennaTracingString
		ifTrue: [ self asViennaTracingString , aString ]
		ifFalse: [ super , aString ]