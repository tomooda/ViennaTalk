code generation-types
typeVariableIdentifier: aViennaNode env: aDictionary
	| name |
	name := aViennaNode first.
	^ aDictionary at: name ifAbsent: [ name ]