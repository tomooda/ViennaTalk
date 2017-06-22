code generation-statements
setForLoop: aViennaNode env: aDictionary
	| pat setExpr body vars varGenerator |
	pat := self generate: aViennaNode first env: aDictionary.
	body := self generate: aViennaNode third env: aDictionary.
	(aViennaNode first label = 'PatternIdentifier'
		and: [ aViennaNode second label = 'FinitePowerSet' ])
		ifTrue: [ ^ (self generate: aViennaNode second first env: aDictionary)
				, ' powerDo: [:' , aViennaNode first first , ' | ' , body , ']' ].
	setExpr := aViennaNode second label = 'SetRangeExpression'
		ifTrue: [ self intervalExpression: aViennaNode second env: aDictionary ]
		ifFalse: [ self generate: aViennaNode second env: aDictionary ].
	aViennaNode first label = 'PatternIdentifier'
		ifTrue: [ ^ setExpr , ' do: [:' , aViennaNode first first , ' | ' , body , ']' ].
	vars := (self boundVariables: aViennaNode first) asArray.
	varGenerator := self
		varNameGenerator: 'for'
		uniqueIn: (Array with: setExpr with: body) , vars.
	^ self
		stringStreamContents: [ :stream | 
			| loopVar |
			loopVar := varGenerator value.
			stream
				nextPutAll: setExpr;
				nextPutAll: ' do: [:';
				nextPutAll: loopVar;
				nextPutAll: '||';
				nextPutAll: (' ' join: vars);
				nextPutAll: '|';
				nextPutAll: (self binder: pat with: loopVar vars: vars);
				nextPutAll: ' ifFalse: [ViennaNoMatch signal].'.
			stream nextPutAll: body.
			stream nextPutAll: ']' ]