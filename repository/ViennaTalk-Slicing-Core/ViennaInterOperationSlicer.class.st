Class {
	#name : 'ViennaInterOperationSlicer',
	#superclass : 'Object',
	#instVars : [
		'agenda',
		'slicers',
		'dependency'
	],
	#category : 'ViennaTalk-Slicing-Core',
	#package : 'ViennaTalk-Slicing-Core'
}

{ #category : 'slicing' }
ViennaInterOperationSlicer >> addAgenda: aViennaIntraOperationSlicer [

	agenda add: aViennaIntraOperationSlicer.
	dependency
		at: aViennaIntraOperationSlicer
		ifPresent: [ :dependentSlicers | agenda addAll: dependentSlicers ]
]

{ #category : 'private' }
ViennaInterOperationSlicer >> addSlicer: aViennaSlicer [

	slicers
		at: {
				aViennaSlicer operation.
				aViennaSlicer criteria copy }
		put: aViennaSlicer
]

{ #category : 'slicing' }
ViennaInterOperationSlicer >> finishAgenda [

	[ agenda notEmpty ] whileTrue: [
		| slicer |
		slicer := agenda anyOne.
		agenda remove: slicer ifAbsent: [  ].
		slicer cut ]
]

{ #category : 'initialization' }
ViennaInterOperationSlicer >> initialize [

	super initialize.
	slicers := Dictionary new.
	agenda := IdentitySet new.
	dependency := IdentityDictionary new
]

{ #category : 'accessing' }
ViennaInterOperationSlicer >> slicerOnOperation: aViennaNode criteria: aCollectionOfViennaNode callerSlicer: aViennaSlicer [

	| key newSlicer |
	key := {
		       aViennaNode resolve.
		       aCollectionOfViennaNode }.

	slicers at: key ifPresent: [ :slicer |
		(dependency at: slicer ifAbsentPut: [ Set new ]) add: aViennaSlicer.
		^ slicer ].
	newSlicer := (ViennaSlicer
		              operation: aViennaNode
		              criteria: aCollectionOfViennaNode)
		             interOperationSlicer: self.
	slicers at: key put: newSlicer.
	(dependency at: newSlicer ifAbsentPut: [ Set new ]) add:
		aViennaSlicer.
	^ newSlicer
		  cut;
		  yourself
]
