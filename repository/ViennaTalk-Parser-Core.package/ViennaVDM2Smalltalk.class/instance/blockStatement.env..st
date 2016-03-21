code generation-statements
blockStatement: aViennaNode env: aDictionary
	| statements vars |
	statements := OrderedCollection new: aViennaNode size.
	vars := Set new.
	aViennaNode do: [:statement | statement label = 'DclStatement' ifTrue:[self boundVariables: statement into: vars]].
	aViennaNode do: [ :node | (self generate: node env: aDictionary) ifNotNil: [ :statement | statements add: statement ] ].
	^ String
		new: 1024
		streamContents: [ :stream | 
			vars
				ifNotEmpty: [ 
					stream nextPutAll: '[| '.
					vars
						do: [ :var | 
							stream
								nextPutAll: var;
								nextPut: Character space ].
					stream nextPutAll: '| ' ].
			stream nextPutAll: ('.' join: statements).
			vars ifNotEmpty: [ stream nextPutAll: '] value.' ] ]