Class {
	#name : #ViennaInterOperationSlicer,
	#superclass : #Object,
	#instVars : [
		'dependency',
		'agenda'
	],
	#category : #'ViennaTalk-Slicing-Core'
}

{ #category : #initialization }
ViennaInterOperationSlicer >> initialize [

	super initialize.
	dependency := Dictionary new.
	agenda := IdentitySet new
]

{ #category : #slicing }
ViennaInterOperationSlicer >> slicerOnOperation: aViennaNode criteria: aCollectionOfViennaNode [

	^ dependency at: aViennaNode resolve ifAbsentPut: [
		  | slicer |
		  slicer := (ViennaIntraOperationSlicer
			             operation: aViennaNode
			             criteria: aCollectionOfViennaNode)
			            interOperationSlicer: self;
			            yourself.
		  agenda add: slicer.
		  slicer ]
]
