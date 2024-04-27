Class {
	#name : #ViennaConditionalExpressionNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'instance creation' }
ViennaConditionalExpressionNode class >> condition: aViennaExpressionNode1 expression: aViennaExpressionNode2 [

	^ (self new: 2)
		  condition: aViennaExpressionNode1;
		  expression: aViennaExpressionNode2;
		  yourself
]

{ #category : #private }
ViennaConditionalExpressionNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : #accessing }
ViennaConditionalExpressionNode >> condition [

	^ self at: 1
]

{ #category : #accessing }
ViennaConditionalExpressionNode >> condition: aViennaExpressionNode [

	self at: 1 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaConditionalExpressionNode >> expression [

	^ self at: 2
]

{ #category : #accessing }
ViennaConditionalExpressionNode >> expression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : #'pretty printing' }
ViennaConditionalExpressionNode >> formatWith: aViennaAbstractFormatter [

	^ (aViennaAbstractFormatter keyword: 'elseif ')
	  , (aViennaAbstractFormatter indentString:
			   (aViennaAbstractFormatter format: self condition))
	  , aViennaAbstractFormatter cr , aViennaAbstractFormatter indent
	  , (aViennaAbstractFormatter keyword: 'then ')
	  , (aViennaAbstractFormatter indentString:
			   (aViennaAbstractFormatter format: self expression))
]

{ #category : #private }
ViennaConditionalExpressionNode >> freeIdentifiersExcept: aSet do: aBlock [

	self condition freeIdentifiersExcept: aSet do: aBlock.
	self expression freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #testing }
ViennaConditionalExpressionNode >> isViennaConditionalExpressionNode [

	^ true
]

{ #category : #accessing }
ViennaConditionalExpressionNode >> label [

	^ 'ConditionalExpression'
]

{ #category : #typechecking }
ViennaConditionalExpressionNode >> maximalType [

	self condition typecheck: ViennaType bool.
	^ self expression typecheck
]

{ #category : #typechecking }
ViennaConditionalExpressionNode >> maximalType: aViennaType [

	^ self expression maximalType: aViennaType
]
