Class {
	#name : #ViennaTypeNameNode,
	#superclass : #ViennaTypeNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaTypeNameNode class >> name: aViennaNameNode [

	^ (self new: 1)
		  name: aViennaNameNode;
		  yourself
]

{ #category : #'pretty printing' }
ViennaTypeNameNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter format: self name
]

{ #category : #private }
ViennaTypeNameNode >> freeIdentifiersExcept: aSet do: aBlock [

	self name freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #testing }
ViennaTypeNameNode >> isViennaTypeNameNode [

	^ true
]

{ #category : #accessing }
ViennaTypeNameNode >> label [

	^ 'TypeName'
]

{ #category : #accessing }
ViennaTypeNameNode >> name [

	^ self at: 1
]

{ #category : #accessing }
ViennaTypeNameNode >> name: aViennaNameNode [

	self at: 1 put: aViennaNameNode
]
