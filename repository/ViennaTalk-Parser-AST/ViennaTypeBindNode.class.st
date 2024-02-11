Class {
	#name : #ViennaTypeBindNode,
	#superclass : #ViennaBindNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaTypeBindNode class >> pattern: aViennaPatternNode type: aViennaTypeNode [

	^ (self new: 2)
		  pattern: aViennaPatternNode;
		  type: aViennaTypeNode;
		  yourself
]

{ #category : #'pretty printing' }
ViennaTypeBindNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  print: (aViennaAbstractFormatter format: self pattern)
		  infix: ':'
		  arg: (aViennaAbstractFormatter format: self type)
]

{ #category : #private }
ViennaTypeBindNode >> freeIdentifiersExcept: aSet do: aBlock [

	self pattern freeIdentifiersExcept: aSet do: aBlock.
	self type freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #testing }
ViennaTypeBindNode >> isViennaTypeBindNode [

	^ true
]

{ #category : #accessing }
ViennaTypeBindNode >> label [

	^ 'TypeBind'
]

{ #category : #typechecking }
ViennaTypeBindNode >> maximalType [

	| basetype |
	basetype := self type asMaximalViennaType.
	self pattern maximalType: basetype.
	[ self pattern typecheck: basetype ]
		on: ViennaTypeError
		do: [ :ex |
			ViennaTypeError
				on: self
				signal:
					'Bind mismatch: Pattern ' , self pattern source
					, ' not agree with ' , basetype printString ].
	^ ViennaType unit
]

{ #category : #typechecking }
ViennaTypeBindNode >> maximalType: aViennaType [

	| basetype |
	basetype := self type asMaximalViennaType.
	super maximalType: basetype & aViennaType
]

{ #category : #accessing }
ViennaTypeBindNode >> type [

	^ self at: 2
]

{ #category : #accessing }
ViennaTypeBindNode >> type: aViennaTypeNode [

	self at: 2 put: aViennaTypeNode
]
