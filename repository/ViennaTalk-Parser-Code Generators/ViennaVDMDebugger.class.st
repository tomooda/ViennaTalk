Class {
	#name : #ViennaVDMDebugger,
	#superclass : #GTGenericStackDebugger,
	#category : 'ViennaTalk-Parser-Code Generators'
}

{ #category : #accessing }
ViennaVDMDebugger class >> defaultTitle [

	^ 'VDM'
]

{ #category : #'as yet unclassified' }
ViennaVDMDebugger class >> handlesContext: aContext [
	^ aContext specificationContext notNil
]

{ #category : #'tools registry' }
ViennaVDMDebugger class >> register [
	self registerToolsOn: Smalltalk tools
]

{ #category : #'tools registry' }
ViennaVDMDebugger class >> registerToolsOn: registry [

	"Add ourselves to registry. See [Smalltalk tools]" 
	registry registerDebugger: self withRank: 80.
]

{ #category : #accessing }
ViennaVDMDebugger class >> sessionClass [

	^ ViennaDebugSession
]

{ #category : #building }
ViennaVDMDebugger >> debuggerStructureIn: browser [
	
	browser
		row: #stack;
		row: [ :c | c
			column: #code; 
			column: #vdmSource ] span: 2;
		row: #inspector.
		
]

{ #category : #building }
ViennaVDMDebugger >> debuggerTransmissionsIn: browser [

	super debuggerTransmissionsIn: browser.
	browser transmit
		from: #stack port: #selection;
		to: #vdmSource;
		andShow: [ :composite :aContext | self vdmSourceIn: composite forContext: aContext ]

]

{ #category : #'building actions' }
ViennaVDMDebugger >> installVDMSourceActionsFor: aPresentation [
	self installActionsForRootPragmas: self vdmSourceActionsPragmas in: aPresentation
]

{ #category : #'building actions' }
ViennaVDMDebugger >> vdmSourceActionsPragmas [

	^ #( vdmSourceDebuggingAction )
]

{ #category : #'building presentations' }
ViennaVDMDebugger >> vdmSourceIn: composite forContext: aContext [
	(self vdmSourceWidgetIn: composite forContext: aContext)
		initialize: [ :code | code selectionInterval: (self session selectedCodeRangeForContext: self currentContext) ];
		with: [ :code | self installVDMSourceActionsFor: code ]
]

{ #category : #accessing }
ViennaVDMDebugger >> vdmSourcePane [

	^ self browser paneNamed: #vdmSource
]

{ #category : #accessing }
ViennaVDMDebugger >> vdmSourcePresentation [
	
	^ self vdmSourcePane presentations first
]

{ #category : #'building presentations' }
ViennaVDMDebugger >> vdmSourceWidgetIn: composite forContext: aContext [

	^ composite vdmSource
		title: 'VDM';
		format: [ aContext specification ifNotNil: #highlightedSource ifNil: [ Text new ] ]
]