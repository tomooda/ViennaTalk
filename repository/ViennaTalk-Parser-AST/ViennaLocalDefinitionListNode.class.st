Class {
	#name : #ViennaLocalDefinitionListNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaLocalDefinitionListNode class >> withAll: anArrayOfViennaLocalDefinitionNode [

	| list |
	list := self new: anArrayOfViennaLocalDefinitionNode size.
	1 to: anArrayOfViennaLocalDefinitionNode size do: [ :index |
		list at: index put: (anArrayOfViennaLocalDefinitionNode at: index) ].
	^ list
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

{ #category : #accessing }
ViennaLocalDefinitionListNode >> label [

	^ 'LocalDefinitionList'
]
