Class {
	#name : #ViennaInlineLet,
	#superclass : #ViennaInline,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaInlineLet >> check [
	^ ast notNil
		and: [ ast label = 'LetExpression' or: [ ast label = 'LetStatement' ] ]
]

{ #category : #operations }
ViennaInlineLet >> execute [
	| defs |
	defs := ast first asArray
		collect: [ :localDef | localDef first first first -> localDef first third ].
	[ defs notEmpty ]
		whileTrue: [ | nextDef |
			nextDef := defs
				detect: [ :def | 
					defs
						allSatisfy: [ :assoc | (self hasFreeOccurrencesOf: assoc key in: def value) not ] ]
				ifNone: [ nil ].
			nextDef isNil
				ifTrue: [ ^ self ].
			self
				freeOccurrencesOf: nextDef key
				in: ast second
				do: [ :node | self replaceNode: node with: nextDef value ].
			defs := defs copyWithout: nextDef.
			defs
				do: [ :def | 
					self
						freeOccurrencesOf: nextDef key
						in: def value
						do: [ :node | self replaceNode: node with: nextDef value ] ] ].
	^ self replaceNode: ast with: ast second
]

{ #category : #accessing }
ViennaInlineLet >> sortingOrder [
	^ 2.17
]
