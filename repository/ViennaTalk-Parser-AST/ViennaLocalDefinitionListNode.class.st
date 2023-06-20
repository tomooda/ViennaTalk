Class {
	#name : #ViennaLocalDefinitionListNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #private }
ViennaLocalDefinitionListNode >> boundIdentifiersDo: aBlock [

	self do: [ :localDefinition |
		localDefinition boundIdentifiersDo: aBlock ]
]

{ #category : #'pretty printing' }
ViennaLocalDefinitionListNode >> formatWith: aViennaAbstractFormatter [

	| localDefinitions |
	localDefinitions := aViennaAbstractFormatter formatAll: self.
	^ (aViennaAbstractFormatter anyNeedsIndent: localDefinitions)
		  ifTrue: [
			  aViennaAbstractFormatter
				  join: ',' , String cr
				  withAll: localDefinitions ]
		  ifFalse: [
		  aViennaAbstractFormatter join: ', ' withAll: localDefinitions ]
]

{ #category : #testing }
ViennaLocalDefinitionListNode >> isViennaLocalDefinitionListNode [

	^ true
]

{ #category : #accessing }
ViennaLocalDefinitionListNode >> label [

	^ 'LocalDefinitionList'
]
