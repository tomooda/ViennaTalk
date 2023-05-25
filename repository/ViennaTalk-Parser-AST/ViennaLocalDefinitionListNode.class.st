Class {
	#name : #ViennaLocalDefinitionListNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

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

{ #category : #accessing }
ViennaLocalDefinitionListNode >> label [

	^ 'LocalDefinitionList'
]
