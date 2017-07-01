code generation-types
partialFunctionType: aViennaNode env: aDictionary
	| argType returnType |
	argType := self generate: aViennaNode first env: aDictionary.
	returnType := self generate: aViennaNode second env: aDictionary.
	^ '(' , argType , ' -> ' , returnType , ')'