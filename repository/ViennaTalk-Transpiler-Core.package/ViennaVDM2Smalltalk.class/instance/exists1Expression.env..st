code generation-expressions
exists1Expression: aViennaNode env: aDictionary
	| bindNode expr varGenerator |
	bindNode := aViennaNode first.
	expr := self generate: aViennaNode second env: aDictionary.
	varGenerator := self varNameGenerator: 'exists1' uniqueIn: (Array with: expr).
	^ '('
		,
			(self
				generatorFromFlatBinds:
					{{(bindNode first).
					(bindNode second)}}
				selector: #onlyOneSatisfy:
				whenMatchFailed: 'false'
				body: expr
				varGenerator: varGenerator
				env: aDictionary) , ')'