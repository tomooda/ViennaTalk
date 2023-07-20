Class {
	#name : #ViennaIntraOperationSlicer,
	#superclass : #Object,
	#instVars : [
		'operation',
		'criteria',
		'slice',
		'agenda',
		'reads',
		'writes',
		'interOperationSlicer'
	],
	#category : #'ViennaTalk-Slicing-Core'
}

{ #category : #'instance creation' }
ViennaIntraOperationSlicer class >> operation: aViennaNode criteria: aCollectionOfViennaNameNode [

	^ self new
		  operation: aViennaNode;
		  criteria: aCollectionOfViennaNameNode;
		  yourself
]

{ #category : #'instance creation' }
ViennaIntraOperationSlicer class >> withAll: aCollectionOfViennaNameNode [

	^ self new
		  criteria: aCollectionOfViennaNameNode;
		  yourself
]

{ #category : #comparing }
ViennaIntraOperationSlicer >> = anObject [

	^ self class = anObject class and: [
		  operation == anObject operation and: [
			  criteria = anObject criteria ] ]
]

{ #category : #private }
ViennaIntraOperationSlicer >> addCriterion: aViennaNode [

	criteria add: aViennaNode resolve.
	agenda := criteria copy
]

{ #category : #accessing }
ViennaIntraOperationSlicer >> agenda [

	^ agenda asArray
]

{ #category : #accessing }
ViennaIntraOperationSlicer >> agenda: aCollectionOfViennaNameNode [

	agenda := Set withAll: aCollectionOfViennaNameNode
]

{ #category : #operations }
ViennaIntraOperationSlicer >> branch [

	| subslicerStream |
	subslicerStream := Array new writeStream.
	^ [ :block |
	  block
		  ifNotNil: [
			  | subslicer |
			  subslicer := self copy.
			  block value: subslicer.
			  subslicerStream nextPut: subslicer ]
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
ViennaIntraOperationSlicer >> call: aViennaApplyNode [

	| calleeName |
	calleeName := aViennaApplyNode expression.
	calleeName isViennaNameNode ifTrue: [
		self continue: (self interOperationSlicer
				 slicerOnOperation: calleeName resolve
				 criteria: self agenda) ].
	aViennaApplyNode arguments do: [ :expression |
		expression sliceWith: self ].
	calleeName sliceWith: self
]

{ #category : #operations }
ViennaIntraOperationSlicer >> continue: aViennaIntraOperationSlicer [

	agenda := aViennaIntraOperationSlicer agenda copy
]

{ #category : #accessing }
ViennaIntraOperationSlicer >> criteria [

	^ criteria
]

{ #category : #accessing }
ViennaIntraOperationSlicer >> criteria: aCollectionOfViennaNode [

	criteria := IdentitySet withAll:
		            (aCollectionOfViennaNode collect: #resolve).
	agenda := criteria copy
]

{ #category : #comparing }
ViennaIntraOperationSlicer >> hash [

	^ (self class hash bitXor: operation hash) bitXor: criteria hash
]

{ #category : #initialization }
ViennaIntraOperationSlicer >> initialize [

	super initialize.
	criteria := IdentitySet new.
	slice := IdentitySet new.
	agenda := IdentitySet new.
	reads := Set new.
	writes := Set new
]

{ #category : #accessing }
ViennaIntraOperationSlicer >> interOperationSlicer [

	^ interOperationSlicer ifNil: [
		  interOperationSlicer := ViennaInterOperationSlicer new ]
]

{ #category : #accessing }
ViennaIntraOperationSlicer >> interOperationSlicer: aViennaInterOperationSlicer [

	interOperationSlicer := aViennaInterOperationSlicer
]

{ #category : #operations }
ViennaIntraOperationSlicer >> onNode: aViennaNode do: aBlock [

	self agenda.
	[ aBlock cull: self ] ensure: [
		(writes anySatisfy: [ :w | agenda includes: w ]) ifTrue: [
			agenda removeAllFoundIn: writes.
			agenda addAll: reads.
			reads removeAll.
			writes removeAll.
			slice add: aViennaNode ] ]
]

{ #category : #accessing }
ViennaIntraOperationSlicer >> operation [

	^ operation
]

{ #category : #accessing }
ViennaIntraOperationSlicer >> operation: aViennaNode [

	operation := aViennaNode resolve
]

{ #category : #copying }
ViennaIntraOperationSlicer >> postCopy [

	criteria := criteria copy.
	slice := slice copy.
	agenda := agenda copy.
	reads := reads copy.
	writes := writes copy
]

{ #category : #operations }
ViennaIntraOperationSlicer >> read: aViennaNameNode [

	reads add: aViennaNameNode resolve
]

{ #category : #private }
ViennaIntraOperationSlicer >> reads [

	^ reads asArray
]

{ #category : #operations }
ViennaIntraOperationSlicer >> write: aViennaNameNode [

	writes add: aViennaNameNode resolve
]

{ #category : #private }
ViennaIntraOperationSlicer >> writes [

	^ writes asArray
]
