Class {
	#name : #ViennaMapletPatternNode,
	#superclass : #ViennaPatternNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaMapletPatternNode class >> keyPattern: aViennaPatternNode1 valuePattern: aViennaPatternNode2 [

	^ (self new: 2)
		  keyPattern: aViennaPatternNode1;
		  valuePattern: aViennaPatternNode2;
		  yourself
]

{ #category : #private }
ViennaMapletPatternNode >> boundIdentifiersDo: aBlock [

	self keyPattern boundIdentifiersDo: aBlock.
	self valuePattern boundIdentifiersDo: aBlock
]

{ #category : #'pretty printing' }
ViennaMapletPatternNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  print: (aViennaAbstractFormatter format: self keyPattern)
		  infix: aViennaAbstractFormatter maplet
		  arg: (aViennaAbstractFormatter format: self valuePattern)
]

{ #category : #private }
ViennaMapletPatternNode >> freeIdentifiersExcept: aSet do: aBlock [

	self keyPattern freeIdentifiersExcept: aSet do: aBlock.
	self valuePattern freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #testing }
ViennaMapletPatternNode >> isViennaMapletPatternNode [

	^ true
]

{ #category : #accessing }
ViennaMapletPatternNode >> keyPattern [

	^ self at: 1
]

{ #category : #accessing }
ViennaMapletPatternNode >> keyPattern: aViennaPatternNode [

	self at: 1 put: aViennaPatternNode
]

{ #category : #accessing }
ViennaMapletPatternNode >> label [

	^ 'MapletPattern'
]

{ #category : #typechecking }
ViennaMapletPatternNode >> maximalType [

	^ self keyPattern typecheck mapTo: self valuePattern typecheck
]

{ #category : #typechecking }
ViennaMapletPatternNode >> maximalType: aViennaType [

	| keyType valueType |
	keyType := ViennaType unit.
	valueType := ViennaType unit.
	aViennaType possibleTypesDo: [ :type |
		type isMapType ifTrue: [
			keyType := keyType + type keytype.
			valueType := valueType + type valuetype ] ].
	self keyPattern maximalType: keyType.
	self valuePattern maximalType: valueType.
	super maximalType: self maximalType
]

{ #category : #accessing }
ViennaMapletPatternNode >> valuePattern [

	^ self at: 2
]

{ #category : #accessing }
ViennaMapletPatternNode >> valuePattern: aViennaPatternNode [

	self at: 2 put: aViennaPatternNode
]
