Class {
	#name : #ViennaAssignmentDefinitionNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaAssignmentDefinitionNode class >> identifier: aString type: aViennaTypeNode expression: aViennaExpressionNode [

	^ (self new: 3)
		  identifier: aString;
		  type: aViennaTypeNode;
		  expression: aViennaExpressionNode;
		  yourself
]

{ #category : #private }
ViennaAssignmentDefinitionNode >> boundIdentifiersDo: aBlock [

	aBlock value: self identifier
]

{ #category : #accessing }
ViennaAssignmentDefinitionNode >> expression [

	^ self at: 3
]

{ #category : #accessing }
ViennaAssignmentDefinitionNode >> expression: aViennaExpressionNode [

	self at: 3 put: aViennaExpressionNode
]

{ #category : #'pretty printing' }
ViennaAssignmentDefinitionNode >> formatWith: aViennaAbstractFormatter [

	^ self identifier , ':'
	  , (aViennaAbstractFormatter format: self type) , (self expression
		   ifNotNil: [ :exp |
		   ' := ' , (aViennaAbstractFormatter format: exp) ]
		   ifNil: [ '' ])
]

{ #category : #accessing }
ViennaAssignmentDefinitionNode >> identifier [

	^ self at: 1
]

{ #category : #accessing }
ViennaAssignmentDefinitionNode >> identifier: aString [

	self at: 1 put: aString
]

{ #category : #testing }
ViennaAssignmentDefinitionNode >> isViennaAssignmentDefinitionNode [

	^ true
]

{ #category : #accessing }
ViennaAssignmentDefinitionNode >> label [

	^ 'AssignmentDefinition'
]

{ #category : #accessing }
ViennaAssignmentDefinitionNode >> type [

	^ self at: 2
]

{ #category : #accessing }
ViennaAssignmentDefinitionNode >> type: aViennaTypeNode [

	self at: 2 put: aViennaTypeNode
]
