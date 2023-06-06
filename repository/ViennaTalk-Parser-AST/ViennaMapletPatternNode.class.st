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

{ #category : #'pretty printing' }
ViennaMapletPatternNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  print: (aViennaAbstractFormatter format: self keyPattern)
		  infix: aViennaAbstractFormatter maplet
		  arg: (aViennaAbstractFormatter format: self valuePattern)
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

{ #category : #accessing }
ViennaMapletPatternNode >> valuePattern [

	^ self at: 2
]

{ #category : #accessing }
ViennaMapletPatternNode >> valuePattern: aViennaPatternNode [

	self at: 2 put: aViennaPatternNode
]
