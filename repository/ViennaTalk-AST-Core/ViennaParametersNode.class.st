Class {
	#name : 'ViennaParametersNode',
	#superclass : 'ViennaDefinitionComponentNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'private' }
ViennaParametersNode >> boundIdentifiersDo: aBlock [

	self do: [ :pattern | pattern boundIdentifiersDo: aBlock ]
]

{ #category : 'pretty printing' }
ViennaParametersNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter empty ++ '(' ++ (aViennaAbstractFormatter
		   join: ', '
		   withAll: (aViennaAbstractFormatter formatAll: self)) ++ ')'
]

{ #category : 'private' }
ViennaParametersNode >> freeIdentifiersExcept: aSet do: aBlock [

	self do: [ :pattern | pattern freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : 'testing' }
ViennaParametersNode >> isViennaParametersNode [

	^ true
]

{ #category : 'accessing' }
ViennaParametersNode >> label [

	^ 'Parameters'
]

{ #category : 'typechecking' }
ViennaParametersNode >> maximalType [

	^ ViennaType product: (self collect: #typecheck)
]
