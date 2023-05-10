Class {
	#name : #ViennaApplyNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaApplyNode class >> expression: aViennaExpressionNode argumentExpressionList: aViennaExpressionListNode [

	^ (self new: 2)
		  expression: aViennaExpressionNode;
		  argumentExpressionList: aViennaExpressionListNode;
		  yourself
]

{ #category : #accessing }
ViennaApplyNode >> argumentExpressionList [

	^ self at: 2
]

{ #category : #accessing }
ViennaApplyNode >> argumentExpressionList: aViennaExpressionListNode [

	self at: 2 put: aViennaExpressionListNode
]

{ #category : #accessing }
ViennaApplyNode >> arguments [

	^ self argumentExpressionList asArray
]

{ #category : #accessing }
ViennaApplyNode >> expression [

	^ self at: 1
]

{ #category : #accessing }
ViennaApplyNode >> expression: aString [

	self at: 1 put: aString
]

{ #category : #'pretty printing' }
ViennaApplyNode >> formatWith: aViennaAbstractFormatter [

	| expression args |
	expression := aViennaAbstractFormatter format: self expression.
	args := aViennaAbstractFormatter format: self argumentExpressionList.
	^ expression , '('
	  , ((aViennaAbstractFormatter needsIndent: expression , args)
			   ifTrue: [
				   String cr , aViennaAbstractFormatter indent
				   , (aViennaAbstractFormatter indentString: args) ]
			   ifFalse: [ args ]) , ')'
]

{ #category : #accessing }
ViennaApplyNode >> function [

	^ self expression
]

{ #category : #'pretty printing' }
ViennaApplyNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock1 value
]

{ #category : #testing }
ViennaApplyNode >> isViennaApplyNode [

	^ true
]

{ #category : #accessing }
ViennaApplyNode >> label [

	^ 'Apply'
]

{ #category : #'pretty printing' }
ViennaApplyNode >> operatorPrecedence [

	^ 40
]
