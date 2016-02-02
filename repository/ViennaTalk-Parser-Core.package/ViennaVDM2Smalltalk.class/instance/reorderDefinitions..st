private
reorderDefinitions: aCollectionOfViennaNode
	| originalDefs env boundVars freeVars newDefs |
	originalDefs := Array withAll: aCollectionOfViennaNode.
	env := Dictionary new.
	boundVars := (originalDefs
		collect: [ :def | 
			| binds |
			binds := Set new.
			self boundVariables: def into: binds.
			def -> binds asArray ]) asDictionary.
	freeVars := (originalDefs collect: [ :def | def -> (self freeVariables: def env: env) asArray ]) asDictionary.
	newDefs := OrderedCollection new: originalDefs size.
	[ originalDefs notEmpty ]
		whileTrue: [ 
			| allBoundVars index |
			allBoundVars := Set new: 1024.
			originalDefs do: [ :def | allBoundVars addAll: (boundVars at: def) ].
			index := (1 to: originalDefs size)
				detect: [ :i | ((freeVars at: (originalDefs at: i)) contains: [ :var | allBoundVars includes: var ]) not ]
				ifNone: [ ^ self error: 'Cyclic definition' ].
			newDefs add: (originalDefs at: index).
			originalDefs := originalDefs copyWithoutIndex: index ].
	^ newDefs asArray