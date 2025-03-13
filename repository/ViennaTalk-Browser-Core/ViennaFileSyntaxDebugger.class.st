Class {
	#name : 'ViennaFileSyntaxDebugger',
	#superclass : 'SpPresenter',
	#instVars : [
		'fileList',
		'sourceText',
		'redIcon',
		'greenIcon',
		'fileReference',
		'highlighterProcess',
		'signalsCache',
		'removeButton',
		'addButton'
	],
	#category : 'ViennaTalk-Browser-Core-Browsers',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'Browsers'
}

{ #category : 'instance creation' }
ViennaFileSyntaxDebugger class >> on: aFileReference [

	^ self new fileReference: aFileReference
]

{ #category : 'instance creation' }
ViennaFileSyntaxDebugger class >> openOn: aFileReference [

	<script:
	'(UIManager default chooseDirectory: ''Directory to open'' from: FileLocator viennaTalkDocumentDirectory) ifNotNil: [ :dir | ViennaFileSyntaxDebugger openOn: dir ]'>
	^ (self on: aFileReference) open
]

{ #category : 'operations' }
ViennaFileSyntaxDebugger >> accept: aString [

	fileList selectedItem ifNotNil: [ :fileRef |
		fileRef
			ensureDelete;
			writeStreamDo: [ :stream |
				stream nextPutAll: (aString asString asString withLineEndings:
								 OSPlatform current lineEnding) ].
		self flushSignalCache: fileRef.
		fileList refresh ]
]

{ #category : 'operations' }
ViennaFileSyntaxDebugger >> addFile [

	fileReference isDirectory ifTrue: [
		((self
			  request: 'File name to create'
			  initialAnswer: ''
			  title: 'File Syntax Debugger') ifNotNil: #trim) ifNotNil: [ :name |
			| newBasename |
			newBasename := (fileReference / name withExtension: 'vdmsl')
				               ensureCreateFile;
				               basename.
			self updateFileList.
			fileList selectItem: (fileList items
					 detect: [ :ref | ref basename = newBasename ]
					 ifNone: [  ]) ] ]
]

{ #category : 'private' }
ViennaFileSyntaxDebugger >> confirm: queryString label: titleString [

	^ self application newConfirm
		  title: titleString;
		  label: queryString;
		  openModal
]

{ #category : 'layout' }
ViennaFileSyntaxDebugger >> defaultLayout [

	^ SpPanedLayout newHorizontal
		  positionOfSlider: 0.3;
		  add: (SpBoxLayout newVertical
				   add: fileList;
				   add: (SpBoxLayout newHorizontal
						    add: addButton width: self class buttonHeight;
						    add: removeButton width: self class buttonHeight;
						    yourself)
				   expand: false;
				   yourself);
		  add: sourceText;
		  yourself
]

{ #category : 'accessing' }
ViennaFileSyntaxDebugger >> fileReference [

	^ fileReference
]

{ #category : 'accessing' }
ViennaFileSyntaxDebugger >> fileReference: aFileReference [

	fileReference := aFileReference.
	self fileReferenceChanged
]

{ #category : 'updating' }
ViennaFileSyntaxDebugger >> fileReferenceChanged [

	self
		updateFileList;
		updateButtons
]

{ #category : 'private' }
ViennaFileSyntaxDebugger >> flushSignalCache: aFileReference [

	signalsCache removeKey: aFileReference ifAbsent: [  ]
]

{ #category : 'accessing' }
ViennaFileSyntaxDebugger >> greenIcon [

	^ greenIcon ifNil: [
		  greenIcon := Form extent: 12 @ 12 depth: 32.
		  greenIcon getCanvas
			  fillColor: Color transparent;
			  fillOval: (1 @ 0 extent: 12 @ 12)
			  color: Color green
			  borderWidth: 1
			  borderColor: Color green darker.
		  greenIcon ]
]

{ #category : 'operations' }
ViennaFileSyntaxDebugger >> highlightSourceText [

	highlighterProcess ifNotNil: [
		highlighterProcess terminate.
		highlighterProcess := nil ].
	highlighterProcess := [
	                      | source highlighter context result |
	                      source := sourceText text asString asString
		                                copy.
	                      highlighter := ViennaVDMHighlighter new.
	                      highlighter text: source asText.
	                      context := ViennaPP2HighlightingContext new.
	                      (result := highlighter
		                                 parse: source
		                                 withContext: context)
		                      isPetit2Failure ifTrue: [
		                      highlighter text
			                      makeColor: Color red
			                      from:
			                      (result furthestPosition - 1
				                       min: source size
				                       max: 1)
			                      to: source size ].
	                      source size = highlighter text runs size
		                      ifTrue: [
			                      sourceText withAdapterDo: [ :a |
				                      a widgetDo: [ :w |
					                      w text runs: highlighter text runs.
					                      w changed ] ] ].
	                      highlighterProcess := nil ] forkAt:
		                      Processor userBackgroundPriority
]

{ #category : 'initialization' }
ViennaFileSyntaxDebugger >> initialize [

	super initialize.
	signalsCache := Dictionary new
]

{ #category : 'initialization' }
ViennaFileSyntaxDebugger >> initializePresenters [

	fileList := self newTable
		            addColumn: (SpImageTableColumn
				             title: ''
				             evaluated: [ :fileRef | self signalIconFor: fileRef ])
				            beNotExpandable;
		            addColumn: (SpStringTableColumn
				             title: 'name'
				             evaluated: [ :fileRef | fileRef basename ])
				            beExpandable;
		            whenSelectionChangedDo: [ self selectedFileChanged ];
		            yourself.
	addButton := self newButton
		             icon: (self iconNamed: #add);
		             action: [ self addFile ];
		             yourself.
	removeButton := self newButton
		                icon: (self iconNamed: #remove);
		                action: [ self removeFile ];
		                yourself.
	sourceText := self newVDMSource
		              whenTextChangedDo: [ self highlightSourceText ];
		              whenSubmitDo: [ :text | self accept: text ];
		              yourself
]

{ #category : 'initialization' }
ViennaFileSyntaxDebugger >> initializeWindow: aSpWindowPresenter [

	super initializeWindow: aSpWindowPresenter.
	aSpWindowPresenter
		initialExtent: 800 @ 600;
		title: 'Syntax Debugger'
]

{ #category : 'accessing' }
ViennaFileSyntaxDebugger >> redIcon [

	^ redIcon ifNil: [
		  redIcon := Form extent: 12 @ 12 depth: 32.
		  redIcon getCanvas
			  fillColor: Color transparent;
			  fillOval: (1 @ 0 extent: 12 @ 12)
			  color: Color red
			  borderWidth: 1
			  borderColor: Color red darker.
		  redIcon ]
]

{ #category : 'operations' }
ViennaFileSyntaxDebugger >> removeFile [

	fileList selectedItem ifNotNil: [ :ref |
		(self
			 confirm: 'Remove ' , ref basename , '?'
			 label: 'File Syntax Debugger') ifTrue: [
			ref ensureDelete.
			self updateFileList ] ]
]

{ #category : 'updating' }
ViennaFileSyntaxDebugger >> selectedFileChanged [

	self
		updateSourceText;
		updateButtons
]

{ #category : 'accessing' }
ViennaFileSyntaxDebugger >> signalIconFor: aFileReference [

	^ (aFileReference isFile and: [
		   signalsCache at: aFileReference ifAbsentPut: [
			   (ViennaVDMParser current document end parse:
				    aFileReference contents) isPetit2Success ] ])
		  ifTrue: [ self greenIcon ]
		  ifFalse: [ self redIcon ]
]

{ #category : 'updating' }
ViennaFileSyntaxDebugger >> updateButtons [

	addButton enabled: fileReference isDirectory.
	removeButton enabled:
		(fileReference isDirectory and: [ fileList selectedItem notNil ])
]

{ #category : 'updating' }
ViennaFileSyntaxDebugger >> updateFileList [

	fileReference isDirectory ifTrue: [
		fileList
			items: ((fileReference filesMatching: '*.vdmsl') sorted: #basename ascending).
		^ self ].
	fileReference isFile ifTrue: [
		fileList items: { fileReference }.
		^ self ].
	fileList items: {  }
]

{ #category : 'updating' }
ViennaFileSyntaxDebugger >> updateSourceText [

	sourceText text: (fileList selectedItem
			 ifNil: [ Text new ]
			 ifNotNil: [ :fileRef | fileRef contents ])
]
