Class {
	#name : #ViennaBindListNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaBindListNode class >> withAll: anArrayOfViennaMultipleBindNode [

	| bindList |
	bindList := self new: anArrayOfViennaMultipleBindNode size.
	1 to: anArrayOfViennaMultipleBindNode size do: [ :index |
		bindList
			at: index
			put: (anArrayOfViennaMultipleBindNode at: index) ].
	^ bindList
]

{ #category : #accessing }
ViennaBindListNode >> label [

	^ 'BindList'
]
