Class {
	#name : 'ViennaFieldReferenceNode',
	#superclass : 'ViennaStateDesignatorNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'instance creation' }
ViennaFieldReferenceNode class >> stateDesignator: aViennaStateDesignatorNode field: aString [

	^ (self new: 2)
		  stateDesignator: aViennaStateDesignatorNode;
		  field: aString;
		  yourself
]

{ #category : 'accessing' }
ViennaFieldReferenceNode >> field [

	^ self at: 2
]

{ #category : 'accessing' }
ViennaFieldReferenceNode >> field: aString [

	self at: 2 put: aString
]

{ #category : 'pretty printing' }
ViennaFieldReferenceNode >> formatWith: aViennaAbstractFormatter [

	| stateDesignator field |
	stateDesignator := aViennaAbstractFormatter format:
		                   self stateDesignator.
	field := aViennaAbstractFormatter format: self field.
	^ aViennaAbstractFormatter
		  indentString: stateDesignator
		  insertCrIfNeeded: aViennaAbstractFormatter empty ++ '.' ++ field
]

{ #category : 'private' }
ViennaFieldReferenceNode >> freeIdentifiersExcept: aSet do: aBlock [

	self stateDesignator freeIdentifiersExcept: aSet do: aBlock
]

{ #category : 'testing' }
ViennaFieldReferenceNode >> isAssignable [

	^ self stateDesignator isAssignable
]

{ #category : 'testing' }
ViennaFieldReferenceNode >> isViennaFieldReferenceNode [

	^ true
]

{ #category : 'accessing' }
ViennaFieldReferenceNode >> label [

	^ 'FieldReference'
]

{ #category : 'accessing-definitions' }
ViennaFieldReferenceNode >> localResolve [

	^ self stateDesignator localResolve
]

{ #category : 'typechecking' }
ViennaFieldReferenceNode >> maximalType [

	| type |
	type := ViennaType unit.
	self stateDesignator typecheck possibleTypesDo: [ :basetype |
		basetype isCompositeType ifTrue: [
			basetype fieldsDo: [ :f :e :t |
				f = self field ifTrue: [ type := type + t ] ] ] ].
	^ type ifUnit: [
		  ViennaTypeError
			  on: self
			  signal: 'The field ' , self field , ' is not accessible' ]
]

{ #category : 'accessing-definitions' }
ViennaFieldReferenceNode >> resolve [

	^ self stateDesignator resolve
]

{ #category : 'accessing' }
ViennaFieldReferenceNode >> stateDesignator [

	^ self at: 1
]

{ #category : 'accessing' }
ViennaFieldReferenceNode >> stateDesignator: aViennaStateDesignatorNode [

	self at: 1 put: aViennaStateDesignatorNode
]
