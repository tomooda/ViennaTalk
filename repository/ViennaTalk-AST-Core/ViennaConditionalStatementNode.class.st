Class {
	#name : 'ViennaConditionalStatementNode',
	#superclass : 'ViennaDefinitionComponentNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'instance creation' }
ViennaConditionalStatementNode class >> condition: aViennaExpressionNode statement: aViennaStatementNode [

	^ (self new: 2)
		  condition: aViennaExpressionNode;
		  statement: aViennaStatementNode;
		  yourself
]

{ #category : 'private' }
ViennaConditionalStatementNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : 'accessing' }
ViennaConditionalStatementNode >> condition [

	^ self at: 1
]

{ #category : 'accessing' }
ViennaConditionalStatementNode >> condition: aViennaExpressionNode [

	self at: 1 put: aViennaExpressionNode
]

{ #category : 'pretty printing' }
ViennaConditionalStatementNode >> formatWith: aViennaAbstractFormatter [

	^ (aViennaAbstractFormatter keyword: 'elseif ')
	  ++ (aViennaAbstractFormatter indentString:
			   (aViennaAbstractFormatter format: self condition))
	  ++ aViennaAbstractFormatter cr ++ aViennaAbstractFormatter indent
	  ++ (aViennaAbstractFormatter keyword: 'then ')
	  ++ (aViennaAbstractFormatter indentString:
			   (aViennaAbstractFormatter format: self statement))
]

{ #category : 'private' }
ViennaConditionalStatementNode >> freeIdentifiersExcept: aSet do: aBlock [

	self condition freeIdentifiersExcept: aSet do: aBlock.
	self statement freeIdentifiersExcept: aSet do: aBlock
]

{ #category : 'testing' }
ViennaConditionalStatementNode >> isViennaConditionalStatementNode [

	^ true
]

{ #category : 'accessing' }
ViennaConditionalStatementNode >> label [

	^ 'ConditionalStatement'
]

{ #category : 'typechecking' }
ViennaConditionalStatementNode >> maximalType [

	self condition typecheck: ViennaType bool.
	^ self statement typecheck
]

{ #category : 'accessing' }
ViennaConditionalStatementNode >> statement [

	^ self at: 2
]

{ #category : 'accessing' }
ViennaConditionalStatementNode >> statement: aViennaStatementNode [

	self at: 2 put: aViennaStatementNode
]
