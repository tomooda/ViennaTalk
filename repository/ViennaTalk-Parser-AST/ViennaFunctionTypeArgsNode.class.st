Class {
	#name : #ViennaFunctionTypeArgsNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #private }
ViennaFunctionTypeArgsNode >> boundIdentifiersInto: aSet [

	self do: [ :typeArg | typeArg boundIdentifiersInto: aSet ]
]

{ #category : #'pretty printing' }
ViennaFunctionTypeArgsNode >> formatWith: aViennaAbstractFormatter [

	^ '[' , (aViennaAbstractFormatter
		   join: ', '
		   withAll: (aViennaAbstractFormatter formatAll: self)) , ']'
]

{ #category : #testing }
ViennaFunctionTypeArgsNode >> isViennaFunctionTypeArgsNode [

	^ true
]

{ #category : #accessing }
ViennaFunctionTypeArgsNode >> label [

	^ 'FunctionTypeArgs'
]
