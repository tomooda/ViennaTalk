Class {
	#name : #ViennaBlockStatementNode,
	#superclass : #ViennaStatementNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

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

{ #category : #'pretty printing' }
ViennaBlockStatementNode >> formatWith: aViennaAbstractFormatter [

	^ '(' , (aViennaAbstractFormatter
		   join: ';' , String cr
		   withAll: (aViennaAbstractFormatter formatAll: self)) , ')'
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
