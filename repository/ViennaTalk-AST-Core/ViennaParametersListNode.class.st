Class {
	#name : 'ViennaParametersListNode',
	#superclass : 'ViennaDefinitionComponentNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'private' }
ViennaParametersListNode >> boundIdentifiersDo: aBlock [

	self do: [ :parameters | parameters boundIdentifiersDo: aBlock ]
]

{ #category : 'pretty printing' }
ViennaParametersListNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  join: aViennaAbstractFormatter empty
		  withAll: (aViennaAbstractFormatter formatAll: self)
]

{ #category : 'private' }
ViennaParametersListNode >> freeIdentifiersExcept: aSet do: aBlock [

	self do: [ :parameters |
		parameters freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : 'testing' }
ViennaParametersListNode >> isViennaParametersListNode [

	^ true
]

{ #category : 'accessing' }
ViennaParametersListNode >> label [

	^ 'ParametersList'
]

{ #category : 'private' }
ViennaParametersListNode >> listDelimiter [

	^ ''
]

{ #category : 'typechecking' }
ViennaParametersListNode >> maximalType [

	^ ViennaType product: (self collect: #typecheck)
]
