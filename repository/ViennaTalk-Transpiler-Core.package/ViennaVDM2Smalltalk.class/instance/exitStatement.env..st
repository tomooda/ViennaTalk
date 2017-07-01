code generation-statements
exitStatement: aViennaNode env: aDictionary
	| expr |
	expr := self generate: aViennaNode first env: aDictionary.
	^ '(ViennaException expression: ' , expr , ')'