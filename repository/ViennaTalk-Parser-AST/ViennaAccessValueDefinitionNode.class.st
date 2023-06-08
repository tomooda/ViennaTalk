Class {
	#name : #ViennaAccessValueDefinitionNode,
	#superclass : #ViennaObsoleteNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaAccessValueDefinitionNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  join: ' '
		  withAll: (aViennaAbstractFormatter formatAll: self)
]

{ #category : #'as yet unclassified' }
ViennaAccessValueDefinitionNode >> isViennaAccessValueDefinitionNode [

	^ true
]

{ #category : #accessing }
ViennaAccessValueDefinitionNode >> label [

	^ 'AccessValueDefinition'
]
