Class {
	#name : #ViennaBrowser,
	#superclass : #Model,
	#instVars : [
		'vdmc',
		'modules',
		'state',
		'fieldListPane',
		'valuePane',
		'codePane',
		'selectedModule',
		'selectedField',
		'timeOfLastStateUpdate'
	],
	#category : 'ViennaTalk-Browser-Core'
}

{ #category : #'instance creation' }
ViennaBrowser class >> open [
	^ self openOn: VDMC vdmj
]

{ #category : #'instance creation' }
ViennaBrowser class >> openOn: aVDMC [ 
	^ self openOn: aVDMC withLabel: 'VDM Browser'
]

{ #category : #'instance creation' }
ViennaBrowser class >> openOn: aVDMC withLabel: label [
	^ self new
		vdmc: aVDMC;
		openLabel: label
]

{ #category : #'value pane menu' }
ViennaBrowser >> accept: aTextOrString [
	selectedModule
		ifNil: [ ^ false ]
		ifNotNil: [ :module | selectedField ifNil: [ ^ false ] ifNotNil: [ vdmc plainAt: module , '`' , selectedField put: aTextOrString asString ] ].
	self updateContents.
	^ true
]

{ #category : #toolbuilder }
ViennaBrowser >> buildCodePaneWith: builder [
	| textSpec |
	textSpec := builder pluggableTextSpec new.
	textSpec 
		model: self;
		name: #codePane;
		getText: #code; 
		setText: #code:notifying:; 
		selection: #contentsSelection; 
		menu: #codePaneMenu:shifted:;
		askBeforeDiscardingEdits: true.
	^textSpec
]

{ #category : #toolbuilder }
ViennaBrowser >> buildFieldListWith: builder [ 
	| listSpec |
	listSpec := builder pluggableListSpec new.
	listSpec model: self;
	      name: #fieldListPane;
		 list: #fieldList;
		 getIndex: #fieldSelectionIndex;
		 setIndex: #fieldSelectionIndex:;
		 menu: #fieldListMenu:;
		 dragItem: #dragFromFieldList:;
		 dropItem: #dropOnFieldList:at:;
		 keyPress: #inspectorKey:from:.
	^ listSpec
]

{ #category : #toolbuilder }
ViennaBrowser >> buildModuleListWith: builder [

	| listSpec |
	listSpec := builder pluggableListSpec new.
	listSpec 
		model: self;
		list: #moduleList; 
		getIndex: #moduleSelectionIndex; 
		setIndex: #moduleSelectionIndex:; 
		menu: #moduleListMenu:; 
		dragItem: #dragFromModuleList:;
		dropItem: #dropOnModuleList:at:;
		keyPress: #inspectorKey:from:.
	^listSpec
]

{ #category : #toolbuilder }
ViennaBrowser >> buildValuePaneWith: builder [ 
	| textSpec |
	textSpec := builder pluggableTextSpec new.
	textSpec model: self;
		 name: #valuePane;
		 getText: #contents;
		 setText: #accept:;
		 selection: #contentsSelection;
		 menu: #valuePaneMenu:shifted:.
	^ textSpec
]

{ #category : #toolbuilder }
ViennaBrowser >> buildWith: builder [
	| windowSpec window |
	windowSpec := self buildWindowWith: builder specs: {
		(0@0 corner: 0.38@0.38)  -> [self buildModuleListWith: builder].
		(0.38@0.0 corner: 0.62@0.38) -> [self buildFieldListWith: builder].
		(0.62@0.0 corner: 1@0.38) -> [self buildValuePaneWith: builder].
		(0.0@0.38 corner: 1@1) -> [self buildCodePaneWith: builder].
	}.
	window := builder build: windowSpec.
	fieldListPane := builder widgetAt: #fieldListPane.
	valuePane := builder widgetAt: #valuePane.
	codePane := builder widgetAt: #codePane.
	^ window
]

{ #category : #'code pane' }
ViennaBrowser >> code [
	| section module |
	vdmc ifNil: [ ^ String new ].
	module := self selectedModule.
	module ifNil: [ ^ vdmc specification ].
	section := ((self modulePositionsFrom: vdmc specification)
		detect: [ :assoc | assoc key = module ]
		ifNone: [ ^ String new ]) value.
	^ vdmc specification copyFrom: section first to: section last
]

{ #category : #'code pane' }
ViennaBrowser >> code: aString notifying: aMorph [
	vdmc
		ifNotNil: [ 
			| newModules oldModules source oldSpecification |
			newModules := Dictionary withAll: (self modulePositionsFrom: aString).
			oldModules := self modulePositionsFrom: vdmc specification.
			source := String new writeStream.
			source nextPutAll: (vdmc specification copyFrom: 1 to: oldModules first value first - 1).
			oldModules
				do: [ :assoc | 
					(newModules includesKey: assoc key)
						ifTrue: [ 
							| section |
							section := newModules at: assoc key.
							source nextPutAll: (aString copyFrom: section first to: section last).
							newModules removeKey: assoc key ]
						ifFalse: [ 
							| section |
							section := assoc value.
							source nextPutAll: (vdmc specification copyFrom: section first to: section last) ] ].
			(newModules associations asSortedCollection: [ :less :more | less value first < more value first ])
				do: [ :assoc | 
					| section |
					section := assoc value.
					source nextPutAll: (aString copyFrom: section first to: section last) ].
			oldSpecification := vdmc specification.
			vdmc specification: source contents.
			(vdmc plainEvaluate: 'nil')
				ifNil: [ 
					vdmc specification: oldSpecification.
					^ false ].
			self changed: #moduleList.
			self updateState.
			^ true ].
	^ false
]

{ #category : #'code pane menu' }
ViennaBrowser >> codePaneDoIt [
	self doItIn: codePane
]

{ #category : #'code pane menu' }
ViennaBrowser >> codePaneMenu: aMenu shifted: aBoolean [
	aMenu
		addList:
			{{('copy (c)' translated).
			#copySelection}.
			{('cut (x)' translated).
			#cut}.
			{('paste (v)' translated).
			#paste}.
			{('paste...' translated).
			#pasteRecent}.
			#-.
			{('find...(f)' translated).
			#find}.
			{('find again (g)' translated).
			#findAgain}.
			{('set search string (h)' translated).
			#setSearchString}.
			#-.
			{('undo (z)' translated).
			#undo}.
			#-.
			{('do it (d)' translated).
			#codePaneDoIt}.
			{('print it (p)' translated).
			#codePanePrintIt}.
			#-.
			{('accept (s)' translated).
			#accept}.
			{('cancel (l)' translated).
			#cancel}.
			#-.
			{('save contents to file...' translated).
			#saveContentsInFile}.
			#-.
			{('set font... (k)' translated).
			#offerFontMenu}.
			{('set style... (K)' translated).
			#changeStyle}.
			{('set alignment... (u)' translated).
			#chooseAlignment}}.
	^ aMenu
]

{ #category : #'code pane menu' }
ViennaBrowser >> codePanePrintIt [
	^ self printItIn: codePane
]

{ #category : #defaults }
ViennaBrowser >> defaultBackgroundColor [
	^ Color blue
]

{ #category : #private }
ViennaBrowser >> doItIn: aPluggableTextMorph [ 
	valuePane
		handleEdit: [| editor error |
			editor := aPluggableTextMorph textMorph editor.
			editor
				lineSelectAndEmptyCheck: [^ nil].
			error := nil.
			self
				evaluate: editor selectionAsStream upToEnd
				ifError: [:msg | error := msg].
			error
				ifNotNil: [| selectionInterval |
					selectionInterval := editor selectionInterval.
					aPluggableTextMorph textMorph installEditorToReplace: editor.
					aPluggableTextMorph textMorph
						handleEdit: [editor afterSelectionInsertAndSelect: error].
					selectionInterval := editor selectionInterval.
					aPluggableTextMorph textMorph editor selectFrom: selectionInterval first to: selectionInterval last.
					aPluggableTextMorph scrollSelectionIntoView]]
]

{ #category : #evaluation }
ViennaBrowser >> doItReceiver [
	^ nil
]

{ #category : #private }
ViennaBrowser >> evaluate: aString [ 
	^ self evaluate: aString ifError: [ :msg | msg ]
]

{ #category : #private }
ViennaBrowser >> evaluate: aString ifError: errorBlock [
	vdmc plainEvaluate: aString ifError: errorBlock
]

{ #category : #'field list' }
ViennaBrowser >> fieldList [
	^ state
		ifNil: [Array new]
		ifNotNil: [:s | s
				collect: [:fieldAndValue | fieldAndValue key]]
]

{ #category : #'field list' }
ViennaBrowser >> fieldSelectionIndex [
	^ self fieldList indexOf: self selectedField
]

{ #category : #'field list' }
ViennaBrowser >> fieldSelectionIndex: anInteger [
	self selectFieldNamed: (self fieldList at: anInteger ifAbsent: [])
]

{ #category : #'initialize-release' }
ViennaBrowser >> initialize [
	super initialize.
	timeOfLastStateUpdate := Time millisecondClockValue
]

{ #category : #'module list' }
ViennaBrowser >> moduleList [
	^ vdmc ifNil: [ Array new ] ifNotNil: [ (self modulePositionsFrom: vdmc specification) collect: #key ]
]

{ #category : #'module list menu' }
ViennaBrowser >> moduleListMenu: aMenu [ 
	| referenceSubMenu |
	aMenu add: 'remove module' translated action: #removeModule.
	aMenu addLine.
	referenceSubMenu := MenuMorph new defaultTarget: self.
	self referringModules
		do: [:name | referenceSubMenu
				add: name
				selector: #selectModuleNamed:
				argument: name].
	referenceSubMenu hasItems
		ifTrue: [aMenu add: 'referring modules...' translated subMenu: referenceSubMenu].
	^ aMenu
]

{ #category : #private }
ViennaBrowser >> modulePositionsFrom: aString [ 
	"| modulePositions whiteSpec mark |
	modulePositions := Array new writeStream.
	whiteSpec := (vdmj whiten: aString) readStream.
	mark := nil.
	[| newMark |
	[(whiteSpec skipTo: $m)
		ifFalse: [mark
				ifNil: [modulePositions nextPut: vdmj globalModuleName
							-> (1 to: aString size)]
				ifNotNil: [modulePositions nextPut: mark key
							-> (mark value to: whiteSpec position)].
			^ modulePositions contents].
	(whiteSpec next: 'odule' size)
		= 'odule'] whileFalse.
	newMark := whiteSpec position - 'module' size + 1.
	mark
		ifNotNil: [modulePositions nextPut: mark key
					-> (mark value to: newMark - 1)].
	whiteSpec skipSeparators.
	String new writeStream
		in: [:name | 
			[whiteSpec atEnd not
				and: [whiteSpec peek isSeparator not]]
				whileTrue: [name nextPut: whiteSpec next].
			mark := name contents -> newMark]] repeat"
]

{ #category : #'module list' }
ViennaBrowser >> moduleSelectionIndex [
	^ self moduleList indexOf: self selectedModule
]

{ #category : #'module list' }
ViennaBrowser >> moduleSelectionIndex: anInteger [ 
	^ self
		selectModuleNamed: (self moduleList
				at: anInteger
				ifAbsent: [])
]

{ #category : #private }
ViennaBrowser >> printItIn: aPluggableTextMorph [ 
	aPluggableTextMorph
		handleEdit: [| editor result selectionInterval |
			editor := aPluggableTextMorph textMorph editor.
			editor
				lineSelectAndEmptyCheck: [^ nil].
			result := self evaluate: editor selectionAsStream upToEnd.
			selectionInterval := editor selectionInterval.
			aPluggableTextMorph textMorph installEditorToReplace: editor.
			aPluggableTextMorph textMorph
				handleEdit: [editor afterSelectionInsertAndSelect: result].
			selectionInterval := editor selectionInterval.
			aPluggableTextMorph textMorph editor selectFrom: selectionInterval first to: selectionInterval last.
			aPluggableTextMorph scrollSelectionIntoView]
]

{ #category : #'module list menu' }
ViennaBrowser >> referringModules [
	| parser |
	self selectedModule isNil
		ifTrue: [ ^ Array new ].
	parser := 'from' asParser , #space asParser plus , self selectedModule asParser , #space asParser.
	^ ((self modulePositionsFrom: vdmc specification)
		select: [ :assoc | 
			assoc key ~= self selectedModule
				and: [ (parser matchesIn: (vdmc specification copyFrom: assoc value first to: assoc value last)) notEmpty ] ])
		collect: [ :assoc | assoc key ]
]

{ #category : #'module list menu' }
ViennaBrowser >> removeModule [
	self selectedModule
		in: [ :moduleName | 
			| position newSpecification oldSpecification |
			moduleName ifNil: [ ^ false ].
			position := ((self modulePositionsFrom: vdmc specification)
				detect: [ :assoc | assoc key = moduleName ]
				ifNone: [ ^ false ]) value.
			newSpecification := (vdmc specification copyFrom: 1 to: position first - 1)
				, (vdmc specification copyFrom: position last + 1 to: vdmc specification size).
			oldSpecification := vdmc specification.
			vdmc specification: newSpecification.
			vdmc
				plainEvaluate: 'nil'
				ifError: [ :msg | 
					vdmc specification: oldSpecification.
					UIManager default abort: msg title: 'VDM Error'.
					^ false ] ]
]

{ #category : #'field list' }
ViennaBrowser >> selectFieldNamed: aString [ 
	selectedField := (self fieldList includes: aString)
				ifTrue: [aString].
	self updateContents.
	self changed: #fieldSelectionIndex.
	self changed: #contents
]

{ #category : #'module list' }
ViennaBrowser >> selectModuleNamed: aString [ 
	selectedModule := (self moduleList includes: aString)
				ifTrue: [aString].
	self updateState.
	selectedField := nil.
	self updateContents.
	self changed: #fieldList.
	self changed: #fieldSelectionIndex.
	self changed: #code.
	self changed: #moduleSelectionIndex
]

{ #category : #'field list' }
ViennaBrowser >> selectedField [
	^ selectedField
]

{ #category : #'module list' }
ViennaBrowser >> selectedModule [
	^ selectedModule
]

{ #category : #stepping }
ViennaBrowser >> stepAt: millisecondClockValue in: aWindow [
	millisecondClockValue - self timeOfLastStateUpdate > (1000.0 / self updateFrequency)
		ifTrue: [ 
			self updateState.
			self updateContents.
			timeOfLastStateUpdate := millisecondClockValue ]
]

{ #category : #stepping }
ViennaBrowser >> stepTime [
	^ 10
]

{ #category : #stepping }
ViennaBrowser >> stepTimeIn: aMorph [
	^ self stepTime
]

{ #category : #stepping }
ViennaBrowser >> timeOfLastStateUpdate [
	^ timeOfLastStateUpdate
		ifNil: [Time millisecondClockValue]
]

{ #category : #'value pane' }
ViennaBrowser >> updateContents [
	| newContents |
	newContents := (selectedField
		ifNotNil: [ 
			(state detect: [ :fieldAndValue | fieldAndValue key = selectedField ] ifNone: [  ])
				ifNotNil: [ :fieldAndValue | fieldAndValue value ] ])
		ifNil: [ 
			selectedModule
				ifNil: [ String new ]
				ifNotNil: [ :module | 
					| content |
					content := String new writeStream.
					content nextPut: ${.
					state
						do: [ :nameAndValue | 
							content
								nextPut: $';
								nextPutAll: nameAndValue key;
								nextPut: $';
								nextPutAll: ' -> ';
								nextPut: $';
								nextPutAll: nameAndValue value;
								nextPut: $' ]
						separatedBy: [ 
							content
								space;
								nextPut: $.;
								cr ].
					content nextPut: $}.
					content contents ] ].
	newContents ~= vdmc specification
		ifTrue: [ 
			vdmc specification: newContents.
			self changed: #contents ]
]

{ #category : #stepping }
ViennaBrowser >> updateFrequency [
	^ 10.0
]

{ #category : #private }
ViennaBrowser >> updateState [
	"| newState |
	newState := (vdmj
				ifNotNil: [selectedModule
						ifNotNil: [vdmj stateAt: selectedModule]])
				ifNil: [Array new].
	newState ~= state
		ifTrue: [state := newState.
			self updateContents.
			self changed: #moduleList.
			self changed: #moduleSelectionIndex.
			self changed: #fieldList.
			self changed: #fieldSelectionIndex.
			self changed: #contents.
			self changed: #state]"
]

{ #category : #'value pane menu' }
ViennaBrowser >> valuePaneAccept [
	^ self accept: valuePane text asString
]

{ #category : #'value pane menu' }
ViennaBrowser >> valuePaneDoIt [
	self doItIn: valuePane
]

{ #category : #'value pane menu' }
ViennaBrowser >> valuePaneMenu: aMenu shifted: aBoolean [
	aMenu addList: (aBoolean = true 
		ifTrue:[{
			#-.
			{'save contents to file...' translated.		#saveContentsInFile}.
			{'send contents to printer' translated.		#sendContentsToPrinter}.
			{'printer setup' translated.				#printerSetup}.
			#-.
		}.]
		ifFalse:[{
			{'set font... (k)' translated.				#offerFontMenu}.
			{'set style... (K)' translated.				#changeStyle}.
			{'set alignment... (u)' translated.		#chooseAlignment}.
			#-.
			{'make project link (P)' translated.	#makeProjectLink}.
			#-.
			{'find...(f)' translated.					#find}.
			{'find again (g)' translated.				#findAgain}.
			{'set search string (h)' translated.		#setSearchString}.
			#-.
			{'do again (j)' translated.				#again}.
			{'undo (z)' translated.					#undo}.
			#-.
			{'copy (c)' translated.					#copySelection}.
			{'cut (x)' translated.						#cut}.
			{'paste (v)' translated.					#paste}.
			{'paste...' translated.					#pasteRecent}.
			#-.
			{'do it (d)' translated.		#valuePaneDoIt}.			     
			{'print it (p)' translated.		#valuePanePrintIt}.
			#-.
			{'accept (s)' translated.					#valuePaneAccept}.
			{'cancel (l)' translated.					#valuePaneCancel}.
			#-.
			{'copy html' translated.					#copyHtml}.
			#-.
			{'more...' translated.					#shiftedTextPaneMenuRequest}.
		}]).
	^aMenu
]

{ #category : #'value pane menu' }
ViennaBrowser >> valuePanePrintIt [
	^ self printItIn: valuePane
]

{ #category : #accessing }
ViennaBrowser >> vdmc [
	^ vdmc
]

{ #category : #accessing }
ViennaBrowser >> vdmc: aVDMC [
	vdmc := aVDMC
]

{ #category : #stepping }
ViennaBrowser >> wantsSteps [
	^ true
]
