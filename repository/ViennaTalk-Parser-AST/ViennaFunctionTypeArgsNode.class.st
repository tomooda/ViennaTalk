Class {
	#name : #ViennaFunctionTypeArgsNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaFunctionTypeArgsNode class >> withAll: anArrayOfViennaTypeNode [

	| typeArgs |
	typeArgs := self new: anArrayOfViennaTypeNode size.
	1 to: anArrayOfViennaTypeNode size do: [ :index |
		typeArgs at: index put: (anArrayOfViennaTypeNode at: index) ].
	^ typeArgs
]

{ #category : #'pretty printing' }
ViennaFunctionTypeArgsNode >> formatWith: aViennaAbstractFormatter [

	^ '[' , (aViennaAbstractFormatter
		   join: ', '
		   withAll: (aViennaAbstractFormatter formatAll: self)) , ']'
]

{ #category : #accessing }
ViennaFunctionTypeArgsNode >> label [

	^ 'FunctionTypeArgs'
]
