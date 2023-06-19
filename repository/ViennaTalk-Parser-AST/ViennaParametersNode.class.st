Class {
	#name : #ViennaParametersNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #private }
ViennaParametersNode >> boundIdentifiersInto: aSet [

	self do: [ :pattern | pattern boundIdentifiersInto: aSet ]
]

{ #category : #'pretty printing' }
ViennaParametersNode >> formatWith: aViennaAbstractFormatter [

	^ '(' , (aViennaAbstractFormatter
		   join: ', '
		   withAll: (aViennaAbstractFormatter formatAll: self)) , ')'
]

{ #category : #testing }
ViennaParametersNode >> isViennaParametersNode [

	^ true
]

{ #category : #accessing }
ViennaParametersNode >> label [

	^ 'Parameters'
]
