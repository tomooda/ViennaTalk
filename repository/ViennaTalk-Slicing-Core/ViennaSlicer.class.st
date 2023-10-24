Class {
	#name : #ViennaSlicer,
	#superclass : #Object,
	#instVars : [
		'operation',
		'criteria',
		'startNode',
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

	^ self
		  operation: aViennaNode
		  criteria: aCollectionOfViennaNameNode
		  startNode: nil
]

{ #category : #'instance creation' }
ViennaSlicer class >> operation: aViennaNode criteria: aCollectionOfViennaNameNode startNode: aViennaNode2 [

	^ self new
		  operation: aViennaNode;
		  criteria: aCollectionOfViennaNameNode;
		  startNode: aViennaNode2;
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
			  criteria = anObject criteria and: [
				  startNode == anObject startNode ] ] ]
]

{ #category : #operations }
ViennaSlicer >> addAffectingNode: aViennaNode [

	affectingNodes add: aViennaNode
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
			  block cull: self.
			  subslicerStream nextPut: self copy ]
		  ifNil: [
			  startNode ifNil: [
				  agenda := Set new.
				  reads := Set new.
				  writes := Set new.
				  subslicerStream contents do: [ :subslicer |
					  agenda addAll: subslicer agenda.
					  reads addAll: subslicer reads.
					  writes addAll: subslicer writes ] ] ] ]
]

{ #category : #operations }
ViennaSlicer >> call: aViennaNode [

	startNode ifNil: [
		aViennaNode isOperationNameNode ifTrue: [
			self continue: (self interOperationSlicer
					 slicerOnOperation: aViennaNode resolve
					 criteria: self agenda
					 callerSlicer: self) ] ]
]

{ #category : #operations }
ViennaSlicer >> continue: aViennaSlicer [

	agenda := aViennaSlicer agenda copy.
	reads := aViennaSlicer reads copy.
	writes := aViennaSlicer writes copy.
	startNode := aViennaSlicer startNode
]

{ #category : #operations }
ViennaSlicer >> control: aViennaNode [

	startNode == aViennaNode ifTrue: [ startNode := nil ].
	agenda add: aViennaNode resolve
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
	^ affectingNodes
]

{ #category : #comparing }
ViennaSlicer >> hash [

	^ ((self class hash bitXor: operation hash) bitXor: criteria hash)
		  bitXor: startNode hash
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
ViennaSlicer >> onNode: aViennaNode [

	aViennaNode == startNode ifTrue: [ startNode := nil ]
]

{ #category : #operations }
ViennaSlicer >> onNode: aViennaNode do: aBlock [

	| origin |
	aViennaNode == startNode ifTrue: [ startNode := nil ].
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
ViennaSlicer >> read: aViennaNode [

	reads add: aViennaNode resolve
]

{ #category : #private }
ViennaSlicer >> reads [

	^ reads
]

{ #category : #operations }
ViennaSlicer >> sliceNodes [

	self cut.
	self interOperationSlicer finishAgenda.
	^ affectingNodes copy
		  addAll: agenda;
		  select: [ :node |
			  (node
				   detectParent: [ :parent | affectingNodes includes: parent ]
				   ifNone: [ nil ]) isNil ]
]

{ #category : #accessing }
ViennaSlicer >> startNode [

	^ startNode
]

{ #category : #accessing }
ViennaSlicer >> startNode: aViennaNode [

	startNode := aViennaNode
]

{ #category : #operations }
ViennaSlicer >> write: aViennaNode [

	writes add: aViennaNode resolve
]

{ #category : #private }
ViennaSlicer >> writes [

	^ writes
]
