Class {
	#name : #ViennaNode,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'label'
	],
	#category : 'ViennaTalk-Parser-Core'
}

{ #category : #'instance creation' }
ViennaNode class >> label: aString [
	^ (self new: 0)
		setLabel: aString;
		yourself
]

{ #category : #'instance creation' }
ViennaNode class >> label: aString with: aViennaNode [
	^ (self new: 1)
		setLabel: aString;
		at: 1 put: aViennaNode;
		yourself
]

{ #category : #'instance creation' }
ViennaNode class >> label: aString with: aViennaNode1 with: aViennaNode2 [
	^ (self new: 2)
		setLabel: aString;
		at: 1 put: aViennaNode1;
		at: 2 put: aViennaNode2;
		yourself
]

{ #category : #'instance creation' }
ViennaNode class >> label: aString with: aViennaNode1 with: aViennaNode2 with: aViennaNode3 [
	^ (self new: 3)
		setLabel: aString;
		at: 1 put: aViennaNode1;
		at: 2 put: aViennaNode2;
		at: 3 put: aViennaNode3;
		yourself
]

{ #category : #'instance creation' }
ViennaNode class >> label: aString with: aViennaNode1 with: aViennaNode2 with: aViennaNode3 with: aViennaNode4 [
	^ (self new: 4)
		setLabel: aString;
		at: 1 put: aViennaNode1;
		at: 2 put: aViennaNode2;
		at: 3 put: aViennaNode3;
		at: 4 put: aViennaNode4;
		yourself
]

{ #category : #'instance creation' }
ViennaNode class >> label: aString with: aViennaNode1 with: aViennaNode2 with: aViennaNode3 with: aViennaNode4 with: aViennaNode5 [
	^ (self new: 5)
		setLabel: aString;
		at: 1 put: aViennaNode1;
		at: 2 put: aViennaNode2;
		at: 3 put: aViennaNode3;
		at: 4 put: aViennaNode4;
		at: 5 put: aViennaNode5;
		yourself
]

{ #category : #'instance creation' }
ViennaNode class >> label: aString withAll: anArray [
	| node |
	node := self new: anArray size.
	node setLabel: aString.
	1 to: anArray size do: [ :index | node at: index put: (anArray at: index) ].
	^ node
]

{ #category : #accessing }
ViennaNode >> label [
	^ label
]

{ #category : #printing }
ViennaNode >> printOn: aStream [
	aStream
		nextPutAll: label asString;
		nextPut: $(.
	(1 to: self size)
		do: [ :index | 
			| child |
			child := self at: index.
			child isArray
				ifTrue: [ 
					aStream nextPut: $(.
					child do: [ :ast | ast printOn: aStream ] separatedBy: [ aStream nextPut: Character cr ].
					aStream nextPut: $) ]
				ifFalse: [ child printOn: aStream ] ]
		separatedBy: [ aStream nextPutAll: ', ' ].
	aStream nextPut: $)
]

{ #category : #private }
ViennaNode >> setLabel: aString [
	label := aString
]

{ #category : #printing }
ViennaNode >> storeOn: aStream [
	aStream
		nextPutAll: '(';
		nextPutAll: self class name;
		nextPutAll: ' label: '.
	label storeOn: aStream.
	aStream nextPutAll: ' withAll: {'.
	(1 to: self size) do: [ :index | (self at: index) storeOn: aStream ] separatedBy: [ aStream nextPutAll: ' . ' ].
	aStream nextPutAll: '})'
]
