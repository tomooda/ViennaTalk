Class {
	#name : #ViennaBrowser,
	#superclass : #Model,
	#instVars : [
		'vdmc',
		'cachedSpec',
		'cachedModulePositions',
		'moduleListPane',
		'fieldListPane',
		'valuePane',
		'codePane',
		'workspace',
		'workspacePane',
		'selectedModule',
		'selectedField',
		'codeSelection',
		'valueSelection',
		'workspaceSelection',
		'directory'
	],
	#category : 'ViennaTalk-Browser-Core'
}

{ #category : #'world menu' }
ViennaBrowser class >> VDMBrowserMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #'VDM Browser')
		action: [ self open ];
		order: 0.48;
		parent: #Tools;
		help: 'VDM-SL browser';
		icon: nil
]

{ #category : #'instance creation' }
ViennaBrowser class >> on: aVDMC [
	^ self new vdmc: aVDMC
]

{ #category : #'instance creation' }
ViennaBrowser class >> open [
	"ViennaBrowser open"

	^ self openOn: VDMC vdmj
]

{ #category : #'instance creation' }
ViennaBrowser class >> openOn: aVDMC [ 
	^ self openOn: aVDMC withLabel: 'VDM Browser'
]

{ #category : #'instance creation' }
ViennaBrowser class >> openOn: aVDMC withLabel: label [
	^ (self on: aVDMC) openLabel: label
]

{ #category : #'value pane' }
ViennaBrowser >> accept: aString var: varName [
	| oldValue |
	oldValue := vdmc plainAt: varName ifAbsent: [ ^ false ].
	vdmc plainAt: varName put: aString.
	vdmc
		plainEvaluate: 'nil'
		ifError: [ :msg | 
			valuePane
				handleEdit: [ 
					valuePane textMorph editor
						selectFrom: aString size to: aString size - 1;
						afterSelectionInsertAndSelect: msg ].
			vdmc plainAt: varName put: oldValue.
			^ false ].
	vdmc changed: #state.
	^ true
]

{ #category : #'value pane' }
ViennaBrowser >> accept: aString var: varName in: moduleName [
	| key oldValue |
	key := moduleName , '`' , varName.
	oldValue := vdmc plainAt: key ifAbsent: [ ^ false ].
	vdmc plainAt: key put: aString.
	vdmc
		plainEvaluate: 'nil'
		ifError: [ :msg | 
			valuePane
				handleEdit: [ 
					valuePane textMorph editor
						selectFrom: aString size to: aString size - 1;
						afterSelectionInsertAndSelect: msg ].
			vdmc plainAt: key put: oldValue.
			^ false ].
	vdmc changed: #state.
	^ true
]

{ #category : #'value pane' }
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
	oldBindings := vdmc state copy.
	prefix := moduleName , '`'.
	newBindings do: [ :assoc | vdmc plainAt: prefix , assoc key put: assoc value ].
	vdmc
		plainEvaluate: 'nil'
		ifError: [ :msg | 
			valuePane
				handleEdit: [ 
					valuePane textMorph editor
						selectFrom: aString size to: aString size - 1;
						afterSelectionInsertAndSelect: msg ].
			oldBindings keysAndValuesDo: [ :key :value | vdmc plainAt: key put: value ].
			^ false ].
	vdmc changed: #state.
	^ true
]

{ #category : #'code pane' }
ViennaBrowser >> acceptCode: aStringOrText [
	vdmc
		ifNotNil: [ 
			| code oldModulePositions oldModuleNames newModulePositions newModuleDict oldSpec newSpec |
			code := aStringOrText asString trimmed copyWith: Character cr.
			oldSpec := vdmc specification.
			oldModulePositions := self modulePositionsFrom: oldSpec.
			oldModuleNames := (oldModulePositions collect: #key) asSet.
			newModulePositions := self modulePositionsFrom: code.
			newModuleDict := Dictionary new.
			newModulePositions do: [ :assoc | newModuleDict at: assoc key put: assoc value ].
			newSpec := String
				new: 1024
				streamContents: [ :stream | 
					stream nextPutAll: (oldSpec copyFrom: 1 to: oldModulePositions first value first - 1).
					oldModulePositions
						do: [ :assoc | 
							newModuleDict
								at: assoc key
								ifPresent: [ :range | stream nextPutAll: (code copyFrom: range first to: range last) ]
								ifAbsent: [ stream nextPutAll: (oldSpec copyFrom: assoc value first to: assoc value last) ] ].
					newModulePositions
						do: [ :assoc | 
							(oldModuleNames includes: assoc key)
								ifFalse: [ stream nextPutAll: (code copyFrom: assoc value first to: assoc value last) ] ] ].
			codePane hasUnacceptedEdits: false.
			vdmc
				specification: newSpec
				ifError: [ :msg | 
					codePane hasUnacceptedEdits: true.
					codePane
						handleEdit: [ 
							codePane textMorph editor
								in: [ :editor | 
									editor selectFrom: editor caret to: editor caret - 1.
									editor afterSelectionInsertAndSelect: msg ] ].
					^ false ].
			self selectModuleNamed: nil.
			^ true ].
	^ false
]

{ #category : #'value pane' }
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
	oldBindings := vdmc state copy.
	newBindings do: [ :assoc | vdmc plainAt: assoc key put: assoc value ].
	vdmc
		plainEvaluate: 'nil'
		ifError: [ :msg | 
			valuePane
				handleEdit: [ 
					valuePane textMorph editor
						selectFrom: aString size to: aString size - 1;
						afterSelectionInsertAndSelect: msg ].
			oldBindings keysAndValuesDo: [ :key :value | vdmc plainAt: key put: value ].
			^ false ].
	vdmc changed: #state.
	^ true
]

{ #category : #'value pane' }
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

{ #category : #'workspace pane' }
ViennaBrowser >> acceptWorkspace: aStringOrText [
	| oldWorkspace |
	oldWorkspace := workspace.
	workspace := aStringOrText.
	oldWorkspace ~= workspace ifTrue: [ self changed: #workspace ]
]

{ #category : #'user interface' }
ViennaBrowser >> build [
	| pane upper lower |
	moduleListPane := self buildModuleList.
	fieldListPane := self buildFieldList.
	valuePane := self buildValuePane.
	codePane := self buildCodePane.
	workspacePane := self buildWorkspacePane.
	pane := BorderedMorph new.
	pane extent: 600 @ 400.
	pane color: Color transparent.
	pane changeProportionalLayout.
	upper := BorderedMorph new.
	upper changeProportionalLayout.
	upper addMorph: moduleListPane fullFrame: (0 @ 0 corner: 0.3 @ 1) asLayoutFrame.
	upper addMorph: fieldListPane fullFrame: (0.3 @ 0 corner: 0.6 @ 1) asLayoutFrame.
	upper addMorph: valuePane fullFrame: (0.6 @ 0 corner: 1 @ 1) asLayoutFrame.
	upper addPaneSplitters.
	lower := LazyTabGroupMorph new.
	lower addLazyPage: codePane label: 'Specification'.
	lower addLazyPage: workspacePane label: 'Workspace'.
	lower selectedPageIndex: 1.
	pane addMorph: upper fullFrame: ((0 @ 0 corner: 1 @ 0.4) asLayoutFrame bottomRightOffset: 0 @ -2).
	pane addMorph: lower fullFrame: ((0 @ 0.4 corner: 1 @ 1) asLayoutFrame topLeftOffset: 0 @ 2).
	pane addPaneSplitters.
	^ pane
]

{ #category : #'user interface' }
ViennaBrowser >> buildCodePane [
	^ (ViennaPluggableTextMorph
		on: self
		text: #code
		accept: #acceptCode:
		readSelection: #codeSelection
		menu: #codePaneMenu:shifted:
		setSelection: #codeSelection:)
		askBeforeDiscardingEdits: true;
		yourself
]

{ #category : #'user interface' }
ViennaBrowser >> buildFieldList [
	^ PluggableListMorph
		on: self
		list: #fieldList
		selected: #fieldSelectionIndex
		changeSelected: #fieldSelectionIndex:
		menu: #fieldListMenu:
]

{ #category : #'user interface' }
ViennaBrowser >> buildModuleList [
	^ PluggableListMorph
		on: self
		list: #moduleList
		selected: #moduleSelectionIndex
		changeSelected: #moduleSelectionIndex:
		menu: #moduleListMenu:
]

{ #category : #'user interface' }
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
		yourself
]

{ #category : #'user interface' }
ViennaBrowser >> buildWorkspacePane [
	^ (ViennaPluggableTextMorph
		on: self
		text: #workspace
		accept: #acceptWorkspace:
		readSelection: #workspaceSelection
		menu: #workspacePaneMenu:shifted:
		setSelection: #workspaceSelection:)
		askBeforeDiscardingEdits: true;
		yourself
]

{ #category : #'code pane' }
ViennaBrowser >> code [
	| section module |
	vdmc ifNil: [ ^ String new ].
	module := self selectedModule.
	module ifNil: [ ^ self specificationTemplate ].
	section := ((self modulePositionsFrom: vdmc specification)
		detect: [ :assoc | assoc key = module ]
		ifNone: [ ^ self specificationTemplate ]) value.
	^ (vdmc specification copyFrom: section first to: section last) asText makeAllColor: Color black
]

{ #category : #'code pane menu' }
ViennaBrowser >> codePaneDoIt [
	self doItIn: codePane
]

{ #category : #'code pane menu' }
ViennaBrowser >> codePaneMenu: aMenu shifted: aBoolean [
	aMenu target: self.
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
			#cancel}}.
	^ aMenu
]

{ #category : #'code pane menu' }
ViennaBrowser >> codePanePrintIt [
	^ self printItIn: codePane
]

{ #category : #'code pane' }
ViennaBrowser >> codeSelection [
	^ codeSelection ifNil: [ codeSelection := 1 to: 0 ]
]

{ #category : #'code pane' }
ViennaBrowser >> codeSelection: aSelection [
	codeSelection := aSelection
]

{ #category : #private }
ViennaBrowser >> directory [
	^ directory ifNil: [ directory := FileSystem root parent ]
]

{ #category : #private }
ViennaBrowser >> doItIn: aPluggableTextMorph [ 
	aPluggableTextMorph
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

{ #category : #private }
ViennaBrowser >> evaluate: aString [ 
	^ self evaluate: aString ifError: [ :msg | msg ]
]

{ #category : #private }
ViennaBrowser >> evaluate: aString ifError: errorBlock [
	^ selectedModule
		ifNil: [ vdmc plainEvaluate: aString ifError: errorBlock ]
		ifNotNil: [ :m | vdmc plainEvaluate: aString in: m ifError: errorBlock ]
]

{ #category : #'field list' }
ViennaBrowser >> fieldList [
	^ self selectedModule
		ifNil: [ vdmc state keys asSortedCollection asArray ]
		ifNotNil: [ :module | 
			| m |
			m := module , '`'.
			(vdmc state keys
				select: [ :name | name size > m size and: [(name copyFrom: 1 to: m size) = m ]]
				thenCollect: [ :name | name copyFrom: m size + 1 to: name size ]) asSortedCollection asArray ]
]

{ #category : #'field list' }
ViennaBrowser >> fieldSelectionIndex [
	^ self fieldList indexOf: self selectedField
]

{ #category : #'field list' }
ViennaBrowser >> fieldSelectionIndex: anInteger [
	self selectFieldNamed: (self fieldList at: anInteger ifAbsent: [])
]

{ #category : #private }
ViennaBrowser >> fileOpen: title do: aBlock [
	(UIManager default
		fileOpen: title
		extensions: #('vdm' 'vdmsl')
		path: self directory
		preview: #text)
		ifNotNil: [ :stream | 
			directory := stream name asFileReference parent.
			aBlock value: stream ]
]

{ #category : #private }
ViennaBrowser >> fileSave: title do: aBlock [
	(UIManager default fileSave: title extensions: #('vdm' 'vdmsl') path: self directory)
		ifNotNil: [ :reference | 
			directory := reference parent.
			reference writeStreamDo: aBlock ]
]

{ #category : #'module list menu' }
ViennaBrowser >> importerModules [
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
ViennaBrowser >> loadAndMergeFromFile [
	self fileOpen: 'Load and merge ...' do: [ :stream | self acceptCode: stream contents ]
]

{ #category : #'module list' }
ViennaBrowser >> moduleList [
	^ vdmc ifNil: [ Array new ] ifNotNil: [ (self modulePositionsFrom: vdmc specification) collect: #key ]
]

{ #category : #'module list menu' }
ViennaBrowser >> moduleListMenu: aMenu [
	| referenceSubMenu |
	aMenu add: 'new and load...' translated selector: #newAndLoadFromFile.
	aMenu add: 'load and merge...' translated selector: #loadAndMergeFromFile.
	aMenu add: 'save all modules...' translated selector: #saveAllModulesToFile.
	self selectedModule ifNotNil: [ aMenu add: 'save the module...' translated selector: #saveAModuleToFile ].
	aMenu addLine.
	aMenu add: 'remove module' translated selector: #removeModule.
	aMenu addLine.
	referenceSubMenu := MenuMorph new defaultTarget: self.
	self importerModules do: [ :name | referenceSubMenu add: name selector: #selectModuleNamed: argument: name ].
	referenceSubMenu hasItems
		ifTrue: [ aMenu add: 'imported by...' translated subMenu: referenceSubMenu ].
	^ aMenu
]

{ #category : #private }
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

{ #category : #'module list menu' }
ViennaBrowser >> newAndLoadFromFile [
	self
		fileOpen: 'New and load from...'
		do: [ :stream | 
			stream contents
				in: [ :source | 
					[ self vdmc specification: source ]
						on: Error
						do: [ :ex | 
							codePane setText: source.
							codePane hasUnacceptedEdits: true ] ] ]
]

{ #category : #'user interface' }
ViennaBrowser >> openLabel: aString [
	self build openInWindowLabeled: aString
]

{ #category : #'value pane' }
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
ViennaBrowser >> removeModule [
	self selectedModule
		ifNotNil: [ :moduleName | 
			| position newSpecification oldSpecification |
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
					^ false ].
			self changed: #moduleList.
			self selectModuleNamed: nil.
			^ true ]
]

{ #category : #'module list menu' }
ViennaBrowser >> saveAModuleToFile [
	self selectedModule
		ifNotNil: [ :module | 
			((self modulePositionsFrom: vdmc specification) detect: [ :assoc | assoc key = module ] ifNone: [  ])
				ifNotNil: [ :assoc | 
					self
						fileSave: 'Save the "' , module , '" modules to...'
						do: [ :stream | 
							stream
								nextPutAll: (vdmc specification copyFrom: assoc value first to: assoc value last);
								close ] ] ]
]

{ #category : #'module list menu' }
ViennaBrowser >> saveAllModulesToFile [
	self
		fileSave: 'Save all modules to...'
		do: [ :stream | 
			stream
				nextPutAll: vdmc specification;
				close ]
]

{ #category : #'field list' }
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

{ #category : #'module list' }
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
			self changed: #code ]
]

{ #category : #'field list' }
ViennaBrowser >> selectedField [
	^ selectedField
]

{ #category : #'module list' }
ViennaBrowser >> selectedModule [
	^ selectedModule
]

{ #category : #'code pane' }
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

{ #category : #updating }
ViennaBrowser >> update: aSymbol [
	aSymbol = #specification
		ifTrue: [ 
			self changed: #code.
			self changed: #moduleList.
			self changed: #fieldList ].
	aSymbol = #state
		ifTrue: [ self changed: #value ]
]

{ #category : #'value pane' }
ViennaBrowser >> value [
	^ self selectedModule
		ifNil: [ 
			self selectedField
				ifNil: [ 
					'{'
						,
							(',' , String cr join: (vdmc state keys asSortedCollection collect: [ :key | key , ' |-> ' , (vdmc plainAt: key) ]))
						, '}' ]
				ifNotNil: [ :field | vdmc plainAt: field ifAbsent: [ String new ] ] ]
		ifNotNil: [ :module | 
			self selectedField
				ifNil: [ 
					| prefix |
					prefix := module , '`'.
					'{'
						,
							(',' , String cr
								join:
									(vdmc state keys
										select: [ :key | key size > prefix size and: [(key copyFrom: 1 to: prefix size) = prefix ]]
										thenCollect: [ :key | (key copyFrom: prefix size + 1 to: key size) , ' |-> ' , (vdmc plainAt: key) ])
										asSortedCollection) , '}' ]
				ifNotNil: [ :field | vdmc plainAt: module , '`' , field ifAbsent: [ String new ] ] ]
]

{ #category : #'value pane menu' }
ViennaBrowser >> valuePaneAccept [
	^ self acceptValue: valuePane text asString
]

{ #category : #'value pane menu' }
ViennaBrowser >> valuePaneDoIt [
	self doItIn: valuePane
]

{ #category : #'value pane menu' }
ViennaBrowser >> valuePaneMenu: aMenu shifted: aBoolean [
	aMenu
		addList:
			{{('find...(f)' translated).
			#find}.
			{('find again (g)' translated).
			#findAgain}.
			{('set search string (h)' translated).
			#setSearchString}.
			#-.
			{('do again (j)' translated).
			#again}.
			{('undo (z)' translated).
			#undo}.
			#-.
			{('copy (c)' translated).
			#copySelection}.
			{('cut (x)' translated).
			#cut}.
			{('paste (v)' translated).
			#paste}.
			{('paste...' translated).
			#pasteRecent}.
			#-.
			{('do it (d)' translated).
			#valuePaneDoIt}.
			{('print it (p)' translated).
			#valuePanePrintIt}.
			#-.
			{('accept (s)' translated).
			#valuePaneAccept}.
			{('cancel (l)' translated).
			#valuePaneCancel}.
			#-.
			{('save contents to file...' translated).
			#saveContentsInFile}}.
	^ aMenu
]

{ #category : #'value pane menu' }
ViennaBrowser >> valuePanePrintIt [
	^ self printItIn: valuePane
]

{ #category : #'value pane' }
ViennaBrowser >> valueSelection [
	^ valueSelection ifNil: [ valueSelection := 1 to: 0 ]
]

{ #category : #'value pane' }
ViennaBrowser >> valueSelection: aSelection [
	valueSelection := aSelection
]

{ #category : #accessing }
ViennaBrowser >> vdmc [
	^ vdmc
]

{ #category : #accessing }
ViennaBrowser >> vdmc: aVDMC [
	vdmc ifNotNil: [ vdmc removeDependent: self ].
	vdmc := aVDMC.
	aVDMC addDependent: self
]

{ #category : #'workspace pane' }
ViennaBrowser >> workspace [
	^ workspace
]

{ #category : #'workspace pane menu' }
ViennaBrowser >> workspacePaneAccept [
	^ self acceptWorkspace: workspacePane text asString
]

{ #category : #'workspace pane menu' }
ViennaBrowser >> workspacePaneDoIt [
	self doItIn: workspacePane
]

{ #category : #'workspace pane menu' }
ViennaBrowser >> workspacePaneMenu: aMenu shifted: aBoolean [
	aMenu
		addList:
			{{('find...(f)' translated).
			#find}.
			{('find again (g)' translated).
			#findAgain}.
			{('set search string (h)' translated).
			#setSearchString}.
			#-.
			{('do again (j)' translated).
			#again}.
			{('undo (z)' translated).
			#undo}.
			#-.
			{('copy (c)' translated).
			#copySelection}.
			{('cut (x)' translated).
			#cut}.
			{('paste (v)' translated).
			#paste}.
			{('paste...' translated).
			#pasteRecent}.
			#-.
			{('do it (d)' translated).
			#workspacePaneDoIt}.
			{('print it (p)' translated).
			#workspacePanePrintIt}.
			#-.
			{('accept (s)' translated).
			#workspaceAccept}.
			{('cancel (l)' translated).
			#workspaceCancel}.
			#-.
			{('copy html' translated).
			#copyHtml}}.
	^ aMenu
]

{ #category : #'workspace pane menu' }
ViennaBrowser >> workspacePanePrintIt [
	self printItIn: workspacePane
]

{ #category : #'workspace pane' }
ViennaBrowser >> workspaceSelection [
	^ workspaceSelection ifNil: [ workspaceSelection := 1 to: 0 ]
]

{ #category : #'workspace pane' }
ViennaBrowser >> workspaceSelection: anInterval [
	workspaceSelection := anInterval
]
