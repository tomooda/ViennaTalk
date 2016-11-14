*ViennaTalk-Value-Core
viennaStringOn: aStream
	aStream nextPutAll: 'mk_'.
	aStream nextPutAll: self class name.
	aStream nextPut: $(.
	(1 to: self class instSize)
		do: [ :index | self stringify: (self instVarAt: index) into: aStream ]
		separatedBy: [ aStream nextPut: $, ].
	aStream nextPut: $)