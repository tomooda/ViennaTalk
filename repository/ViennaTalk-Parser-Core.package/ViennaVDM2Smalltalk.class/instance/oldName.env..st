code generation-expressions
oldName: aViennaNode env: aDictionary
	| name |
	name := aViennaNode first , '~'.
	^ aDictionary at: name ifAbsent: [ name ]