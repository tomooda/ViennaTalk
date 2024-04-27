Class {
	#name : #ViennaBlockStatementNode,
	#superclass : #ViennaStatementNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #accessing }
ViennaBlockStatementNode >> dclStatement [

	^ (self notEmpty and: [ self first isViennaDclStatementNode ])
		  ifTrue: [ self first ]
]

{ #category : #'accessing-definitions' }
ViennaBlockStatementNode >> definitionOfLocalName: aString [

	self do: [ :statement |
		statement isViennaDclStatementNode ifTrue: [
			(statement
				 detect: [ :assignmentDefinition |
				 assignmentDefinition identifier = aString ]
				 ifNone: [ nil ]) ifNotNil: [ :assignmentDefinition |
				^ assignmentDefinition ] ] ].
	^ parent ifNotNil: [ parent definitionOfLocalName: aString ]
]

{ #category : #'accessing-definitions' }
ViennaBlockStatementNode >> findResolverForIdentifier: aString [

	self dclStatement ifNotNil: [ :dclStatement |
		(dclStatement bindsIdentifier: aString) ifTrue: [ ^ self ] ].
	^ super findResolverForIdentifier: aString
]

{ #category : #'pretty printing' }
ViennaBlockStatementNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter empty , '(' , (aViennaAbstractFormatter
		   join:
		   aViennaAbstractFormatter empty , ';'
		   , aViennaAbstractFormatter cr
		   withAll: (aViennaAbstractFormatter formatAll: self)) , ')'
]

{ #category : #private }
ViennaBlockStatementNode >> freeIdentifiersExcept: aSet do: aBlock [

	| boundIdentifiers |
	self ifEmpty: [ ^ self ].
	boundIdentifiers := aSet , self first uniqueBoundIdentifiers.
	self first freeIdentifiersExcept: aSet do: aBlock.
	2 to: self size do: [ :index |
		(self at: index) freeIdentifiersExcept: boundIdentifiers do: aBlock ]
]

{ #category : #testing }
ViennaBlockStatementNode >> hasDclStatement [

	^ self notEmpty and: [ self first isViennaDclStatementNode ]
]

{ #category : #testing }
ViennaBlockStatementNode >> hasScope [

	^ true
]

{ #category : #testing }
ViennaBlockStatementNode >> isViennaBlockStatementNode [

	^ true
]

{ #category : #accessing }
ViennaBlockStatementNode >> label [

	^ 'BlockStatement'
]

{ #category : #'accessing-definitions' }
ViennaBlockStatementNode >> lookupIdentifier: aString [

	self dclStatement ifNotNil: [ :dclStatement |
		(dclStatement bindsIdentifier: aString) ifTrue: [
			dclStatement do: [ :assignmentDefinition |
				assignmentDefinition identifier = aString ifTrue: [
					^ assignmentDefinition ] ] ] ].
	^ super findResolverForIdentifier: aString
]

{ #category : #typechecking }
ViennaBlockStatementNode >> maximalType [

	self do: #typecheck.
	^ ViennaType unit
]
