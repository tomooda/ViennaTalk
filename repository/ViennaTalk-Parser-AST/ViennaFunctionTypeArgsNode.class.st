Class {
	#name : #ViennaFunctionTypeArgsNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #private }
ViennaFunctionTypeArgsNode >> boundIdentifiersDo: aBlock [

	self do: [ :typeArg | typeArg boundIdentifiersDo: aBlock ]
]

{ #category : #'pretty printing' }
ViennaFunctionTypeArgsNode >> formatWith: aViennaAbstractFormatter [

	^ '[' , (aViennaAbstractFormatter
		   join: ', '
		   withAll: (aViennaAbstractFormatter formatAll: self)) , ']'
]

{ #category : #private }
ViennaFunctionTypeArgsNode >> freeIdentifiersExcept: aSet do: aBlock [

	self do: [ :arg | arg freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : #testing }
ViennaFunctionTypeArgsNode >> isViennaFunctionTypeArgsNode [

	^ true
]

{ #category : #accessing }
ViennaFunctionTypeArgsNode >> label [

	^ 'FunctionTypeArgs'
]
