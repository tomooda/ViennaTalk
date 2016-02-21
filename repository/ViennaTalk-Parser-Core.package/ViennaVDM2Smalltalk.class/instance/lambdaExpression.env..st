code generation-expressions
lambdaExpression: aViennaNode env: aDictionary
	| body varGenerator |
	body := self generate: aViennaNode second env: aDictionary.
	varGenerator := self varNameGenerator: 'lmd' uniqueIn: (Array with: body).
	^ self
		closureFromFlatBinds: aViennaNode first asArray
		body: body
		varGenerator: varGenerator
		env: aDictionary