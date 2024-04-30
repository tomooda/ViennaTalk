Class {
	#name : 'ViennaBrowser',
	#superclass : 'Model',
	#instVars : [
		'cachedSpec',
		'cachedModulePositions',
		'moduleListPane',
		'fieldListPane',
		'valuePane',
		'codePane',
		'workspace',
		'workspacePane',
		'testPane',
		'selectedModule',
		'selectedField',
		'codeSelection',
		'valueSelection',
		'workspaceSelection',
		'testSelectionIndex',
		'directory',
		'lowerTabPane',
		'animation',
		'testResult',
		'testProcess',
		'testLabelIcon',
		'testLabel'
	],
	#classVars : [
		'AutoFormat',
		'AutoFullTest',
		'AutoTest'
	],
	#category : 'ViennaTalk-Browser-Core-Browsers',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'Browsers'
}

{ #category : 'accessing' }
ViennaBrowser class >> autoFormat [
	^ AutoFormat ifNil: [ AutoFormat := true ]
]

{ #category : 'accessing' }
ViennaBrowser class >> autoFormat: aBoolean [
	AutoFormat := aBoolean ~= false
]

{ #category : 'accessing' }
ViennaBrowser class >> autoFullTest [
	^ AutoFullTest ifNil: [ AutoFullTest := false ]
]

{ #category : 'accessing' }
ViennaBrowser class >> autoFullTest: aBoolean [
	AutoFullTest := true == aBoolean
]

{ #category : 'accessing' }
ViennaBrowser class >> autoTest [
	^ AutoTest ifNil: [ AutoTest := false ]
]

{ #category : 'accessing' }
ViennaBrowser class >> autoTest: aBoolean [
	AutoTest := true == aBoolean
]

{ #category : 'menu' }
ViennaBrowser class >> codePaneMenu: aBuilder [

	<contextMenu>
	<viennaBrowserCodePaneMenu>
	(aBuilder item: #'Find...' translated)
		keyText: 'f';
		selector: #find;
		icon: (self iconNamed: #smallFindIcon).
	(aBuilder item: #'Find again' translated)
		keyText: 'g';
		selector: #findAgain;
		icon: (self iconNamed: #smallFindIcon).
	(aBuilder item: #'Set search string' translated)
		keyText: 'h';
		selector: #setSearchString;
		withSeparatorAfter.
	(aBuilder item: #'Do again' translated)
		keyText: 'j';
		selector: #again;
		icon: (self iconNamed: #smallRedoIcon).
	(aBuilder item: #Undo translated)
		keyText: 'z';
		selector: #undo;
		icon: (self iconNamed: #smallUndoIcon);
		withSeparatorAfter.
	(aBuilder item: #Copy translated)
		keyText: 'c';
		selector: #copySelection;
		icon: (self iconNamed: #smallCopyIcon).
	(aBuilder item: #Cut translated)
		keyText: 'x';
		selector: #cut;
		icon: (self iconNamed: #smallCutIcon).
	(aBuilder item: #Paste translated)
		keyText: 'v';
		selector: #paste;
		icon: (self iconNamed: #smallPasteIcon).
	(aBuilder item: #'Paste...' translated)
		selector: #pasteRecent;
		icon: (self iconNamed: #smallPasteIcon);
		withSeparatorAfter.
	aBuilder model otherModules ifNotEmpty: [ :modules |
		(aBuilder
			 item: #'Insert module...' translated;
			 withSeparatorAfter) with: [
			modules do: [ :module |
				(aBuilder item: module asSymbol)
					selector: #insertModuleSource:;
					arguments: (Array with: module asString) ] ] ].
	(aBuilder item: #Format translated)
		keyText: 'F';
		selector: #prettyPrint;
		withSeparatorAfter.
	(aBuilder item: #'Do it' translated)
		keyText: 'd';
		selector: #codePaneDoIt.
	(aBuilder item: #'Print it' translated)
		keyText: 'p';
		selector: #codePanePrintIt;
		withSeparatorAfter.
	(aBuilder item: #Accept translated)
		keyText: 's';
		selector: #accept.
	(aBuilder item: #Cancel translated)
		keyText: 'l';
		selector: #cancel
]

{ #category : 'defaults' }
ViennaBrowser class >> defaultFormatWidth [
	^ 65
]

{ #category : 'defaults' }
ViennaBrowser class >> defaultLabel [
	^ 'VDM Browser'
]

{ #category : 'class initialization' }
ViennaBrowser class >> initialize [
	self installEventHandlers.
	Smalltalk at: #ViennaLauncher ifPresent: [ :launcherClass | launcherClass reopen ]
]

{ #category : 'class initialization' }
ViennaBrowser class >> installEventHandlers [

	ExternalDropHandler registerHandler: (ExternalDropHandler
			 type: nil
			 extension: 'vdmsl'
			 action: [ :stream :pasteUp :event |
				 (ViennaBrowser on: ViennaAnimation default)
					 openLabel: stream fullName;
					 acceptCode: stream contents ])
]

{ #category : 'menu' }
ViennaBrowser class >> moduleListMenu: aBuilder [

	<contextMenu>
	<viennaBrowserModuleListMenu>
	(aBuilder item: #'load snapshot...' translated) selector:
		#loadSnapshotFromFile.
	(aBuilder item: #'new and load...' translated) selector:
		#newAndLoadFromFile.
	(aBuilder item: #'load and merge...' translated) selector:
		#loadAndMergeFromFile.
	(aBuilder item: #'save snapshot...' translated) selector:
		#saveSnapshotToFile.
	(aBuilder item: #'save all modules...' translated) selector:
		#saveAllModulesToFile.
	aBuilder model selectedModule ifNotNil: [ 
		(aBuilder item: #'save the module...' translated) selector:
			#saveAModuleToFile ].
	aBuilder items last withSeparatorAfter.
	(aBuilder item: #'generate ViennaDoc source script...' translated) 
		selector: #generateViennaDocSourceScript.
	aBuilder items last withSeparatorAfter.
	(aBuilder model moduleList includes: 'UnitTesting') ifFalse: [ 
		(aBuilder item: #'import UnitTesting module' translated) selector:
			#importUnitTestingModule ].
	(aBuilder model moduleList includes: 'ViennaDOM') ifFalse: [ 
		(aBuilder item: #'import ViennaDOM module' translated) selector:
			#importViennaDOMModule ].
	aBuilder items last withSeparatorAfter.
	(aBuilder item: #'remove module' translated)
		selector: #removeModule;
		withSeparatorAfter.
	(aBuilder item: #'merge operations from FRAM...' translated) 
		selector: #mergeOperationsFromFRAM.
	(aBuilder item: #'merge annotations into FRAM...' translated)
		selector: #mergeAnnotationsIntoFRAM;
		withSeparatorAfter.
	(Smalltalk globals
		 at: #WeblyWalkThrough
		 ifPresent: [ :webly | aBuilder model animation class = webly ]
		 ifAbsent: [ false ]) ifFalse: [ 
		aBuilder model animation class = ViennaTranspiledAnimation
			ifTrue: [ 
				(aBuilder item: #'use interpreter' translated)
					selector: #useInterpreter;
					withSeparatorAfter ]
			ifFalse: [ 
				(aBuilder item: #'use transpiler' translated)
					selector: #useTranspiler;
					withSeparatorAfter ] ].
	(aBuilder item:
		 #'generate a Smalltalk script (single module)...' translated) 
		selector: #generateSmalltalkScript.
	(aBuilder item: #'generate classes (all modules)...' translated) 
		selector: #generateSmalltalkClasses.
	(aBuilder item: #'generate object (all modules)...' translated)
		selector: #generateSmalltalkObject;
		withSeparatorAfter.
	(aBuilder item: #'run module test' translated) selector:
		#runTestModule.
	(aBuilder item: #'run tests' translated)
		selector: #runAllTests;
		withSeparatorAfter.
	aBuilder model importerModules ifNotEmpty: [ :modules | 
		(aBuilder item: #'imported by...' translated) with: [ 
			modules do: [ :module | 
				(aBuilder item: module asSymbol)
					selector: #selectModuleNamed:;
					arguments: (Array with: module asString) ] ] ]
]

{ #category : 'instance creation' }
ViennaBrowser class >> on: aViennaAnimation [
	^ self new animation: aViennaAnimation
]

{ #category : 'instance creation' }
ViennaBrowser class >> open [
	"ViennaBrowser open"

	^ self openOn: ViennaAnimation default
]

{ #category : 'instance creation' }
ViennaBrowser class >> openOn: aViennaAnimation [
	^ self openOn: aViennaAnimation withLabel: self defaultLabel
]

{ #category : 'instance creation' }
ViennaBrowser class >> openOn: aViennaAnimation withLabel: label [
	^ (self on: aViennaAnimation) openLabel: label
]

{ #category : 'menu' }
ViennaBrowser class >> testPaneMenu: aBuilder [
	<contextMenu>
	<viennaBrowserTestPaneMenu>
	(aBuilder item: #jump translated) selector: #jumpToSpec
]

{ #category : 'menu' }
ViennaBrowser class >> valuePaneMenu: aBuilder [

	<contextMenu>
	<viennaBrowserValuePaneMenu>
	(aBuilder item: #'Find...' translated)
		keyText: 'f';
		selector: #find;
		icon: (self iconNamed: #smallFindIcon).
	(aBuilder item: #'Find again' translated)
		keyText: 'g';
		selector: #findAgain;
		icon: (self iconNamed: #smallFindIcon).
	(aBuilder item: #'Set search string' translated)
		keyText: 'h';
		selector: #setSearchString;
		withSeparatorAfter.
	(aBuilder item: #'Do again' translated)
		keyText: 'j';
		selector: #again;
		icon: (self iconNamed: #smallRedoIcon).
	(aBuilder item: #Undo translated)
		keyText: 'z';
		selector: #undo;
		icon: (self iconNamed: #smallUndoIcon);
		withSeparatorAfter.
	(aBuilder item: #Copy translated)
		keyText: 'c';
		selector: #copySelection;
		icon: (self iconNamed: #smallCopyIcon).
	(aBuilder item: #Cut translated)
		keyText: 'x';
		selector: #cut;
		icon: (self iconNamed: #smallCutIcon).
	(aBuilder item: #Paste translated)
		keyText: 'v';
		selector: #paste;
		icon: (self iconNamed: #smallPasteIcon).
	(aBuilder item: #'Paste...' translated)
		selector: #pasteRecent;
		icon: (self iconNamed: #smallPasteIcon);
		withSeparatorAfter.
	(aBuilder item: #'Do it' translated)
		keyText: 'd';
		selector: #valuePaneDoIt.
	(aBuilder item: #'Print it' translated)
		keyText: 'p';
		selector: #valuePanePrintIt;
		withSeparatorAfter.
	(aBuilder item: #Accept translated)
		keyText: 's';
		selector: #accept.
	(aBuilder item: #Cancel translated)
		keyText: 'l';
		selector: #cancel
]

{ #category : 'settings' }
ViennaBrowser class >> viennaSettingsOn: aBuilder [
	<systemsettings>
	(aBuilder group: #ViennaTalkUnitTesting)
		parent: #ViennaTalk;
		label: 'Unit Testing';
		with: [ (aBuilder setting: #autoTest)
				target: self;
				getSelector: #autoTest;
				setSelector: #autoTest:;
				description: 'If checked, then VDMBrowser will automatically run unit testing.';
				label: 'Auto unit testing in VDM Browser';
				order: 0.501;
				with: [ (aBuilder setting: #autoFullTest)
						target: self;
						getSelector: #autoFullTest;
						setSelector: #autoFullTest:;
						description: 'If checked, then VDMBrowser will automatically run all test modules.';
						label: 'full tests';
						order: 0.501 ] ].
	(aBuilder setting: #autoFormat)
		parent: #ViennaTalkAppearances;
		target: self;
		getSelector: #autoFormat;
		setSelector: #autoFormat:;
		description: 'If checked, then VDMBrowser will automatically format the VDM source.';
		label: 'Auto format in VDM Browser';
		order: 0.50
]

{ #category : 'world menu' }
ViennaBrowser class >> viennaToolsMenuOn: aBuilder [
	<ViennaToolsMenu>
	(aBuilder item: #'VDM Browser')
		action: [ self open ];
		order: 0.11;
		help: 'VDM-SL browser';
		icon: nil
]

{ #category : 'menu' }
ViennaBrowser class >> workspacePaneMenu: aBuilder [

	<contextMenu>
	<viennaBrowserWorkspacePaneMenu>
	(aBuilder item: #'Find...' translated)
		keyText: 'f';
		selector: #find;
		icon: (self iconNamed: #smallFindIcon).
	(aBuilder item: #'Find again' translated)
		keyText: 'g';
		selector: #findAgain;
		icon: (self iconNamed: #smallFindIcon).
	(aBuilder item: #'Set search string' translated)
		keyText: 'h';
		selector: #setSearchString;
		withSeparatorAfter.
	(aBuilder item: #'Do again' translated)
		keyText: 'j';
		selector: #again;
		icon: (self iconNamed: #smallRedoIcon).
	(aBuilder item: #Undo translated)
		keyText: 'z';
		selector: #undo;
		icon: (self iconNamed: #smallUndoIcon);
		withSeparatorAfter.
	(aBuilder item: #Copy translated)
		keyText: 'c';
		selector: #copySelection;
		icon: (self iconNamed: #smallCopyIcon).
	(aBuilder item: #Cut translated)
		keyText: 'x';
		selector: #cut;
		icon: (self iconNamed: #smallCutIcon).
	(aBuilder item: #Paste translated)
		keyText: 'v';
		selector: #paste;
		icon: (self iconNamed: #smallPasteIcon).
	(aBuilder item: #'Paste...' translated)
		selector: #pasteRecent;
		icon: (self iconNamed: #smallPasteIcon);
		withSeparatorAfter.
	(aBuilder item: #'Do it' translated)
		keyText: 'd';
		selector: #workspacePaneDoIt.
	(aBuilder item: #'Print it' translated)
		keyText: 'p';
		selector: #workspacePanePrintIt;
		withSeparatorAfter.
	(aBuilder item: #Accept translated)
		keyText: 's';
		selector: #accept.
	(aBuilder item: #Cancel translated)
		keyText: 'l';
		selector: #cancel
]

{ #category : 'world menu' }
ViennaBrowser class >> worldMenuOn: aBuilder [

	<worldMenu>
	(aBuilder item: #'VDM Browser')
		parent: #ViennaTalk;
		action: [ self open ];
		order: 0.11;
		help: 'VDM-SL browser';
		icon: nil
]

{ #category : 'value pane' }
ViennaBrowser >> accept: aString var: varName [
	| oldValue |
	oldValue := animation plainAt: varName ifAbsent: [ ^ false ].
	animation plainAt: varName put: aString.
	animation
		plainEvaluate: 'nil'
		ifError: [ :msg | 
			valuePane
				handleEdit: [ 
					valuePane textMorph editor
						selectFrom: aString size to: aString size - 1;
						afterSelectionInsertAndSelect: msg ].
			animation plainAt: varName put: oldValue.
			^ false ].
	animation changed: #state.
	^ true
]

{ #category : 'value pane' }
ViennaBrowser >> accept: aString var: varName in: moduleName [
	| key oldValue |
	key := moduleName , '`' , varName.
	oldValue := animation plainAt: key ifAbsent: [ ^ false ].
	animation plainAt: key put: aString.
	animation
		plainEvaluate: 'nil'
		ifError: [ :msg | 
			valuePane
				handleEdit: [ 
					valuePane textMorph editor
						selectFrom: aString size to: aString size - 1;
						afterSelectionInsertAndSelect: msg ].
			animation plainAt: key put: oldValue.
			^ false ].
	animation changed: #state.
	^ true
]

{ #category : 'value pane' }
ViennaBrowser >> acceptBindings: aString in: moduleName [
	| newBindings oldBindings prefix |
	newBindings := self
		parseBindings: aString
		ifError: [ :pos :msg | 
			valuePane
				handleEdit: [ 
					valuePane textMorph editor
						selectFrom: pos to: pos - 1;
						afterSelectionInsertAndSelect: msg ].
			^ false ].
	oldBindings := animation state copy.
	prefix := moduleName , '`'.
	newBindings do: [ :assoc | animation plainAt: prefix , assoc key put: assoc value ].
	animation
		plainEvaluate: 'nil'
		ifError: [ :msg | 
			valuePane
				handleEdit: [ 
					valuePane textMorph editor
						selectFrom: aString size to: aString size - 1;
						afterSelectionInsertAndSelect: msg ].
			oldBindings keysAndValuesDo: [ :key :value | animation plainAt: key put: value ].
			^ false ].
	animation changed: #state.
	^ true
]

{ #category : 'code pane' }
ViennaBrowser >> acceptCode: aStringOrText [
	^ self acceptCode: aStringOrText newModuleAndSourceDo: nil
]

{ #category : 'code pane' }
ViennaBrowser >> acceptCode: aStringOrText newModuleAndSourceDo: aBlock [

	self animation ifNotNil: [
		| code oldModulePositions newModulePositions newModuleNames oldSpec newSpec |
		code := (self autoFormat
			         ifTrue: [
				         (ViennaVDMParser current format: aStringOrText) in: [
					         :formatted |
					         formatted isPetit2Failure
						         ifTrue: [ aStringOrText ]
						         ifFalse: [ formatted ] ] ]
			         ifFalse: [ aStringOrText ]) asString trimmed copyWith:
			        Character cr.
		oldSpec := self animation specification.
		oldModulePositions := self modulePositionsFrom: oldSpec.
		newModulePositions := self modulePositionsFrom: code.
		newModuleNames := (newModulePositions collect: #key) asSet.
		newSpec := String new: 1024 streamContents: [ :stream |
			           stream nextPutAll: code.
			           oldModulePositions do: [ :assoc |
				           (newModuleNames includes: assoc key) ifFalse: [
					           stream nextPutAll:
						           (oldSpec
							            copyFrom: assoc value first
							            to: assoc value last) ] ] ].
		codePane hasUnacceptedEdits: false.
		(self animation specification: newSpec ifError: [ nil ]) ifNil: [
			self animation state: Dictionary new.
			self animation specification: newSpec ifError: [ :msg |
				| posStrIndex charPos message |
				charPos := 0.
				message := msg.
				posStrIndex := msg
					               findLastOccurrenceOfString: 'at line '
					               startingAt: 1.
				posStrIndex > 0 ifTrue: [
					| colonIndex |
					colonIndex := msg indexOf: $: startingAt: posStrIndex + 9.
					colonIndex > 0 ifTrue: [
						| linePos colPos lines |
						message := msg copyFrom: 1 to: posStrIndex - 1.
						(message includes: $() ifTrue: [
							message := message
								           copyFrom: 1
								           to:
								           (message
									            findLastOccurrenceOfString: ' ('
									            startingAt: 1) ].
						linePos := (msg copyFrom: posStrIndex + 8 to: colonIndex - 1)
							           asInteger.
						colPos := (msg copyFrom: colonIndex + 1 to: msg size) asInteger.
						lines := code lines.
						linePos <= lines size ifTrue: [
							charPos := (((lines copyFrom: 1 to: linePos - 1) collect: #size)
								            ifEmpty: [ 0 ]
								            ifNotEmpty: #sum) + 1 + colPos ] ] ].
				^ codePane handleEdit: [
					  codePane notify: message at: charPos in: code readStream ] ] ].
		codePane hasUnacceptedEdits: false.
		self selectModuleNamed: (newModulePositions
				 ifEmpty: [ nil ]
				 ifNotEmpty: [ newModulePositions first key ]).
		aBlock ifNotNil: [
			newModulePositions do: [ :assoc |
				aBlock
					cull: assoc key
					cull: (code copyFrom: assoc value first to: assoc value last) ] ].
		self autoTest ifTrue: [
			self autoFullTest
				ifTrue: [ self runAllTests ]
				ifFalse: [ self runTestModule ] ].
		^ true ].
	^ false
]

{ #category : 'value pane' }
ViennaBrowser >> acceptGlobalBindings: aString [
	| newBindings oldBindings |
	newBindings := self
		parseBindings: aString
		ifError: [ :pos :msg | 
			valuePane
				handleEdit: [ 
					valuePane textMorph editor
						selectFrom: pos to: pos -1;
						afterSelectionInsertAndSelect: msg ].
			^ false ].
	oldBindings := animation state copy.
	newBindings do: [ :assoc | animation plainAt: assoc key put: assoc value ].
	animation
		plainEvaluate: 'nil'
		ifError: [ :msg | 
			valuePane
				handleEdit: [ 
					valuePane textMorph editor
						selectFrom: aString size to: aString size - 1;
						afterSelectionInsertAndSelect: msg ].
			oldBindings keysAndValuesDo: [ :key :value | animation plainAt: key put: value ].
			^ false ].
	animation changed: #state.
	^ true
]

{ #category : 'value pane' }
ViennaBrowser >> acceptValue: aString [
	^ self selectedModule
		ifNil: [ 
			self selectedField
				ifNil: [ self acceptGlobalBindings: aString asString ]
				ifNotNil: [ :field | self accept: aString asString var: field ] ]
		ifNotNil: [ :module | 
			self selectedField
				ifNil: [ self acceptBindings: aString asString in: module ]
				ifNotNil: [ :field | self accept: aString asString var: field in: module ] ]
]

{ #category : 'workspace pane' }
ViennaBrowser >> acceptWorkspace: aStringOrText [
	| oldWorkspace |
	oldWorkspace := workspace.
	workspace := aStringOrText asString.
	oldWorkspace ~= workspace
		ifTrue: [ self changed: #workspace ].
	^ true
]

{ #category : 'accessing' }
ViennaBrowser >> animation [
	^ animation
]

{ #category : 'accessing' }
ViennaBrowser >> animation: aViennaAnimation [
	animation ifNotNil: [ animation removeDependent: self ].
	animation := aViennaAnimation.
	aViennaAnimation addDependent: self
]

{ #category : 'accessing' }
ViennaBrowser >> animationClassForType: aSymbol [
	aSymbol = #transpiler
		ifTrue: [ Smalltalk
				at: #ViennaTranspiledAnimation
				ifPresent: [ :class | ^ class ] ].
	^ ViennaAnimation
]

{ #category : 'accessing' }
ViennaBrowser >> autoFormat [
	^ self class autoFormat
]

{ #category : 'accessing' }
ViennaBrowser >> autoFullTest [
	^ self class autoFullTest
]

{ #category : 'accessing' }
ViennaBrowser >> autoTest [
	^ self class autoTest
]

{ #category : 'test pane menu' }
ViennaBrowser >> basicRunTestModule: module operation: operation [
	| header testAnimation |
	header := 'Runtime: Error 4129: Exit '.
	testAnimation := animation copyForTest
		state: Dictionary new;
		yourself.
	[ [ testAnimation
		plainEvaluate: operation , '()'
		in: module
		ifError: [ :msg | 
			(msg size > header size and: [ (msg copyFrom: 1 to: header size) = header ])
				ifTrue: [ ViennaException
						expression: (ViennaReader new parse: (msg copyFrom: header size + 1 to: msg size)) ]
				ifFalse: [ Error signal: msg ] ] ]
		on: ViennaException
		do: [ :exception | 
			exception expression
				in: [ :expr | 
					(expr isViennaComposite and: [ expr constructorName = 'AssertFailure' ])
						ifTrue: [ ^ (ViennaTestFailureResultItem
								module: module
								operation: operation
								message: 'assertion failed: ' , (expr at: 1) asString)
								inform;
								yourself ].
					(expr isViennaComposite and: [ expr constructorName = 'AssertEqualsFailure' ])
						ifTrue: [ ^ (ViennaTestFailureResultItem
								module: module
								operation: operation
								message:
								'assertion failed: ' , (expr at: 3) asString , ' expected: ' , (expr at: 2) viennaString
								, ' actual: ' , (expr at: 1) viennaString)
								inform;
								yourself ].
					^ (ViennaTestErrorResultItem
						module: module
						operation: operation
						message: expr viennaString)
						inform;
						yourself ] ] ]
		on: Error
		do: [ :exception | 
			^ (ViennaTestErrorResultItem
				module: module
				operation: operation
				message: exception printString)
				inform;
				yourself ].
	^ ViennaTestSuccessResultItem module: module operation: operation message: 'OK'
]

{ #category : 'user interface' }
ViennaBrowser >> build [
	| pane upper |
	moduleListPane := self buildModuleList.
	fieldListPane := self buildFieldList.
	valuePane := self buildValuePane.
	codePane := self buildCodePane.
	workspacePane := self buildWorkspacePane.
	testPane := self buildTestPane.
	pane := BorderedMorph new.
	pane extent: 600 @ 400.
	pane color: Color transparent.
	pane changeProportionalLayout.
	upper := BorderedMorph new.
	upper changeProportionalLayout.
	upper
		addMorph: moduleListPane
		fullFrame: (0 @ 0 corner: 0.3 @ 1) asLayoutFrame.
	upper
		addMorph: fieldListPane
		fullFrame: (0.3 @ 0 corner: 0.6 @ 1) asLayoutFrame.
	upper
		addMorph: valuePane
		fullFrame: (0.6 @ 0 corner: 1 @ 1) asLayoutFrame.
	upper addPaneSplitters.
	testLabel := Morph new
		changeTableLayout;
		color: Color transparent;
		listDirection: #leftToRight;
		listCentering: #center;
		wrapCentering: #center;
		hResizing: #shrinkWrap;
		vResizing: #shrinkWrap;
		addMorphBack: 'UnitTests' asMorph;
		addMorphBack: (testLabelIcon := ViennaTestResultItem icon asMorph);
		computeBounds;
		disableTableLayout;
		yourself.
	testLabelIcon on: #click send: #runAllTests to: self.
	lowerTabPane := TabGroupMorph new.
	lowerTabPane addPage: codePane label: 'Specification'.
	lowerTabPane addPage: workspacePane label: 'Workspace'.
	lowerTabPane addPage: testPane label: testLabel.
	lowerTabPane selectedPageIndex: 1.
	pane
		addMorph: upper
		fullFrame: ((0 @ 0 corner: 1 @ 0.4) asLayoutFrame bottomRightOffset: 0 @ -2).
	pane
		addMorph: lowerTabPane
		fullFrame: ((0 @ 0.4 corner: 1 @ 1) asLayoutFrame topLeftOffset: 0 @ 2).
	pane addPaneSplitters.
	^ pane
]

{ #category : 'user interface' }
ViennaBrowser >> buildCodePane [
	^ (ViennaPluggableTextMorph
		on: self
		text: #code
		accept: #acceptCode:
		readSelection: #codeSelection
		menu: #codePaneMenu:shifted:
		setSelection: #codeSelection:)
		setBalloonText: 'VDM specification';
		askBeforeDiscardingEdits: true;
		bindKeyCombination: $d command toAction: [ self doItIn: codePane ];
		bindKeyCombination: $p command toAction: [ self printItIn: codePane ];
		bindKeyCombination: $f shift command toAction: [ codePane prettyPrint ];
		bindKeyCombination: $t command toAction: [ codePane template ];
		bindKeyCombination: $d ctrl toAction: [ self doItIn: codePane ];
		bindKeyCombination: $p ctrl toAction: [ self printItIn: codePane ];
		bindKeyCombination: $f shift ctrl toAction: [ codePane prettyPrint ];
		bindKeyCombination: $t ctrl toAction: [ codePane template ];
		font: ViennaLauncher font;
		yourself
]

{ #category : 'user interface' }
ViennaBrowser >> buildFieldList [
	^ (PluggableListMorph
		on: self
		list: #fieldList
		selected: #fieldSelectionIndex
		changeSelected: #fieldSelectionIndex:
		menu: nil)
		font: ViennaLauncher font;
		yourself
]

{ #category : 'user interface' }
ViennaBrowser >> buildModuleList [
	^ (PluggableListMorph
		on: self
		list: #moduleList
		selected: #moduleSelectionIndex
		changeSelected: #moduleSelectionIndex:
		menu: #moduleListMenu:)
		font: ViennaLauncher font;
		yourself
]

{ #category : 'user interface' }
ViennaBrowser >> buildTestPane [
	^ (PluggableIconListMorph
		on: self
		list: #testList
		selected: #testSelectionIndex
		changeSelected: #testSelectionIndex:
		menu: #testPaneMenu:)
		getIconSelector: #testResultIconFor:;
		font: ViennaLauncher font;
		yourself
]

{ #category : 'user interface' }
ViennaBrowser >> buildValuePane [
	^ (ViennaPluggableTextMorph
		on: self
		text: #value
		accept: #acceptValue:
		readSelection: #valueSelection
		menu: #valuePaneMenu:shifted:
		setSelection: #valueSelection:)
		askBeforeDiscardingEdits: false;
		alwaysAccept: true;
		bindKeyCombination: $d command toAction: [ self doItIn: valuePane ];
		bindKeyCombination: $p command toAction: [ self printItIn: valuePane ];
		bindKeyCombination: $d ctrl toAction: [ self doItIn: valuePane ];
		bindKeyCombination: $p ctrl toAction: [ self printItIn: valuePane ];
		font: ViennaLauncher font;
		yourself
]

{ #category : 'user interface' }
ViennaBrowser >> buildWorkspacePane [
	^ (ViennaPluggableTextMorph
		on: self
		text: #workspace
		accept: #acceptWorkspace:
		readSelection: #workspaceSelection
		menu: #workspacePaneMenu:shifted:
		setSelection: #workspaceSelection:)
		setBalloonText: 'workspace';
		askBeforeDiscardingEdits: true;
		bindKeyCombination: $d command toAction: [ self doItIn: workspacePane ];
		bindKeyCombination: $p command toAction: [ self printItIn: workspacePane ];
		bindKeyCombination: $d ctrl toAction: [ self doItIn: workspacePane ];
		bindKeyCombination: $p ctrl toAction: [ self printItIn: workspacePane ];
		font: ViennaLauncher font;
		yourself
]

{ #category : 'code pane' }
ViennaBrowser >> code [
	| section module |
	animation ifNil: [ ^ String new ].
	module := self selectedModule.
	module ifNil: [ ^ self specificationTemplate ].
	section := ((self modulePositionsFrom: animation specification)
		detect: [ :assoc | assoc key = module ]
		ifNone: [ ^ self specificationTemplate ]) value.
	^ (animation specification copyFrom: section first to: section last) asText makeAllColor: Color black
]

{ #category : 'code pane menu' }
ViennaBrowser >> codePaneDoIt [
	self doItIn: codePane
]

{ #category : 'code pane menu' }
ViennaBrowser >> codePaneMenu: aMenu shifted: aBoolean [
	^ aMenu addAllFromPragma: 'viennaBrowserCodePaneMenu' target: self
]

{ #category : 'code pane menu' }
ViennaBrowser >> codePanePrintIt [
	^ self printItIn: codePane
]

{ #category : 'code pane' }
ViennaBrowser >> codeSelection [
	^ codeSelection ifNil: [ codeSelection := 1 to: 0 ]
]

{ #category : 'code pane' }
ViennaBrowser >> codeSelection: aSelection [
	codeSelection := aSelection
]

{ #category : 'private' }
ViennaBrowser >> directory [

	^ directory ifNil: [ 
		  directory := FileLocator viennaTalkDocumentDirectory ]
]

{ #category : 'private' }
ViennaBrowser >> doItIn: aPluggableTextMorph [
	aPluggableTextMorph
		handleEdit: [ | editor error |
			editor := aPluggableTextMorph textMorph editor.
			editor lineSelectAndEmptyCheck: [ ^ nil ].
			error := nil.
			self
				evaluate: editor selectionAsStream upToEnd
				ifError: [ :msg | error := msg ].
			error
				ifNotNil: [ | selectionInterval |
					selectionInterval := editor selectionInterval.
					aPluggableTextMorph textMorph
						handleEdit: [ editor afterSelectionInsertAndSelect: error ].
					selectionInterval := editor selectionInterval.
					aPluggableTextMorph textMorph editor
						selectFrom: selectionInterval first
						to: selectionInterval last ] ]
]

{ #category : 'private' }
ViennaBrowser >> evaluate: aString [

	^ self evaluate: aString ifError: [ :msg | msg ]
]

{ #category : 'private' }
ViennaBrowser >> evaluate: aString ifError: errorBlock [
	^ selectedModule
		ifNil: [ animation plainEvaluate: aString ifError: errorBlock ]
		ifNotNil: [ :m | animation plainEvaluate: aString in: m ifError: errorBlock ]
]

{ #category : 'field list' }
ViennaBrowser >> fieldList [
	^ self selectedModule
		ifNil: [ animation state keys asSortedCollection asArray ]
		ifNotNil: [ :module | 
			| m |
			m := module , '`'.
			(animation state keys
				select: [ :name | name size > m size and: [(name copyFrom: 1 to: m size) = m ]]
				thenCollect: [ :name | name copyFrom: m size + 1 to: name size ]) asSortedCollection asArray ]
]

{ #category : 'field list' }
ViennaBrowser >> fieldSelectionIndex [
	^ self fieldList indexOf: self selectedField
]

{ #category : 'field list' }
ViennaBrowser >> fieldSelectionIndex: anInteger [
	self selectFieldNamed: (self fieldList at: anInteger ifAbsent: [])
]

{ #category : 'private' }
ViennaBrowser >> fileOpen: title extensions: anArrayOfString do: aBlock [
	(UIManager default
		chooseExistingFileReference: title
		extensions: anArrayOfString
		path: self directory
		preview: nil)
		ifNotNil: [ :ref | 
			directory := ref parent.
			ref
				readStreamDo:
					[ :stream | aBlock value: stream contents withInternalLineEndings readStream ] ]
]

{ #category : 'private' }
ViennaBrowser >> fileSave: title extensions: anArrayOfString do: aBlock [
	(UIManager default
		chooseForSaveFileReference: title
		extensions: anArrayOfString
		path: self directory
		preview: false)
		ifNotNil: [ :reference | 
			directory := reference parent.
			reference
				writeStreamDo: [ :stream | 
					stream
						nextPutAll:
							((String new: 1024 streamContents: [ :stringStream | aBlock value: stringStream ])
								copyReplaceAll: String cr
								with: String lf) ] ]
]

{ #category : 'accessing' }
ViennaBrowser >> font [
	^ ViennaLauncher font
]

{ #category : 'module list menu' }
ViennaBrowser >> generateSmalltalkClasses [

	| ast |
	ast := ViennaVDMParser current parse: animation specification.
	ast isPetit2Failure ifTrue: [
		^ UIManager default
			  alert: 'Failed to generate a code : ' , ast message
			  title: 'ViennaTalk' ].
	(ViennaVDM2SmalltalkClass new
		 source: animation specification;
		 generate: ast) ifNotNil: [ :class | class browse ]
]

{ #category : 'module list menu' }
ViennaBrowser >> generateSmalltalkObject [

	| ast |
	ast := ViennaVDMParser current parse: animation specification.
	ast isPetit2Failure ifTrue: [
		^ UIManager default
			  alert: 'Failed to generate a code : ' , ast message
			  title: 'ViennaTalk' ].
	(ViennaVDM2SmalltalkObject new
		 source: animation specification;
		 generate: ast) ifNotNil: [ :object | object inspect ]
]

{ #category : 'module list menu' }
ViennaBrowser >> generateSmalltalkScript [

	self selectedModule ifNotNil: [ :module |
		((self modulePositionsFrom: animation specification)
			 detect: [ :assoc | assoc key = module ]
			 ifNone: [  ]) ifNotNil: [ :assoc |
			| ast |
			ast := ViennaVDMParser current parse: (animation specification
					        copyFrom: assoc value first
					        to: assoc value last).
			ast isPetit2Failure ifTrue: [
				^ UIManager default
					  alert: 'Failed to generate a code : ' , ast message
					  title: 'ViennaTalk' ].
			ast first isViennaModuleNode ifTrue: [
				ast := ViennaFlatDocumentNode withAll: ast first third ].
			(ViennaVDM2SmalltalkScript new generate: ast) ifNotNil: [ :script |
				Smalltalk tools workspace openContents:
					(RBParser parseExpression: script) formattedCode ] ] ]
]

{ #category : 'module list menu' }
ViennaBrowser >> generateViennaDocSourceScript [

	self
		fileSave: 'Generate ViennaDoc source script to...'
		extensions: #( 'js' )
		do: [ :stream |
			| source ast sources walker |
			source := animation specification.
			ast := ViennaVDMParser current parse: source.
			ast isPetit2Failure ifTrue: [ ^ self ].
			sources := Dictionary new.
			walker := [ :node :module |
			          node isViennaNode ifTrue: [
				          node isViennaModuleNode ifTrue: [
					          sources
						          at: node identifier
						          put: (source copyFrom: node start to: node end) ].
				          node isViennaStateDefinitionNode ifTrue: [
					          sources
						          at:
						          (module ifNil: [ '' ] ifNotNil: [ module , '`' ])
						          , node identifier
						          put: (source copyFrom: node start to: node end) ].
				          node isViennaExplicitOperationDefinitionNode ifTrue: [
					          sources
						          at:
						          (module ifNil: [ '' ] ifNotNil: [ module , '`' ])
						          , node identifier
						          put: (source copyFrom: node start to: node end) ].
				          node isViennaTypeSynonymNode ifTrue: [
					          sources
						          at:
						          (module ifNil: [ '' ] ifNotNil: [ module , '`' ])
						          , node identifier
						          put: (source copyFrom: node start to: node end) ].
				          node isViennaRecordTypeDefinitionNode ifTrue: [
					          sources
						          at:
						          (module ifNil: [ '' ] ifNotNil: [ module , '`' ])
						          , node identifier
						          put: (source copyFrom: node start to: node end) ].
				          node isViennaValueDefinitionNode ifTrue: [
					          sources
						          at: (module ifNil: [ '' ] ifNotNil: [ module , '`' ])
							          , node pattern identifier
						          put: (source copyFrom: node start to: node end) ].
				          node isViennaExplicitFunctionDefinitionNode ifTrue: [
					          sources
						          at:
						          (module ifNil: [ '' ] ifNotNil: [ module , '`' ])
						          , node identifier
						          put: (source copyFrom: node start to: node end) ].
				          node do: [ :n |
					          walker
						          value: n
						          value:
						          (module ifNil: [
							           node isViennaModuleNode ifTrue: [ node identifier ] ]) ] ] ].
			walker value: ast value: nil.
			stream nextPutAll: 'ViennaDoc.source='.
			(NeoJSONWriter on: stream) nextPut: source withUnixLineEndings.
			stream
				nextPut: $;;
				nextPut: Character lf;
				nextPutAll: 'ViennaDoc.sources = {};';
				nextPut: Character lf.
			sources keysAndValuesDo: [ :name :src |
				stream
					nextPutAll: 'ViennaDoc.sources[';
					nextPut: $';
					nextPutAll: name;
					nextPut: $';
					nextPutAll: ']='.
				(NeoJSONWriter on: stream) nextPut: src withUnixLineEndings.
				stream
					nextPut: $;;
					nextPut: Character lf ] ]
]

{ #category : 'module list menu' }
ViennaBrowser >> importUnitTestingModule [

	self acceptCode: ViennaModuleNode unitTestingSource
]

{ #category : 'module list menu' }
ViennaBrowser >> importViennaDOMModule [

	self acceptCode: ViennaModuleNode viennaDOMSource
]

{ #category : 'module list menu' }
ViennaBrowser >> importerModules [
	| parser |
	self selectedModule isNil
		ifTrue: [ ^ Array new ].
	parser := 'from' asPParser , #space asPParser plusA , self selectedModule asPParser
		, #space asPParser.
	^ ((self modulePositionsFrom: animation specification)
		select: [ :assoc | 
			assoc key ~= self selectedModule
				and: [ (self
						matches: parser
						in:
							(animation specification copyFrom: assoc value first to: assoc value last))
						notEmpty ] ]) collect: [ :assoc | assoc key ]
]

{ #category : 'code pane menu' }
ViennaBrowser >> insertModuleSource: moduleName [
	| section moduleSource editor |
	section := ((self modulePositionsFrom: animation specification)
		detect: [ :assoc | assoc key = moduleName ]
		ifNone: [ String new ]) value.
	moduleSource := (animation specification copyFrom: section first to: section last) asText
		makeAllColor: Color black.
	codePane highlight.
	editor := codePane textMorph editor.
	editor replaceSelectionWith: moduleSource.
	editor
		selectInterval: (editor selectionInterval first to: editor selectionInterval first + moduleSource size - 1)
]

{ #category : 'test pane menu' }
ViennaBrowser >> jumpToSpec [
	| results |
	results := self testList.
	(self testSelectionIndex between: 1 and: results size)
		ifTrue: [ (results at: self testSelectionIndex)
				in: [ :result | 
					self selectModuleNamed: result module.
					(codePane textMorph text asString
						findString: result operation , '() ==')
						in: [ :start | 
							start > 0
								ifTrue:
									[ codePane selectFrom: start to: start + result operation size - 1 ] ].
					lowerTabPane selectedPageIndex: 1 ] ]
]

{ #category : 'module list menu' }
ViennaBrowser >> loadAndMergeFromFile [
	self
		fileOpen: 'Load and merge ...'
		extensions: #('vdm' 'vdmsl')
		do: [ :stream | self acceptCode: stream contents ]
]

{ #category : 'module list menu' }
ViennaBrowser >> loadSnapshotFromFile [
	self
		fileOpen: 'Open snapshot...'
		extensions: #('vdmim')
		do: [ :stream | 
			| json |
			json := (NeoJSONReader on: stream) next.
			animation := (self
				animationClassForType: (json at: 'engineType' ifAbsent: [ nil ]) asSymbol)
				new.
			[ animation
				specification: (json at: 'specification' ifAbsent: [ '' ])
				ifError: [ :msg | self error: msg ].
			self selectModuleNamed: nil ]
				on: Error
				do: [ :ex | 
					codePane setText: (json at: 'specification').
					codePane hasUnacceptedEdits: true ].
			animation state: (json at: 'state' ifAbsent: [ Dictionary new ]).
			self acceptWorkspace: (json at: 'workspace' ifAbsent: [ '' ]) ]
]

{ #category : 'private' }
ViennaBrowser >> matches: aParser in: anObject [
	"Search anObject repeatedly for the matches of the receiver. Answered an OrderedCollection of the matched parse-trees."

	| result |
	result := OrderedCollection new.
	self matches: aParser in: anObject do: [ :each | result addLast: each ].
	^ result
]

{ #category : 'private' }
ViennaBrowser >> matches: aParser in: aStream do: aBlock [
	"Search anObject repeatedly for the matches of the receiver. Evaluate aBlock for each match with the matched parse-tree as the argument. Make sure to always consume exactly one character with each step, to not miss any match."

	((aParser and ==> aBlock , #any asPParser) / #any asPParser) star parse: aStream
]

{ #category : 'module list menu' }
ViennaBrowser >> mergeAnnotationsIntoFRAM [

	| fram ast |
	self
		fileOpen: 'Load FRAM ...'
		extensions: #( 'xfmv' )
		do: [ :stream | fram := ViennaFRAMModel fromXML: stream ].
	fram ifNil: [ ^ nil ].
	ast := ViennaVDMParser current parse: animation specification.
	ast isPetit2Failure ifTrue: [ ^ nil ].
	fram loadSpec: ast.
	self
		fileSave: 'Write the merged FRAM to...'
		extensions: #( 'xfmv' )
		do: [ :stream | fram writeXMLOn: stream ]
]

{ #category : 'module list menu' }
ViennaBrowser >> mergeOperationsFromFRAM [

	| fram ast |
	self
		fileOpen: 'Load FRAM ...'
		extensions: #( 'xfmv' )
		do: [ :stream | fram := ViennaFRAMModel fromXML: stream ].
	fram ifNil: [ ^ nil ].
	ast := ViennaVDMParser new parse: animation specification.
	ast isPetit2Failure ifTrue: [ ^ nil ].
	fram appendToSpec: ast.
	animation specification: ast source

]

{ #category : 'module list' }
ViennaBrowser >> moduleList [
	^ animation ifNil: [ Array new ] ifNotNil: [ ((self modulePositionsFrom: animation specification) collect: #key) asSortedCollection asArray]
]

{ #category : 'module list menu' }
ViennaBrowser >> moduleListMenu: aMenu [
	^ aMenu addAllFromPragma: 'viennaBrowserModuleListMenu' target: self
]

{ #category : 'private' }
ViennaBrowser >> modulePositionsFrom: aString [
	^ aString = cachedSpec
		ifTrue: [ cachedModulePositions ]
		ifFalse: [ 
			| reader stream modulesAndPositions ends |
			reader := ViennaReader new.
			stream := aString readStream.
			modulesAndPositions := Array new writeStream.
			((stream nextMatchAll: 'module') and: [ stream next isSeparator ])
				ifTrue: [ 
					(String
						new: 1
						streamContents: [ :nameStream | 
							[ stream atEnd or: [ stream peek isSeparator or: [ '-/' includes: stream peek ] ] ]
								whileFalse: [ nameStream nextPut: stream next ] ]) in: [ :name | modulesAndPositions nextPut: name -> 1 ] ].
			[ stream atEnd ]
				whileFalse: [ 
					stream next
						in: [ :char | 
							char isSeparator
								ifTrue: [ 
									stream position
										in: [ :position | 
											((stream nextMatchAll: 'module') and: [ stream next isSeparator ])
												ifTrue: [ 
													(String
														new: 1
														streamContents: [ :nameStream | 
															[ stream atEnd or: [ stream peek isSeparator or: [ '-/' includes: stream peek ] ] ]
																whileFalse: [ nameStream nextPut: stream next ] ])
														in: [ :name | modulesAndPositions nextPut: name -> (position + 1) ] ] ] ].
							char = $'
								ifTrue: [ 
									stream skip: -1.
									reader parseCharOn: stream ].
							char = $"
								ifTrue: [ 
									stream skip: -1.
									reader parseStringOn: stream ].
							(char = $/ and: [ stream nextMatchAll: '*' ])
								ifTrue: [ 
									stream skip: -2.
									reader skipCommentOn: stream ].
							(char = $- and: [ stream nextMatchAll: '-' ])
								ifTrue: [ 
									stream skip: -2.
									reader skipLineCommentOn: stream ] ] ].
			modulesAndPositions := modulesAndPositions contents.
			modulesAndPositions ifEmpty: [ ^ Array with: 'DEFAULT' -> (1 to: aString size) ].
			ends := ((2 to: modulesAndPositions size) collect: [ :index | (modulesAndPositions at: index) value - 1 ])
				copyWith: aString size.
			cachedSpec := aString.
			cachedModulePositions := (1 to: modulesAndPositions size)
				collect: [ :index | (modulesAndPositions at: index) key -> ((modulesAndPositions at: index) value to: (ends at: index)) ] ]
]

{ #category : 'module list' }
ViennaBrowser >> moduleSelectionIndex [
	^ self moduleList indexOf: self selectedModule
]

{ #category : 'module list' }
ViennaBrowser >> moduleSelectionIndex: anInteger [ 
	^ self
		selectModuleNamed: (self moduleList
				at: anInteger
				ifAbsent: [])
]

{ #category : 'module list menu' }
ViennaBrowser >> newAndLoadFromFile [
	self
		fileOpen: 'New and load from...'
		extensions: #('vdm' 'vdmsl')
		do: [ :stream | 
			stream contents
				in: [ :source | 
					[ animation specification: source ifError: [ :msg | self error: msg ].
					self selectModuleNamed: nil ]
						on: Error
						do: [ :ex | 
							codePane setText: source.
							codePane hasUnacceptedEdits: true ] ] ]
]

{ #category : 'user interface' }
ViennaBrowser >> okToChange [
	^ (codePane okToChange and: [ workspacePane okToChange ])
		or: [ UIManager default
				confirm:
					'Has unsaved changes.
Do you want to discard it to close?' ]
]

{ #category : 'user interface' }
ViennaBrowser >> openLabel: aString [
	(self build openInWindowLabeled: aString) model: self
]

{ #category : 'module list' }
ViennaBrowser >> otherModules [
	^ self moduleList copyWithout: self selectedModule
]

{ #category : 'value pane' }
ViennaBrowser >> parseBindings: aString ifError: errorBlock [
	| reader bindings stream readName |
	reader := ViennaReader new.
	bindings := Array new writeStream.
	stream := aString readStream.
	readName := [ 
	(String
		new: 1
		streamContents: [ :writeStream | [ stream atEnd or: [ stream peek = $| ] ] whileFalse: [ writeStream nextPut: stream next ] ])
		trimmed ].
	stream skipSeparators.
	(stream nextMatchAll: '{')
		ifFalse: [ ^ errorBlock value: 1 value: 'Should start with "{"' ].
	stream skipSeparators.
	[ stream atEnd ]
		whileFalse: [ 
			| name start end |
			stream peek = $}
				ifTrue: [ ^ bindings contents ].
			name := readName value.
			(stream nextMatchAll: '|->')
				ifFalse: [ ^ errorBlock value: stream position value: '"|->" is expected.' ].
			stream skipSeparators.
			start := stream position+1.
			[ reader parseOn: stream ]
				on: Error
				do: [ :ex | ^ errorBlock value: stream position value: ex messageText ].
			end := stream position.
			bindings nextPut: name -> (aString copyFrom: start to: end).
			stream skipSeparators.
			stream peek = $}
				ifTrue: [ ^ bindings contents ].
			stream next = $,
				ifFalse: [ ^ errorBlock value: stream position value: '"," is expected.' ] ].
	^ errorBlock value: aString size value: 'Unexpected end before reaching to "}"'
]

{ #category : 'private' }
ViennaBrowser >> printItIn: aPluggableTextMorph [
	aPluggableTextMorph
		handleEdit: [ | editor result selectionInterval |
			editor := aPluggableTextMorph textMorph editor.
			editor lineSelectAndEmptyCheck: [ ^ nil ].
			result := self evaluate: editor selectionAsStream upToEnd.
			selectionInterval := editor selectionInterval.
			aPluggableTextMorph textMorph
				handleEdit: [ editor afterSelectionInsertAndSelect: result ].
			selectionInterval := editor selectionInterval.
			aPluggableTextMorph textMorph editor
				selectFrom: selectionInterval first
				to: selectionInterval last ]
]

{ #category : 'module list menu' }
ViennaBrowser >> removeModule [
	self selectedModule
		ifNotNil: [ :moduleName | 
			| position newSpecification oldSpecification |
			position := ((self modulePositionsFrom: animation specification)
				detect: [ :assoc | assoc key = moduleName ]
				ifNone: [ ^ false ]) value.
			newSpecification := (animation specification copyFrom: 1 to: position first - 1)
				, (animation specification copyFrom: position last + 1 to: animation specification size).
			oldSpecification := animation specification.
			animation specification: newSpecification.
			animation
				plainEvaluate: 'nil'
				ifError: [ :msg | 
					animation specification: oldSpecification.
					UIManager default abort: msg title: 'VDM Error'.
					^ false ].
			self changed: #moduleList.
			self selectModuleNamed: nil.
			^ true ]
]

{ #category : 'test pane menu' }
ViennaBrowser >> runAllTests [

	testProcess ifNotNil: [ testProcess terminate ].
	testProcess := [
	               | ast |
	               testResult := Array new.
	               self updateTestLabelIcon.
	               self changed: #testList.
	               ast := ViennaVDMParser new parse:
		                      animation specification.
	               (ast isPetit2Success and: [ ast notEmpty ]) ifTrue: [
		               (ast at: 1) isViennaModuleNode ifTrue: [
			               ast modulesDo: [ :module |
				               (module identifier endsWith: 'Test') ifTrue: [
					               module sectionsDo: [ :section |
						               section isViennaOperationDefinitionsNode ifTrue: [
							               section do: [ :operation |
								               | operationName |
								               operationName := operation identifier.
								               (operationName size > 4 and: [
									                (operationName copyFrom: 1 to: 4) = 'test' ])
									               ifTrue: [
									               self
										               runTestModule: module identifier
										               operation: operationName ] ] ] ] ] ] ] ].
	               testProcess := nil.
	               self updateTestLabelIcon ] forkAt:
		               Processor userBackgroundPriority
]

{ #category : 'test pane menu' }
ViennaBrowser >> runTestModule [
	testResult := Array new.
	self changed: #testList.
	self updateTestLabelIcon.
	self runTestModule: self selectedModule
]

{ #category : 'test pane menu' }
ViennaBrowser >> runTestModule: aString [

	| testModuleName |
	testModuleName := aString.
	(testModuleName endsWith: 'Test') ifFalse: [
		testModuleName := testModuleName , 'Test' ].
	testProcess ifNotNil: [ testProcess terminate ].
	testProcess := [
	               | ast |
	               testResult := Array new.
	               self changed: #testList.
	               ast := ViennaVDMParser new parse:
		                      animation specification.
	               (ast isPetit2Success and: [ ast notEmpty ]) ifTrue: [
		               (ast at: 1) isViennaModuleNode ifTrue: [
			               (ast moduleNamed: testModuleName) ifNotNil: [
				               :module |
				               module sectionsDo: [ :section |
					               section isViennaOperationDefinitionsNode ifTrue: [
						               section do: [ :operation |
							               | operationName |
							               operationName := operation identifier.
							               (operationName size > 4 and: [
								                (operationName copyFrom: 1 to: 4) = 'test' ])
								               ifTrue: [
								               self
									               runTestModule: module identifier
									               operation: operationName ] ] ] ] ] ] ].
	               testProcess := nil.
	               self updateTestLabelIcon ] forkAt:
		               Processor userBackgroundPriority
]

{ #category : 'test pane menu' }
ViennaBrowser >> runTestModule: module operation: operation [
	testResult := testResult
		copyWith: (self basicRunTestModule: module operation: operation).
	self updateTestLabelIcon.
	self changed: #testList
]

{ #category : 'module list menu' }
ViennaBrowser >> saveAModuleToFile [

	self selectedModule ifNotNil: [ :module | 
		((self modulePositionsFrom: animation specification)
			 detect: [ :assoc | assoc key = module ]
			 ifNone: [  ]) ifNotNil: [ :assoc | 
			self
				fileSave: 'Save the "' , module , '" modules to...'
				extensions: #( 'vdm' 'vdmsl' )
				do: [ :stream | 
					stream nextPutAll: (animation specification
							 copyFrom: assoc value first
							 to: assoc value last) ] ] ]
]

{ #category : 'module list menu' }
ViennaBrowser >> saveAllModulesToFile [
	self
		fileSave: 'Save all modules to...'
		extensions: #('vdm' 'vdmsl')
		do: [ :stream | 
			stream
				nextPutAll: animation specification;
				close ]
]

{ #category : 'module list menu' }
ViennaBrowser >> saveSnapshotToFile [
	| json |
	json := Dictionary new.
	json at: 'engineType' put: self animation engineType.
	json at: 'specification' put: self animation specification.
	json at: 'state' put: self animation state.
	json at: 'workspace' put: self workspace.
	self
		fileSave: 'Save snapshot to...'
		extensions: #('vdmim')
		do: [ :stream | (NeoJSONWriter on: stream) nextPut: json ]
]

{ #category : 'field list' }
ViennaBrowser >> selectFieldNamed: aString [
	| oldSelection |
	oldSelection := selectedField.
	selectedField := (self fieldList includes: aString)
		ifTrue: [ aString ].
	selectedField ~= oldSelection
		ifTrue: [ 
			self changed: #fieldSelectionIndex.
			self changed: #value ]
]

{ #category : 'module list' }
ViennaBrowser >> selectModuleNamed: aString [
	| oldSelection |
	oldSelection := selectedModule.
	selectedModule := (self moduleList includes: aString)
		ifTrue: [ aString ].
	selectedModule ~= oldSelection
		ifTrue: [ 
			self changed: #moduleSelectionIndex.
			self changed: #fieldList.
			self selectFieldNamed: nil.
			self changed: #code.
			self changed: #value ]
]

{ #category : 'field list' }
ViennaBrowser >> selectedField [
	^ selectedField
]

{ #category : 'module list' }
ViennaBrowser >> selectedModule [
	^ selectedModule
]

{ #category : 'code pane' }
ViennaBrowser >> specificationTemplate [
	^ 'module <module name>
exports all
definitions
types
	<typename> = <type expression>;
values
	<constant> = <expression>;
functions
	<funcname> : <arg type> -> <return type>
	<funcname>(<arg>) == <expression>
	pre <boolean expression>
	post <boolean expression>;
state <State> of
	<varname> : <type expression>
init s == s = mk_<State>(<initial value>)
inv mk_<State>(<varname>) == <boolean expression>
end
operations
	<operation name> : <arg type> ==> <return type or ()>
	<operation name>(<arg>) == <statement>
	pre <boolean expression>
	post <boolean expression>;
end <module name>
' asText makeAllColor: Color gray
]

{ #category : 'test pane' }
ViennaBrowser >> testList [
	^ (testResult ifNil: [ Array new ]) copy
]

{ #category : 'test pane menu' }
ViennaBrowser >> testPaneMenu: aMenu [
	^ aMenu addAllFromPragma: 'viennaBrowserTestPaneMenu' target: self
]

{ #category : 'test pane' }
ViennaBrowser >> testResultIconFor: aViennaTestResultItem [
	^ aViennaTestResultItem icon
]

{ #category : 'test pane' }
ViennaBrowser >> testSelectionIndex [
	^ testSelectionIndex ifNil: [ testSelectionIndex := 0 ]
]

{ #category : 'test pane' }
ViennaBrowser >> testSelectionIndex: anInteger [
	testSelectionIndex := anInteger.
	self changed: #testSelectionIndex
]

{ #category : 'updating' }
ViennaBrowser >> update: aSymbol [
	aSymbol = #specification
		ifTrue: [ 
			self changed: #code.
			self changed: #moduleList.
			self changed: #fieldList.
			self changed: #testList.
			self changed: #value ].
	aSymbol = #state
		ifTrue: [ self changed: #value ]
]

{ #category : 'test pane' }
ViennaBrowser >> updateTestLabelIcon [
	| level |
	level := 0.
	self testList
		do: [ :item | 
			item isSuccess
				ifTrue: [ level := level max: 1 ].
			item isFailure
				ifTrue: [ level := level max: 2 ].
			item isError
				ifTrue: [ level := level max: 3 ] ].
	level = 0
		ifTrue: [ testLabelIcon form: ViennaTestResultItem icon ].
	level = 1
		ifTrue: [ (testProcess isNil or: [ testProcess isTerminated ])
				ifTrue: [ testLabelIcon form: ViennaTestSuccessResultItem icon ]
				ifFalse: [ testLabelIcon form: ViennaTestResultItem icon ] ].
	level = 2
		ifTrue: [ testLabelIcon form: ViennaTestFailureResultItem icon ].
	level = 3
		ifTrue: [ testLabelIcon form: ViennaTestErrorResultItem icon ].
	testLabel changed
]

{ #category : 'module list menu' }
ViennaBrowser >> useInterpreter [
	self animation: self animation asInterpretedAnimation 
]

{ #category : 'module list menu' }
ViennaBrowser >> useTranspiler [
	self animation: self animation asTranspiledAnimation
]

{ #category : 'value pane' }
ViennaBrowser >> value [
	^ self selectedModule
		ifNil: [ 
			self selectedField
				ifNil: [ 
					'{'
						,
							(',' , String cr join: (animation state keys asSortedCollection collect: [ :key | key , ' |-> ' , (animation plainAt: key) ]))
						, '}' ]
				ifNotNil: [ :field | animation plainAt: field ifAbsent: [ String new ] ] ]
		ifNotNil: [ :module | 
			self selectedField
				ifNil: [ 
					| prefix |
					prefix := module , '`'.
					'{'
						,
							(',' , String cr
								join:
									(animation state keys
										select: [ :key | key size > prefix size and: [(key copyFrom: 1 to: prefix size) = prefix ]]
										thenCollect: [ :key | (key copyFrom: prefix size + 1 to: key size) , ' |-> ' , (animation plainAt: key) ])
										asSortedCollection) , '}' ]
				ifNotNil: [ :field | animation plainAt: module , '`' , field ifAbsent: [ String new ] ] ]
]

{ #category : 'value pane menu' }
ViennaBrowser >> valuePaneAccept [
	^ self acceptValue: valuePane text asString
]

{ #category : 'value pane menu' }
ViennaBrowser >> valuePaneDoIt [
	self doItIn: valuePane
]

{ #category : 'value pane menu' }
ViennaBrowser >> valuePaneMenu: aMenu shifted: aBoolean [
	^ aMenu addAllFromPragma: 'viennaBrowserValuePaneMenu' target: self
]

{ #category : 'value pane menu' }
ViennaBrowser >> valuePanePrintIt [
	^ self printItIn: valuePane
]

{ #category : 'value pane' }
ViennaBrowser >> valueSelection [
	^ valueSelection ifNil: [ valueSelection := 1 to: 0 ]
]

{ #category : 'value pane' }
ViennaBrowser >> valueSelection: aSelection [
	valueSelection := aSelection
]

{ #category : 'resources' }
ViennaBrowser >> viennaIcon [
	^ (Form
	extent: (16@16)
	depth: 32
	fromArray: #( 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4289177511 4281611316 4278584838 4279111182 4282729797 4289309097 4294967295 4294967295 4294967295 4294967295 4294967295 4290888129 4280032284 4286019447 4294967295 4292730333 4278584838 4278190080 4278190080 4278190080 4278190080 4278190080 4281282351 4291348680 4294967295 4294967295 4294967295 4281545523 4278190080 4278782217 4294967295 4289243304 4286545791 4285624689 4282992969 4279111182 4278190080 4278190080 4278190080 4278387459 4291480266 4294967295 4289309097 4278190080 4278190080 4279440147 4294967295 4294967295 4294967295 4294967295 4294967295 4294835709 4289309097 4279045389 4278190080 4278190080 4290756543 4294967295 4294243572 4286808963 4278190080 4286216826 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4288848546 4278190080 4278190080 4291875024 4294967295 4294967295 4286216826 4287664272 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4279834905 4278190080 4293125091 4294967295 4287072135 4287598479 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4283782485 4278190080 4289975542 4284587998 4280507284 4289713918 4292143614 4292471806 4291486974 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4286085240 4278785055 4279404286 4278222591 4278222591 4278222591 4278222591 4278222591 4286693374 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4287269514 4278653469 4278982178 4291546317 4294310398 4291224062 4280258046 4290567422 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4288322202 4278519045 4287137928 4294967295 4294967295 4287021566 4290304766 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4292467161 4293125091 4294967295 4294967295 4292800254 4285905150 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4285117182 4294244862 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4283541246 4284132350 4292077822 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295 4294967295)
	offset: (0@0))
]

{ #category : 'workspace pane' }
ViennaBrowser >> workspace [
	^ workspace asString
]

{ #category : 'workspace pane menu' }
ViennaBrowser >> workspacePaneAccept [
	^ self acceptWorkspace: workspacePane text asString
]

{ #category : 'workspace pane menu' }
ViennaBrowser >> workspacePaneDoIt [
	self doItIn: workspacePane
]

{ #category : 'workspace pane menu' }
ViennaBrowser >> workspacePaneMenu: aMenu shifted: aBoolean [
	^ aMenu addAllFromPragma: 'viennaBrowserWorkspacePaneMenu' target: self
]

{ #category : 'workspace pane menu' }
ViennaBrowser >> workspacePanePrintIt [
	self printItIn: workspacePane
]

{ #category : 'workspace pane' }
ViennaBrowser >> workspaceSelection [
	^ workspaceSelection ifNil: [ workspaceSelection := 1 to: 0 ]
]

{ #category : 'workspace pane' }
ViennaBrowser >> workspaceSelection: anInterval [
	workspaceSelection := anInterval
]
