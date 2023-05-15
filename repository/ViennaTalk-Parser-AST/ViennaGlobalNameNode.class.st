Class {
	#name : #ViennaGlobalNameNode,
	#superclass : #ViennaNameNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaGlobalNameNode class >> moduleIdentifier: aString1 identifier: aString2 [

	^ (self new: 2)
		  moduleIdentifier: aString1;
		  identifier: aString2;
		  yourself
]

{ #category : #'pretty printing' }
ViennaGlobalNameNode >> formatWith: aViennaAbstractFormatter [

	^ self moduleIdentifier , '`' , self identifier
]

{ #category : #'parsers-symbols' }
ViennaGlobalNameNode >> identifier [

	^ self at: 2
]

{ #category : #'parsers-symbols' }
ViennaGlobalNameNode >> identifier: aString [

	self at: 2 put: aString
]

{ #category : #accessing }
ViennaGlobalNameNode >> label [

	^ 'GlobalName'
]

{ #category : #'parsers-symbols' }
ViennaGlobalNameNode >> moduleIdentifier [

	^ self at: 1
]

{ #category : #'parsers-symbols' }
ViennaGlobalNameNode >> moduleIdentifier: aString [

	self at: 1 put: aString
]
