Class {
	#name : #ViennaIntraOperationSlicer,
	#superclass : #ViennaSlicer,
	#instVars : [
		'nodes',
		'agenda',
		'reads',
		'writes',
		'statement'
	],
	#category : #'ViennaTalk-Slicing-Core'
}

{ #category : #'instance creation' }
ViennaIntraOperationSlicer class >> withAll: aCollectionOfViennaNameNode [

	^ self new
		  agenda: (Set withAll: aCollectionOfViennaNameNode);
		  yourself
]

{ #category : #private }
ViennaIntraOperationSlicer >> addAgenda: aViennaNameNode [

	agenda add: aViennaNameNode resolve
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
		calleeName resolve ifNotNil: [ :callee |
			callee isOperationDefinition ifTrue: [
				| calleeSlicer |
				calleeSlicer := self subslicer.
				callee sliceWith: calleeSlicer.
				self continue: calleeSlicer ] ] ].
	aViennaApplyNode arguments do: [ :expression |
		expression sliceWith: self ].
	calleeName sliceWith: self
]

{ #category : #operations }
ViennaIntraOperationSlicer >> continue: aViennaIntraOperationSlicer [

	agenda := aViennaIntraOperationSlicer agenda copy
]

{ #category : #initialization }
ViennaIntraOperationSlicer >> initialize [

	super initialize.
	agenda := Set new.
	nodes := IdentitySet new.
	reads := Set new.
	writes := Set new
]

{ #category : #operations }
ViennaIntraOperationSlicer >> node: aViennaNode do: aBlock [

	| oldStatement |
	oldStatement := statement.
	statement := aViennaNode.
	[ aBlock cull: self ] ensure: [
		(writes anySatisfy: [ :w | agenda includes: w ]) ifTrue: [
			agenda removeAllFoundIn: writes.
			agenda addAll: reads.
			reads removeAll.
			writes removeAll.
			nodes add: aViennaNode ].
		statement := oldStatement ]
]

{ #category : #copying }
ViennaIntraOperationSlicer >> postCopy [

	nodes := nodes copy.
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
ViennaIntraOperationSlicer >> subslicer [

	^ self class withAll: agenda
]

{ #category : #operations }
ViennaIntraOperationSlicer >> write: aViennaNameNode [

	writes add: aViennaNameNode resolve
]

{ #category : #private }
ViennaIntraOperationSlicer >> writes [

	^ writes asArray
]
