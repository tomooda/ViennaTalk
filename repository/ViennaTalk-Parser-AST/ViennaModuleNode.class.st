Class {
	#name : #ViennaModuleNode,
	#superclass : #ViennaAbstractSyntaxNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaModuleNode >> identifier [

	^ self at: 1
]

{ #category : #'as yet unclassified' }
ViennaModuleNode >> isViennaModuleNode [

	^ true
]

{ #category : #'as yet unclassified' }
ViennaModuleNode >> label [

	^ 'Module'
]
