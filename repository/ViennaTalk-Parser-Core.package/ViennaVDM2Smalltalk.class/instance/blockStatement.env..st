code generation-statements
blockStatement: aViennaNode env: aDictionary
	| statements vars |
	statements := OrderedCollection new:aViennaNode size.
	vars := Set new: aViennaNode size.
	aViennaNode do: [: node |
		(self generate: node env: aDictionary) ifNotNil: [:statement | statements add: statement]].
	self boundVariables: aViennaNode into: vars.
	^ '[|' , (' ' join: vars asArray) , '|' , ('.' join: statements) , '] value.'