Class {
	#name : #ViennaParametersListNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #private }
ViennaParametersListNode >> boundIdentifiersDo: aBlock [

	self do: [ :parameters | parameters boundIdentifiersDo: aBlock ]
]

{ #category : #'pretty printing' }
ViennaParametersListNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  join: ''
		  withAll: (aViennaAbstractFormatter formatAll: self)
]

{ #category : #testing }
ViennaParametersListNode >> isViennaParametersListNode [

	^ true
]

{ #category : #accessing }
ViennaParametersListNode >> label [

	^ 'ParametersList'
]
