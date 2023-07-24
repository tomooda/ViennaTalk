Class {
	#name : #ViennaSlicer,
	#superclass : #Object,
	#instVars : [
		'operation',
		'criteria',
		'agenda',
		'reads',
		'writes',
		'interOperationSlicer',
		'affectingNodes'
	],
	#category : #'ViennaTalk-Slicing-Core'
}

{ #category : #'instance creation' }
ViennaSlicer class >> operation: aViennaNode criteria: aCollectionOfViennaNameNode [

	^ self new
		  operation: aViennaNode;
		  criteria: aCollectionOfViennaNameNode;
		  yourself
]

{ #category : #'instance creation' }
ViennaSlicer class >> withAll: aCollectionOfViennaNameNode [

	^ self new
		  criteria: aCollectionOfViennaNameNode;
		  yourself
]

{ #category : #comparing }
ViennaSlicer >> = anObject [

	^ self class = anObject class and: [
		  operation == anObject operation and: [
			  criteria = anObject criteria ] ]
]

{ #category : #private }
ViennaSlicer >> addCriterion: aViennaNode [

	criteria add: aViennaNode resolve.
	agenda := criteria copy
]

{ #category : #accessing }
ViennaSlicer >> affectingNodes [

	^ affectingNodes
]

{ #category : #accessing }
ViennaSlicer >> agenda [

	^ agenda
]

{ #category : #accessing }
ViennaSlicer >> agenda: aCollectionOfViennaNameNode [

	agenda := Set withAll: aCollectionOfViennaNameNode
]

{ #category : #operations }
ViennaSlicer >> branch [

	| subslicerStream origin |
	subslicerStream := Array new writeStream.
	origin := self copy.
	^ [ :block |
	  block
		  ifNotNil: [
			  self continue: origin.
			  block value: self.
			  subslicerStream nextPut: self copy ]
		  ifNil: [
			  agenda := Set new.
			  reads := Set new.
			  writes := Set new.
			  subslicerStream contents do: [ :subslicer |
				  agenda addAll: subslicer agenda.
				  reads addAll: subslicer reads.
				  writes addAll: subslicer writes ] ] ]
]

{ #category : #operations }
ViennaSlicer >> call: aViennaNode [

	aViennaNode isOperationNameNode ifTrue: [
		| slicer |
		self continue: (slicer := self interOperationSlicer
				           slicerOnOperation: aViennaNode resolve
				           criteria: self agenda
				           callerSlicer: self) ]
]

{ #category : #operations }
ViennaSlicer >> continue: aViennaIntraOperationSlicer [

	agenda := aViennaIntraOperationSlicer agenda copy.
	reads := aViennaIntraOperationSlicer reads copy.
	writes := aViennaIntraOperationSlicer writes copy
]

{ #category : #accessing }
ViennaSlicer >> criteria [

	^ criteria
]

{ #category : #accessing }
ViennaSlicer >> criteria: aCollectionOfViennaNode [

	criteria := IdentitySet withAll:
		            (aCollectionOfViennaNode collect: #resolve).
	agenda := criteria copy
]

{ #category : #operations }
ViennaSlicer >> cut [

	| origin |
	self interOperationSlicer.
	origin := self copy.
	self initializeAgenda.
	operation sliceWith: self.
	(agenda = origin agenda and: [
		 affectingNodes = origin affectingNodes ]) ifFalse: [
		self interOperationSlicer addAgenda: self ].
	^ affectingNodes
]

{ #category : #comparing }
ViennaSlicer >> hash [

	^ (self class hash bitXor: operation hash) bitXor: criteria hash
]

{ #category : #initialization }
ViennaSlicer >> initialize [

	super initialize.
	criteria := IdentitySet new.
	affectingNodes := IdentitySet new.
	agenda := IdentitySet new.
	reads := Set new.
	writes := Set new
]

{ #category : #operations }
ViennaSlicer >> initializeAgenda [

	agenda := criteria copy
]

{ #category : #accessing }
ViennaSlicer >> interOperationSlicer [

	^ interOperationSlicer ifNil: [
		  interOperationSlicer := ViennaInterOperationSlicer new
			                          addSlicer: self;
			                          yourself ]
]

{ #category : #accessing }
ViennaSlicer >> interOperationSlicer: aViennaInterOperationSlicer [

	interOperationSlicer := aViennaInterOperationSlicer
]

{ #category : #operations }
ViennaSlicer >> onNode: aViennaNode do: aBlock [

	| origin |
	origin := self copy.
	[ aBlock cull: self ] ensure: [
		(writes anySatisfy: [ :w | agenda includes: w ])
			ifTrue: [
				agenda removeAllFoundIn: writes.
				agenda addAll: reads.
				affectingNodes add: aViennaNode ]
			ifFalse: [
				affectingNodes ~= origin affectingNodes ifTrue: [
					affectingNodes add: aViennaNode ] ].
		reads removeAll.
		writes removeAll ]
]

{ #category : #accessing }
ViennaSlicer >> operation [

	^ operation
]

{ #category : #accessing }
ViennaSlicer >> operation: aViennaNode [

	operation := aViennaNode resolve
]

{ #category : #copying }
ViennaSlicer >> postCopy [

	criteria := criteria copy.
	affectingNodes := affectingNodes copy.
	agenda := agenda copy.
	reads := reads copy.
	writes := writes copy
]

{ #category : #printing }
ViennaSlicer >> printOn: aStream [

	aStream
		nextPutAll: (operation ifNotNil: #identifier ifNil: [ '()' ]);
		nextPutAll: '$'.
	(criteria asArray collect: #identifier) asSortedCollection
		do: [ :identifier | aStream nextPutAll: identifier ]
		separatedBy: [ aStream nextPutAll: ',' ]
]

{ #category : #operations }
ViennaSlicer >> read: aViennaNameNode [

	reads add: aViennaNameNode resolve
]

{ #category : #private }
ViennaSlicer >> reads [

	^ reads
]

{ #category : #operations }
ViennaSlicer >> slice [

	self cut.
	self interOperationSlicer finishAgenda.
	^ affectingNodes
]

{ #category : #operations }
ViennaSlicer >> write: aViennaNameNode [

	writes add: aViennaNameNode resolve
]

{ #category : #private }
ViennaSlicer >> writes [

	^ writes
]
