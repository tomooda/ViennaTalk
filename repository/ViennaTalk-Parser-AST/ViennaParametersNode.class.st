Class {
	#name : #ViennaParametersNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

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
