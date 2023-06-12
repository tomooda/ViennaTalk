Class {
	#name : #ViennaModuleNode,
	#superclass : #ViennaAbstractSyntaxNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaModuleNode class >> identifier: aString interface: aViennaInterfaceNode moduleBody: aViennaModuleBodyNode [

	^ (self new: 3)
		  identifier: aString;
		  interface: aViennaInterfaceNode;
		  moduleBody: aViennaModuleBodyNode;
		  yourself
]

{ #category : #'pretty printing' }
ViennaModuleNode >> formatWith: aViennaAbstractFormatter [

	| identifier interface moduleBody |
	identifier := aViennaAbstractFormatter format: self first.
	interface := aViennaAbstractFormatter format: self second.
	moduleBody := self third
		              ifNil: [ '' ]
		              ifNotNil: [ :node |
		              String cr , (aViennaAbstractFormatter format: node) ].
	^ 'module ' , identifier , String cr , interface , moduleBody
	  , String cr , 'end ' , identifier
]

{ #category : #accessing }
ViennaModuleNode >> identifier [

	^ self at: 1
]

{ #category : #accessing }
ViennaModuleNode >> identifier: aString [

	self at: 1 put: aString
]

{ #category : #accessing }
ViennaModuleNode >> interface [

	^ self at: 2
]

{ #category : #accessing }
ViennaModuleNode >> interface: aViennaInterfaceNode [

	self at: 2 put: aViennaInterfaceNode
]

{ #category : #testing }
ViennaModuleNode >> isViennaModuleNode [

	^ true
]

{ #category : #testing }
ViennaModuleNode >> isViennaModuleNode: aString [

	^ self identifier = aString
]

{ #category : #testing }
ViennaModuleNode >> label [

	^ 'Module'
]

{ #category : #accessing }
ViennaModuleNode >> moduleBody [

	^ self at: 3
]

{ #category : #accessing }
ViennaModuleNode >> moduleBody: aViennaModuleBodyNode [

	self at: 3 put: aViennaModuleBodyNode
]

{ #category : #testing }
ViennaModuleNode >> shortName [

	^ self identifier
]
