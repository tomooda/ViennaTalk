Class {
	#name : 'ViennaResultExpressionNode',
	#superclass : 'ViennaExpressionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'pretty printing' }
ViennaResultExpressionNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter keyword: 'RESULT'
]

{ #category : 'private' }
ViennaResultExpressionNode >> freeIdentifiersExcept: aSet do: aBlock [
]

{ #category : 'testing' }
ViennaResultExpressionNode >> isViennaResultExpressionNode [

	^ true
]

{ #category : 'accessing' }
ViennaResultExpressionNode >> label [

	^ 'ResultExpression'
]

{ #category : 'typechecking' }
ViennaResultExpressionNode >> maximalType [

	^ (self
		   detectParent: [ :node |
			   node isFunctionDefinition or: [ node isOperationDefinition ] ]
		   ifNone: [ nil ])
		  ifNotNil: [ :definitionNode | definitionNode returnType typecheck ]
		  ifNil: [
			  ViennaTypeError
				  on: self
				  signal: 'RESULT out of function/operation definition' ]
]

{ #category : 'accessing' }
ViennaResultExpressionNode >> resolve [

	^ self
		  detectParent: [ :node |
			  node isFunctionDefinition or: [ node isOperationDefinition ] ]
		  ifNone: [ nil ]
]
