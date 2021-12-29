Class {
	#name : #ViennaVDMDebugger,
	#superclass : #StDebugger,
	#instVars : [
		'specification'
	],
	#category : #'ViennaTalk-Transpiler-Debugger'
}

{ #category : #specs }
ViennaVDMDebugger class >> codeLayout [

	^ SpBoxLayout newTopToBottom
		  add: #toolbar expand: false;
		  add: (SpPanedLayout newLeftToRight
				   positionOfSlider: 60 percent;
				   add: #code;
				   add: #specification;
				   yourself);
		  yourself
]

{ #category : #testing }
ViennaVDMDebugger class >> debugSession: aDebugSession [

	^ super debugSession: aDebugSession asViennaDebugSession
]

{ #category : #accessing }
ViennaVDMDebugger class >> defaultDebuggerRank [ 
	^ 10
]

{ #category : #accessing }
ViennaVDMDebugger class >> defaultTitle [

	^ 'VDM'
]

{ #category : #testing }
ViennaVDMDebugger class >> handlesContext: aContext [

	^ aContext specificationContext notNil
]

{ #category : #'presenter - specification' }
ViennaVDMDebugger >> acceptSpecificationChanges: newSpecification forContext: aContext [

	"do nothing for now"

	
]

{ #category : #'updating - widgets' }
ViennaVDMDebugger >> clearSpecification [

	self specification
		clearSelection;
		clearContent
]

{ #category : #'accessing - context' }
ViennaVDMDebugger >> currentSpecification [
	^ self currentContext specification
]

{ #category : #'presenter - specification' }
ViennaVDMDebugger >> discardSpecificationChangesFor: aContext [

	self specification text: aContext specification highlightedSource.
	self update
]

{ #category : #initialization }
ViennaVDMDebugger >> initializePresenters [

	super initializePresenters.
	self initializeSpecification.

]

{ #category : #initialization }
ViennaVDMDebugger >> initializeSpecification [

	specification := self newText.
	specification whenSubmitDo: [ :text | 
		self acceptSpecificationChanges: text string forContext: self selectedContext ].
	specification whenResetDo: [ self discardSpecificationChangesFor: self selectedContext ]
]

{ #category : #initialization }
ViennaVDMDebugger >> initializeStack [

	super initializeStack.
	stackTable transmitDo: [ :context | 
		stackTable selection isEmpty ifFalse: [ 
			self updateSpecificationFromContext: context ] ]
]

{ #category : #'accessing - context' }
ViennaVDMDebugger >> newTitle [

	^ '[Vienna]', super newTitle
]

{ #category : #'accessing - context' }
ViennaVDMDebugger >> selectedSpecification [

	^ self selectedContext ifNotNil: #specification
]

{ #category : #'accessing - widgets' }
ViennaVDMDebugger >> specification [

	^ specification
]

{ #category : #'presenter - specification' }
ViennaVDMDebugger >> updateSpecificationFor: aContext [

	self specification text: (aContext specification
			 ifNil: [ Text new ]
			 ifNotNil: [ :spec | spec highlightedSource ])
]

{ #category : #'presenter - specification' }
ViennaVDMDebugger >> updateSpecificationFromContext: aContext [

	| selectionInterval |
	aContext ifNil: [ ^ self clearSpecification ].

	selectionInterval := self session selectedVDMRangeForContext:
		                     aContext.
	self updateSpecificationFor: aContext.
	self specification
		selectionInterval:
			(selectionInterval last to: selectionInterval last - 1).
	self
		updateSpecificationTextSegmentDecoratorsIn: aContext
		forInterval: selectionInterval
]

{ #category : #'updating - widgets' }
ViennaVDMDebugger >> updateSpecificationTextSegmentDecoratorsIn: aContext forInterval: selectionInterval [

	self specification
		removeAllTextSegmentDecorations;
		addTextSegmentDecoration: (SpTextPresenterDecorator new
				 highlightColor: (Color orange alpha: 0.5);
				 underlineColor: (Color white alpha: 0);
				 interval:
					 (selectionInterval first to: selectionInterval last + 1);
				 yourself)
]
