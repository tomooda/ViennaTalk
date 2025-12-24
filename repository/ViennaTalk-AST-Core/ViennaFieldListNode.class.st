Class {
	#name : 'ViennaFieldListNode',
	#superclass : 'ViennaDefinitionComponentNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'converting' }
ViennaFieldListNode >> asMaximalViennaType [

	^ self collect: #asMaximalViennaType
]

{ #category : 'private' }
ViennaFieldListNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : 'pretty printing' }
ViennaFieldListNode >> formatWith: aViennaAbstractFormatter [

	| fields |
	fields := aViennaAbstractFormatter formatAll: self.
	^ aViennaAbstractFormatter
		  join: ((aViennaAbstractFormatter anyNeedsIndent: fields)
				   ifTrue: [ aViennaAbstractFormatter cr ]
				   ifFalse: [ aViennaAbstractFormatter space ])
		  withAll: fields
]

{ #category : 'private' }
ViennaFieldListNode >> freeIdentifiersExcept: aSet do: aBlock [

	self do: [ :field | field freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : 'testing' }
ViennaFieldListNode >> isTransparentComponent [

	^ self parent isNil or: [
		  self parent isViennaStateDefinitionNode not ]
]

{ #category : 'testing' }
ViennaFieldListNode >> isViennaFieldListNode [

	^ true
]

{ #category : 'accessing' }
ViennaFieldListNode >> label [

	^ 'FieldList'
]

{ #category : 'typechecking' }
ViennaFieldListNode >> maximalType [

	^ ViennaType product: (self collect: #typecheck)
]
