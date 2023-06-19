Class {
	#name : #ViennaBindListNode,
	#superclass : #ViennaPatternBindNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaBindListNode >> formatWith: aViennaAbstractFormatter [

	| binds |
	binds := aViennaAbstractFormatter formatAll: self.
	^ aViennaAbstractFormatter
		  join: ',' , ((aViennaAbstractFormatter anyNeedsIndent: binds)
				   ifTrue: [ String cr ]
				   ifFalse: [ String space ])
		  withAll: binds
]

{ #category : #testing }
ViennaBindListNode >> isViennaBindListNode [

	^ true
]

{ #category : #accessing }
ViennaBindListNode >> label [

	^ 'BindList'
]
