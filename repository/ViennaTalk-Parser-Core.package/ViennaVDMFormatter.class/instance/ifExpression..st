formatting-expressions
ifExpression: aViennaNode
	| cond expr default |
	cond := self format: aViennaNode first first first.
	expr := self format: aViennaNode first first second.
	default := self format: aViennaNode second.
	(aViennaNode first size = 1 and: [ (self needsIndent: cond , expr , default) not ])
		ifTrue: [ ^ 'if ' , cond , ' then ' , expr , ' else ' , default ].
	^ String
		new: 1024
		streamContents: [ :stream | 
			stream nextPutAll: 'if'.
			(self needsIndent: cond)
				ifTrue: [ 
					stream
						nextPut: Character cr;
						nextPutAll: indent , (self indentString: cond) ]
				ifFalse: [ 
					stream
						nextPut: Character space;
						nextPutAll: cond ].
			stream
				nextPutAll: ' then';
				nextPut: Character cr;
				nextPutAll: indent;
				nextPutAll: (self indentString: expr).
			2 to: aViennaNode first size do: [ :index | 
				cond := self format: (aViennaNode first at: index) first.
				expr := self format: (aViennaNode first at: index) second.
				stream
					nextPut: Character cr;
					nextPutAll: 'elseif'.
				(self needsIndent: cond)
					ifTrue: [ 
						stream
							nextPut: Character cr;
							nextPutAll: indent , (self indentString: cond) ]
					ifFalse: [ 
						stream
							nextPut: Character space;
							nextPutAll: cond ].
				stream
					nextPutAll: ' then';
					nextPut: Character cr;
					nextPutAll: indent;
					nextPutAll: (self indentString: expr) ].
			stream
				nextPut: Character cr;
				nextPutAll: 'else';
				nextPut: Character cr;
				nextPutAll: indent , (self indentString: default) ]