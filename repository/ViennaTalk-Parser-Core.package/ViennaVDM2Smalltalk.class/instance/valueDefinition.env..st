code generation-definitions
valueDefinition: aViennaNode env: aDictionary
	| pat body binder |
	pat := self generate: aViennaNode first env: aDictionary.
	body := self generate: aViennaNode third env: aDictionary.
	binder := self binder: pat with: body vars: (self boundVariables: aViennaNode first) asArray.
	^ '(' , binder , '  ifFalse: [ViennaNoMatch signal])'