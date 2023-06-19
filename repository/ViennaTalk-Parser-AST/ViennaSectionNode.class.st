Class {
	#name : #ViennaSectionNode,
	#superclass : #ViennaNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaSectionNode class >> isAbstract [

	^ self = ViennaSectionNode
]

{ #category : #private }
ViennaSectionNode >> boundIdentifiersInto: aSet [

	self do: [ :node | node boundIdentifiersInto: aSet ]
]

{ #category : #'pretty printing' }
ViennaSectionNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  indentString: self sectionName
		  insertCr: (aViennaAbstractFormatter
				   join: ';' , String cr , String cr
				   withAll: (aViennaAbstractFormatter formatAll: self))
			  , (self isEmpty
					   ifTrue: [ '' ]
					   ifFalse: [ ';' , String cr ])
]

{ #category : #testing }
ViennaSectionNode >> isViennaSectionNode [

	^ true
]

{ #category : #'pretty printing' }
ViennaSectionNode >> sectionName [

	^ self subclassResponsibility
]

{ #category : #accessing }
ViennaSectionNode >> shortName [

	^ self sectionName
]
