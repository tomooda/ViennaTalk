Class {
	#name : #ViennaMultipleTypeBindNode,
	#superclass : #ViennaMultipleBindNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaMultipleTypeBindNode class >> patternList: aViennaPatternListNode type: aViennaTypeNode [

	^ (self new: 2)
		  patternList: aViennaPatternListNode;
		  type: aViennaTypeNode;
		  yourself
]

{ #category : #'pretty printing' }
ViennaMultipleTypeBindNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  print: (aViennaAbstractFormatter format: self patternList)
		  infix: ':'
		  arg: (aViennaAbstractFormatter format: self type)
]

{ #category : #private }
ViennaMultipleTypeBindNode >> freeIdentifiersExcept: aSet do: aBlock [

	self patternList freeIdentifiersExcept: aSet do: aBlock.
	self type freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #testing }
ViennaMultipleTypeBindNode >> isViennaMultipleTypeBindNode [

	^ true
]

{ #category : #accessing }
ViennaMultipleTypeBindNode >> label [

	^ 'MultipleTypeBind'
]

{ #category : #typechecking }
ViennaMultipleTypeBindNode >> maximalType [

	| type |
	type := self type asMaximalViennaType.
	self patternsDo: [ :pattern |
		pattern maximalType: type.
		[ pattern typecheck: type ]
			on: ViennaTypeError
			do: [ :ex |
				ViennaTypeError
					on: self
					signal:
						'Bind mismatch: Pattern ' , pattern source , ' not agree with '
						, type printString ] ].
	^ ViennaType unit
]

{ #category : #typechecking }
ViennaMultipleTypeBindNode >> maximalType: aViennaType [

	| basetype |
	basetype := self type asMaximalViennaType.
	super maximalType: basetype & aViennaType
]

{ #category : #accessing }
ViennaMultipleTypeBindNode >> type [

	^ self at: 2
]

{ #category : #accessing }
ViennaMultipleTypeBindNode >> type: aViennaTypeNode [

	self at: 2 put: aViennaTypeNode
]
