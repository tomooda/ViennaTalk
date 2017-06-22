code generation-statements
trapStatement: aViennaNode env: aDictionary
	| matchVars pattern handler statement |
	matchVars := (self boundVariables: aViennaNode first) asArray.
	pattern := self generate: aViennaNode first env: aDictionary.
	handler := self generate: aViennaNode second env: aDictionary.
	statement := self generate: aViennaNode third env: aDictionary.
	^ self
		stringStreamContents: [ :stream | 
			stream
				nextPutAll: '(ViennaException trap: ';
				nextPutAll: pattern;
				nextPutAll: ' with: [:trap |'.
			matchVars
				ifNotEmpty: [ stream nextPutAll: ' | '.
					matchVars
						do: [ :var | 
							stream
								nextPutAll: var;
								space ].
					stream nextPutAll: '| ' ].
			stream
				nextPutAll:
					'trap ifEmpty: [ViennaNoMatch signal] ifNotEmpty: [ | with | with := trap first.'.
			matchVars
				do: [ :var | 
					stream
						nextPutAll: var;
						nextPutAll: ' := with at: ';
						nextPutAll: var storeString;
						nextPutAll: ' ifAbsent: [ViennaNoMatch signal]. ' ].
			stream
				nextPutAll: handler;
				nextPutAll: ']] in: [';
				nextPutAll: statement;
				nextPutAll: '])' ]