printing
vdmcStringOn: aStream
	aStream
		nextPutAll: 'mk_';
		nextPutAll: typeName;
		nextPut: $(.
	(1 to: self size) do: [ :index | (self at: index) printOn: aStream ] separatedBy: [ aStream nextPut: $, ].
	aStream nextPut: $)