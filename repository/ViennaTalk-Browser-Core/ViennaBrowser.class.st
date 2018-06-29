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
		'selectedModule',
		'selectedField',
		'codeSelection',
		'valueSelection'
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
	self changed: #value.
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
	self changed: #value.
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
	self changed: #value.
	^ true
]

{ #category : #'code pane' }
ViennaBrowser >> acceptCode: aString [
	vdmc
		ifNotNil: [ 
			aString asString ~= cachedSpec
				ifTrue: [ 
					| newModules oldModules source oldSpecification |
					cachedSpec := aString asString.
					oldModules := cachedModulePositions ifNil: [ self modulePositionsFrom: vdmc specification ].
					cachedModulePositions := self modulePositionsFrom: aString asString.
					newModules := Dictionary new.
					cachedModulePositions do: [ :assoc | newModules at: assoc key put: assoc value ].
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
					[ vdmc plainEvaluate: 'nil' ]
						on: Error
						do: [ :ex | 
							vdmc specification: oldSpecification.
							codePane
								handleEdit: [ 
									codePane textMorph editor
										in: [ :editor | 
											editor selectFrom: editor caret to: editor caret - 1.
											editor afterSelectionInsertAndSelect: ex messageText ] ].
							^ false ].
					self changed: #moduleList.
					self changed: #fieldList.
					self changed: #value.
					^ true ] ].
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
	self changed: #value.
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

{ #category : #'user interface' }
ViennaBrowser >> buildCodePane [
	^ (PluggableTextMorph
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
	^ (PluggableTextMorph
		on: self
		text: #value
		accept: #acceptValue:
		readSelection: #valueSelection
		menu: #valuePaneMenu:shifted:
		setSelection: #valueSelection:)
		askBeforeDiscardingEdits: true;
		yourself
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

{ #category : #'code pane' }
ViennaBrowser >> codeSelection [
	^ codeSelection ifNil: [ codeSelection := 1 to: 0 ]
]

{ #category : #'code pane' }
ViennaBrowser >> codeSelection: aSelection [
	codeSelection := aSelection
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
				select: [ :name | (name copyFrom: 1 to: m size) = m ]
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

{ #category : #'module list' }
ViennaBrowser >> moduleList [
	^ vdmc
		ifNil: [ Array new ]
		ifNotNil: [ (cachedModulePositions ifNil: [ cachedModulePositions := self modulePositionsFrom: vdmc specification ]) collect: #key ]
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
	^ (1 to: modulesAndPositions size)
		collect: [ :index | (modulesAndPositions at: index) key -> ((modulesAndPositions at: index) value to: (ends at: index)) ]
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

{ #category : #'user interface' }
ViennaBrowser >> openLabel: aString [
	| pane upper |
	moduleListPane := self buildModuleList.
	fieldListPane := self buildFieldList.
	valuePane := self buildValuePane.
	codePane := self buildCodePane.
	pane := BorderedMorph new.
	pane color: Color transparent.
	pane changeProportionalLayout.
	upper := BorderedMorph new.
	upper changeProportionalLayout.
	upper addMorph: moduleListPane fullFrame: (0 @ 0 corner: 0.3 @ 1) asLayoutFrame.
	upper addMorph: fieldListPane fullFrame: (0.3 @ 0 corner: 0.6 @ 1) asLayoutFrame.
	upper addMorph: valuePane fullFrame: (0.6 @ 0 corner: 1 @ 1) asLayoutFrame.
	pane addMorph: upper fullFrame: ((0 @ 0 corner: 1 @ 0.5) asLayoutFrame bottomRightOffset: 0 @ -2).
	pane addMorph: codePane fullFrame: ((0 @ 0.5 corner: 1 @ 1) asLayoutFrame topLeftOffset: 0 @ 2).
	pane addPaneSplitters.
	pane openInWindowLabeled: aString
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
	self changed: #fieldSelectionIndex.
	self changed: #value
]

{ #category : #'module list' }
ViennaBrowser >> selectModuleNamed: aString [ 
	selectedModule := (self moduleList includes: aString)
				ifTrue: [aString].
	selectedField := nil.
	self changed: #moduleSelectionIndex.
	self changed: #fieldList.
	self changed: #fieldSelectionIndex.
	self changed: #code.
	self changed: #value
]

{ #category : #'field list' }
ViennaBrowser >> selectedField [
	^ selectedField
]

{ #category : #'module list' }
ViennaBrowser >> selectedModule [
	^ selectedModule
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
										select: [ :key | (key copyFrom: 1 to: prefix size) = prefix ]
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
	vdmc := aVDMC
]
