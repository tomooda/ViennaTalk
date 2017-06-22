code generation-expressions
mapComprehension: aViennaNode env: aDictionary
	| keyExpr valueExpr bindListNode guard varGenerator map pair flatBinds setsAndVars |
	keyExpr := self generate: aViennaNode first env: aDictionary.
	valueExpr := self generate: aViennaNode second env: aDictionary.
	bindListNode := aViennaNode third.
	guard := self generate: aViennaNode fourth env: aDictionary.
	varGenerator := self
		varNameGenerator: 'map'
		uniqueIn:
			{keyExpr.
			valueExpr} , {(guard ifNil: [ '' ])}.
	map := varGenerator value.
	pair := self
		flattenBindList: bindListNode
		varGenerator: varGenerator
		env: aDictionary.
	flatBinds := pair first.
	setsAndVars := pair second.
	^ self
		stringStreamContents: [ :stream | 
			| body |
			body := map , ' at: ' , keyExpr , ' put: ' , valueExpr.
			guard ifNotNil: [ body := guard , ' ifTrue: [' , body , ']' ].
			stream nextPutAll: '(['.
			setsAndVars
				do: [ :setAndVar | 
					stream
						nextPutAll: ' :';
						nextPutAll: setAndVar second ].
			stream
				nextPutAll: ' | | ' , map , ' | ' , map , ' :=Dictionary new.';
				nextPutAll:
					(self
						generatorFromFlatBinds: flatBinds
						body: body
						varGenerator: varGenerator
						env: aDictionary);
				nextPutAll: '. ';
				nextPutAll: map;
				nextPutAll: ']'.
			setsAndVars
				do: [ :setAndVar | 
					stream
						nextPutAll: ' value: ';
						nextPutAll: setAndVar first ].
			stream nextPut: $) ]