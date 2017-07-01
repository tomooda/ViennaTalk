code generation-expressions
iotaExpression: aViennaNode env: aDictionary
	| bindNode expr varGenerator |
	bindNode := aViennaNode first.
	expr := self generate: aViennaNode second env: aDictionary.
	varGenerator := self varNameGenerator: 'iota' uniqueIn: (Array with: expr).
	^ '('
		,
			(self
				generatorFromFlatBinds:
					{{(bindNode first).
					(bindNode second)}}
				selector: #detect:
				whenMatchFailed: 'false'
				body: expr
				varGenerator: varGenerator
				env: aDictionary) , ' ifNone: [ViennaNoMatch signal])'