Class {
	#name : #ViennaTypeNameNode,
	#superclass : #ViennaTypeNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'instance creation' }
ViennaTypeNameNode class >> name: aViennaNameNode [

	^ (self new: 1)
		  name: aViennaNameNode;
		  yourself
]

{ #category : #converting }
ViennaTypeNameNode >> asMaximalViennaType [

	^ self resolve
		  ifNotNil: #typecheck
		  ifNil: [
		  ViennaTypeError on: self signal: 'Unresolved type: ' , self source ]
]

{ #category : #'pretty printing' }
ViennaTypeNameNode >> formatWith: aViennaAbstractFormatter [

	| name |
	name := self name.
	^ name isViennaGlobalNameNode
		  ifTrue: [
			  (aViennaAbstractFormatter moduleName: name moduleIdentifier)
			  ++ '`' ++ (aViennaAbstractFormatter typeName: name identifier) ]
		  ifFalse: [ aViennaAbstractFormatter typeName: name identifier ]
]

{ #category : #private }
ViennaTypeNameNode >> freeIdentifiersExcept: aSet do: aBlock [

	self name freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #accessing }
ViennaTypeNameNode >> identifier [

	^ self name identifier
]

{ #category : #testing }
ViennaTypeNameNode >> isViennaTypeNameNode [

	^ true
]

{ #category : #testing }
ViennaTypeNameNode >> isViennaTypeNameNode: aString [

	^ self identifier = aString
]

{ #category : #accessing }
ViennaTypeNameNode >> label [

	^ 'TypeName'
]

{ #category : #'accessing-definitions' }
ViennaTypeNameNode >> localResolve [

	^ self name localResolve
]

{ #category : #typechecking }
ViennaTypeNameNode >> maximalType [

	^ self resolve ifNotNil: #typecheck ifNil: [
		  ViennaTypeError
			  on: self
			  signal: 'Unresolved type name: ' , self name source ]
]

{ #category : #accessing }
ViennaTypeNameNode >> name [

	^ self at: 1
]

{ #category : #accessing }
ViennaTypeNameNode >> name: aViennaNameNode [

	self at: 1 put: aViennaNameNode
]

{ #category : #'accessing-definitions' }
ViennaTypeNameNode >> resolve [

	^ self name resolve
]
