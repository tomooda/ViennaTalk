free variables-statements
freeVariablesBlockStatement: aViennaNode boundVars: boundVars into: freeVars
	| binds |
	binds := boundVars copy.
	aViennaNode
		do: [ :node | 
			node label = 'DclStatement'
				ifTrue: [ self boundVariables: node into: binds ] ].
	aViennaNode do: [ :node | self freeVariables: node boundVars: binds into: freeVars ]