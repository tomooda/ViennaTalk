Class {
	#name : #ViennaEqualDefinitionListNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaEqualDefinitionListNode class >> withAll: anArrayOfViennaEqualDefinitionNode [

	| list |
	list := self new: anArrayOfViennaEqualDefinitionNode size.
	1 to: anArrayOfViennaEqualDefinitionNode size do: [ :index |
		list at: index put: (anArrayOfViennaEqualDefinitionNode at: index) ].
	^ list
]

{ #category : #'pretty printing' }
ViennaEqualDefinitionListNode >> formatWith: aViennaAbstractFormatter [

	| defs |
	defs := aViennaAbstractFormatter formatAll: self.
	^ (aViennaAbstractFormatter join: ';' , String cr withAll: defs)
	  , ';'
]

{ #category : #accessing }
ViennaEqualDefinitionListNode >> label [

	^ 'EqualDefinitionList'
]
