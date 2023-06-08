Class {
	#name : #ViennaFunctionTypeArgsNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaFunctionTypeArgsNode >> formatWith: aViennaAbstractFormatter [

	^ '[' , (aViennaAbstractFormatter
		   join: ', '
		   withAll: (aViennaAbstractFormatter formatAll: self)) , ']'
]

{ #category : #'as yet unclassified' }
ViennaFunctionTypeArgsNode >> isViennaFunctionTypeArgsNode [

	^ true
]

{ #category : #accessing }
ViennaFunctionTypeArgsNode >> label [

	^ 'FunctionTypeArgs'
]
