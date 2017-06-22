*ViennaTalk-Parser-Code Generators
, aString
	^ aString isViennaTracingString
		ifTrue: [ self asViennaTracingString , aString ]
		ifFalse: [ super , aString ]