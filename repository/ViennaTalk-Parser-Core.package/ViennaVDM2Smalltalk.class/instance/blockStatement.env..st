code generation-statements
blockStatement: aViennaNode env: aDictionary
	| statements vars |
	statements := OrderedCollection new:aViennaNode size.
	vars :=self boundVariables: aViennaNode.
	aViennaNode do: [: node |
		(self generate: node env: aDictionary) ifNotNil: [:statement | statements add: statement]].
	^ '[|' , (' ' join: vars asArray) , '|' , ('.' join: statements) , '] value.'