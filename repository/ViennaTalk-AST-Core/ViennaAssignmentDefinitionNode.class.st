Class {
	#name : #ViennaAssignmentDefinitionNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'instance creation' }
ViennaAssignmentDefinitionNode class >> identifier: aString type: aViennaTypeNode expression: aViennaExpressionNode [

	^ (self new: 3)
		  identifier: aString;
		  type: aViennaTypeNode;
		  expression: aViennaExpressionNode;
		  yourself
]

{ #category : #converting }
ViennaAssignmentDefinitionNode >> asViennaAssignStatementNode [

	^ self expression ifNotNil: [
		  ViennaAssignStatementNode
			  stateDesignator:
			  (ViennaLocalNameNode identifier: self identifier)
			  expression: self expression ]
]

{ #category : #private }
ViennaAssignmentDefinitionNode >> boundIdentifiersDo: aBlock [

	aBlock cull: self identifier cull: self
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

	^ (aViennaAbstractFormatter identifier: self identifier) ++ ':'
	  ++ (aViennaAbstractFormatter format: self type) ++ (self expression
		   ifNotNil: [ :exp |
			   aViennaAbstractFormatter empty ++ ' := '
			   ++ (aViennaAbstractFormatter format: exp) ]
		   ifNil: [ aViennaAbstractFormatter empty ])
]

{ #category : #private }
ViennaAssignmentDefinitionNode >> freeIdentifiersExcept: aSet do: aBlock [

	| boundIdentifiers |
	boundIdentifiers := aSet copyWith: self identifier.
	self type ifNotNil: [ :type |
		type freeIdentifiersExcept: boundIdentifiers do: aBlock ].
	self expression ifNotNil: [ :expression |
		expression freeIdentifiersExcept: boundIdentifiers do: aBlock ]
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

{ #category : #testing }
ViennaAssignmentDefinitionNode >> isViennaAssignmentDefinitionNode: aString [

	^ self identifier = aString
]

{ #category : #accessing }
ViennaAssignmentDefinitionNode >> label [

	^ 'AssignmentDefinition'
]

{ #category : #typechecking }
ViennaAssignmentDefinitionNode >> maximalType [

	| t |
	t := self type typecheck.
	self expression ifNotNil: [ :expr | expr typecheck: t ].
	^ t
]

{ #category : #accessing }
ViennaAssignmentDefinitionNode >> type [

	^ self at: 2
]

{ #category : #accessing }
ViennaAssignmentDefinitionNode >> type: aViennaTypeNode [

	self at: 2 put: aViennaTypeNode
]

{ #category : #converting }
ViennaAssignmentDefinitionNode >> withoutInitialization [

	^ self class
		  identifier: self identifier
		  type: self type copyFragment
		  expression: nil
]
