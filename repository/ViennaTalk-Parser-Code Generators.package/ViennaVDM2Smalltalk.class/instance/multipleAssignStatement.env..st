code generation-statements
multipleAssignStatement: aViennaNode env: aDictionary
	| assigns |
	assigns := aViennaNode
		collect: [ :assign | 
			{(self generate: assign first env: aDictionary).
			(self generate: assign second env: aDictionary)} ].
	^ assigns size < 2
		ifTrue: [ PPFailure message: 'atom statement should have more than one statements' ]
		ifFalse: [ 
			| varGenerator tmps |
			varGenerator := self varNameGenerator: 'atom' uniqueIn: (assigns collect: #second).
			tmps := assigns collect: [ :assign | varGenerator value ].
			String
				new: 1024
				streamContents: [ :stream | 
					stream nextPutAll: '[| '.
					tmps
						do: [ :tmp | 
							stream
								nextPutAll: tmp;
								nextPutAll: ' ' ].
					stream nextPutAll: '| '.
					tmps
						with: assigns
						do: [ :tmp :assign | 
							stream
								nextPutAll: tmp;
								nextPutAll: ' := ';
								nextPutAll: assign second;
								nextPutAll: ' . ' ].
					tmps
						with: assigns
						do: [ :tmp :assign | 
							| desig |
							desig := assign first.
							desig isString
								ifTrue: [ 
									stream
										nextPutAll: desig;
										nextPutAll: ' := ';
										nextPutAll: tmp;
										nextPutAll: '. ' ]
								ifFalse: [ 
									| ident path |
									ident := desig first.
									path := desig second.
									stream
										nextPutAll: ident;
										nextPutAll: ' := ';
										nextPutAll: ident;
										nextPutAll: ' copyAtPath: {';
										nextPutAll: (' . ' join: path);
										nextPutAll: '} put: ';
										nextPutAll: tmp;
										nextPutAll: '. ' ] ].
					stream nextPutAll: '] value' ] ]