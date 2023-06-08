Class {
	#name : #ViennaAccessFunctionDefinitionNode,
	#superclass : #ViennaObsoleteNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaAccessFunctionDefinitionNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  join: ' '
		  withAll:
		  ((aViennaAbstractFormatter formatAll: self) reject: #isEmpty)
]

{ #category : #'as yet unclassified' }
ViennaAccessFunctionDefinitionNode >> isViennaAccessFunctionDefinitionNode [

	^ true
]

{ #category : #accessing }
ViennaAccessFunctionDefinitionNode >> label [

	^ 'AccessFunctionDefinition'
]
