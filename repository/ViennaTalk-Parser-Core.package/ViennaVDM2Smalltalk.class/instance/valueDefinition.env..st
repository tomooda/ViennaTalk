code generation-definitions
valueDefinition: aViennaNode env: aDictionary
	| pat body vars binder |
	pat := self generate: aViennaNode first env: aDictionary.
	body := self generate: aViennaNode third env: aDictionary.
	vars := pat first.
	binder := self binder: pat second with: body vars: vars.
	^ {vars.
	('(' , binder , '  ifFalse: [ViennaNoMatch signal])')}