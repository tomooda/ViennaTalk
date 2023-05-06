Class {
	#name : #ViennaFunctionTypeInstantiationNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaFunctionTypeInstantiationNode class >> expression: aViennaExpression functionTypeArgs: aViennaFunctionTypeArgsNode [

	^ (self new: 2)
		  expression: aViennaExpression;
		  functionTypeArgs: aViennaFunctionTypeArgsNode;
		  yourself
]

{ #category : #accessing }
ViennaFunctionTypeInstantiationNode >> expression [

	^ self at: 1
]

{ #category : #accessing }
ViennaFunctionTypeInstantiationNode >> expression: aViennaExpressionNode [

	self at: 1 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaFunctionTypeInstantiationNode >> functionTypeArgs [

	^ self at: 2
]

{ #category : #accessing }
ViennaFunctionTypeInstantiationNode >> functionTypeArgs: aViennaFunctionTypeArgsNode [

	self at: 2 put: aViennaFunctionTypeArgsNode
]

{ #category : #'pretty printing' }
ViennaFunctionTypeInstantiationNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock1 value
]

{ #category : #accessing }
ViennaFunctionTypeInstantiationNode >> label [

	^ 'FunctionTypeInstantiation'
]

{ #category : #'pretty printing' }
ViennaFunctionTypeInstantiationNode >> operatorPrecedence [

	^ 40
]
