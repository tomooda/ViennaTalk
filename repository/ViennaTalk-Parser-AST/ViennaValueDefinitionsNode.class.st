Class {
	#name : #ViennaValueDefinitionsNode,
	#superclass : #ViennaSectionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaValueDefinitionsNode >> isViennaValueDefinitionsNode [

	^ true
]

{ #category : #accessing }
ViennaValueDefinitionsNode >> label [

	^ 'ValueDefinitions'
]

{ #category : #'pretty printing' }
ViennaValueDefinitionsNode >> sectionName [

	^ 'values'
]
