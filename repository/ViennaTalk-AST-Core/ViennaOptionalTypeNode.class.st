Class {
	#name : 'ViennaOptionalTypeNode',
	#superclass : 'ViennaUnaryTypeConstructorNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'converting' }
ViennaOptionalTypeNode >> asMaximalViennaType [

	^ self type asMaximalViennaType optional
]

{ #category : 'pretty printing' }
ViennaOptionalTypeNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter empty ++ '['
	  ++ (aViennaAbstractFormatter format: self type) ++ ']'
]

{ #category : 'testing' }
ViennaOptionalTypeNode >> isViennaOptionalTypeNode [

	^ true
]

{ #category : 'accessing' }
ViennaOptionalTypeNode >> label [

	^ 'OptionalType'
]
