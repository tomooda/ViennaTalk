code generation-expressions
localName: aViennaNode env: aDictionary
	| name |
	name := aViennaNode first.
	^ aDictionary at: name ifAbsent: [ name ]