Class {
	#name : #ViennaEqualDefinitionListNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaEqualDefinitionListNode >> formatWith: aViennaAbstractFormatter [

	| defs |
	defs := aViennaAbstractFormatter formatAll: self.
	^ (aViennaAbstractFormatter join: ';' , String cr withAll: defs)
	  , ';'
]

{ #category : #testing }
ViennaEqualDefinitionListNode >> isViennaEqualDefinitionListNode [

	^ true
]

{ #category : #accessing }
ViennaEqualDefinitionListNode >> label [

	^ 'EqualDefinitionList'
]
