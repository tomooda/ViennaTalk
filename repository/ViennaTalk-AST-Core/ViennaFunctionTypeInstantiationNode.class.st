Class {
	#name : 'ViennaFunctionTypeInstantiationNode',
	#superclass : 'ViennaExpressionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'instance creation' }
ViennaFunctionTypeInstantiationNode class >> expression: aViennaExpression functionTypeArgs: aViennaFunctionTypeArgsNode [

	^ (self new: 2)
		  expression: aViennaExpression;
		  functionTypeArgs: aViennaFunctionTypeArgsNode;
		  yourself
]

{ #category : 'accessing' }
ViennaFunctionTypeInstantiationNode >> expression [

	^ self at: 1
]

{ #category : 'accessing' }
ViennaFunctionTypeInstantiationNode >> expression: aViennaExpressionNode [

	self at: 1 put: aViennaExpressionNode
]

{ #category : 'pretty printing' }
ViennaFunctionTypeInstantiationNode >> formatWith: aViennaAbstractFormatter [

	| function typeArgs |
	function := aViennaAbstractFormatter format: self expression.
	typeArgs := aViennaAbstractFormatter format: self functionTypeArgs.
	^ function ++ typeArgs
]

{ #category : 'private' }
ViennaFunctionTypeInstantiationNode >> freeIdentifiersExcept: aSet do: aBlock [

	self expression freeIdentifiersExcept: aSet do: aBlock.
	self functionTypeArgs freeIdentifiersExcept: aSet do: aBlock
]

{ #category : 'accessing' }
ViennaFunctionTypeInstantiationNode >> functionTypeArgs [

	^ self at: 2
]

{ #category : 'accessing' }
ViennaFunctionTypeInstantiationNode >> functionTypeArgs: aViennaFunctionTypeArgsNode [

	self at: 2 put: aViennaFunctionTypeArgsNode
]

{ #category : 'pretty printing' }
ViennaFunctionTypeInstantiationNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock1 value
]

{ #category : 'accessing' }
ViennaFunctionTypeInstantiationNode >> isViennaFunctionTypeInstantiationNode [

	^ true
]

{ #category : 'accessing' }
ViennaFunctionTypeInstantiationNode >> label [

	^ 'FunctionTypeInstantiation'
]

{ #category : 'typechecking' }
ViennaFunctionTypeInstantiationNode >> maximalType [

	| functionDefinition params args type |
	functionDefinition := self expression resolve ifNil: [
		                      ^ ViennaTypeError
			                        on: self
			                        signal:
			                        'Unresolved polymorphic function definition' ].
	functionDefinition isFunctionDefinition ifFalse: [
		^ ViennaTypeError
			  on: self
			  signal: 'Non-function can not be instantiated.' ].
	functionDefinition isViennaExplicitFunctionDefinitionNode ifFalse: [
		^ ViennaTypeError
			  on: self
			  signal: 'Only explicit functions can be instantiated' ].
	params := functionDefinition typeVariableList collect: #typecheck.
	args := self functionTypeArgs collect: #typecheck.
	params size = args size ifFalse: [
		^ ViennaTypeError
			  on: self
			  signal:
			  'The number of type parameters and the given type arguments do not agree' ].
	type := functionDefinition type typecheck.
	^ type instantiate: ((1 to: params size) collect: [ :index |
			   Association key: (params at: index) value: (args at: index) ])
			  asDictionary
]

{ #category : 'pretty printing' }
ViennaFunctionTypeInstantiationNode >> operatorPrecedence [

	^ 40
]

{ #category : 'accessing' }
ViennaFunctionTypeInstantiationNode >> resolve [

	^ self expression resolve
]
