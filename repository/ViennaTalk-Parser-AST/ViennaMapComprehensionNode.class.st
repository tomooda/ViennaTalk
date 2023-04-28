Class {
	#name : #ViennaMapComprehensionNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaMapComprehensionNode class >> keyExpression: aViennaExpressionNode1 valueExpression: aViennaExpressionNode2 bindList: aViennaBindListNode suchthatExpression: aViennaExpressionNode3 [

	^ (self new: 4)
		  keyExpression: aViennaExpressionNode1;
		  valueExpression: aViennaExpressionNode2;
		  bindList: aViennaBindListNode;
		  suchthatExpression: aViennaExpressionNode3;
		  yourself
]

{ #category : #accessing }
ViennaMapComprehensionNode >> bindList [

	^ self at: 3
]

{ #category : #accessing }
ViennaMapComprehensionNode >> bindList: aViennaBindListNode [

	self at: 3 put: aViennaBindListNode
]

{ #category : #accessing }
ViennaMapComprehensionNode >> keyExpression [

	^ self at: 1
]

{ #category : #accessing }
ViennaMapComprehensionNode >> keyExpression: aViennaExpressionNode [

	self at: 1 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaMapComprehensionNode >> label [

	^ 'MapComprehension'
]

{ #category : #accessing }
ViennaMapComprehensionNode >> suchthatExpression [

	^ self at: 4
]

{ #category : #accessing }
ViennaMapComprehensionNode >> suchthatExpression: aViennaExpressionNode [

	self at: 4 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaMapComprehensionNode >> valueExpression [

	^ self at: 2
]

{ #category : #accessing }
ViennaMapComprehensionNode >> valueExpression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]
