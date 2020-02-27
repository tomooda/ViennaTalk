"
ViennaDirectoryBrowser is a VDM browser for file-based development of VDM specs.
ViennaDirectoryBrowser deals with moduled specifications and synchronizes modules on the browser with files in a directory.

Each module is saved as an individual file named <module name>.vdmsl.
The content  of workspace is also saved into .workspace file in the same directory.
"
Class {
	#name : #ViennaDirectoryBrowser,
	#superclass : #ViennaBrowser,
	#instVars : [
		'basePath'
	],
	#classVars : [
		'DefaultBasePath'
	],
	#category : 'ViennaTalk-Browser-Core'
}

{ #category : #'world menu' }
ViennaDirectoryBrowser class >> VDMBrowserMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #'VDM Directory Browser')
		action: [ self open ];
		order: 0.11;
		parent: #ViennaTalk;
		help: 'File-based VDM-SL browser';
		icon: nil
]

{ #category : #accessing }
ViennaDirectoryBrowser class >> defaultBasePath [
	(DefaultBasePath isNil or: [ DefaultBasePath isDirectory not ])
		ifTrue: [ DefaultBasePath := FileLocator desktop ].
	^ DefaultBasePath
]

{ #category : #accessing }
ViennaDirectoryBrowser class >> defaultBasePath: aFileReference [
	DefaultBasePath := aFileReference
]

{ #category : #menu }
ViennaDirectoryBrowser class >> moduleListMenu: aBuilder [
	<contextMenu>
	<viennaDirectoryBrowserModuleListMenu>
	(aBuilder item: #'open dir...' translated) selector: #openDirectory.
	(aBuilder item: #'copy and merge file...' translated) selector: #loadAndMergeFromFile.
	aBuilder items last withSeparatorAfter.
	(aBuilder item: #'import UnitTesting module' translated)
		selector: #importUnitTestingModule.
	(aBuilder item: #'remove module' translated)
		selector: #removeModule;
		withSeparatorAfter.
	aBuilder model animation class = ViennaTranspiledAnimation
		ifTrue: [ (aBuilder item: #'use interpreter' translated)
				selector: #useInterpreter;
				withSeparatorAfter ]
		ifFalse: [ (aBuilder item: #'use transpiler' translated)
				selector: #useTranspiler;
				withSeparatorAfter ].
	(aBuilder item: #'generate a Smalltalk script (single module)...' translated)
		selector: #generateSmalltalkScript.
	(aBuilder item: #'generate classes (all modules)...' translated)
		selector: #generateSmalltalkClasses.
	(aBuilder item: #'generate object (all modules)...' translated)
		selector: #generateSmalltalkObject;
		withSeparatorAfter.
	(aBuilder item: #'run module test' translated)
		selector: #runTestModule.
	(aBuilder item: #'run tests' translated)
		selector: #runAllTests;
		withSeparatorAfter.
	aBuilder model importerModules
		ifNotEmpty: [ :modules | 
			(aBuilder item: #'imported by...' translated)
				with: [ modules
						do: [ :module | 
							(aBuilder item: module asSymbol)
								selector: #selectModuleNamed:;
								arguments: (Array with: module asString) ] ] ]
]

{ #category : #'world menu' }
ViennaDirectoryBrowser class >> viennaToolsMenuOn: aBuilder [
	<ViennaToolsMenu>
	(aBuilder item: #'VDM Directory Browser')
		action: [ self open ];
		order: 0.11;
		help: 'File-based VDM-SL browser';
		icon: nil
]

{ #category : #'code pane' }
ViennaDirectoryBrowser >> acceptCode: aStringOrText [
	^ self acceptCode: aStringOrText newModuleAndSourceDo: [ :module | self saveModule: module ]
]

{ #category : #'workspace pane' }
ViennaDirectoryBrowser >> acceptWorkspace: aStringOrText [
	super acceptWorkspace: aStringOrText.
	self basePath / '.workspace'
		writeStreamDo: [ :stream | 
			stream
				truncate;
				nextPutAll: (aStringOrText asString replaceAll: Character cr with: Character lf) ].
	^ true
]

{ #category : #accessing }
ViennaDirectoryBrowser >> basePath [
	[ basePath isNil or: [ basePath isDirectory not ] ]
		whileTrue: [ basePath := self requestBasePath ].
	^ basePath
]

{ #category : #accessing }
ViennaDirectoryBrowser >> basePath: aFileReference [
	basePath := aFileReference
]

{ #category : #'code pane' }
ViennaDirectoryBrowser >> basicAcceptCode: aStringOrText [
	^ self acceptCode: aStringOrText newModuleAndSourceDo: nil
]

{ #category : #'workspace pane' }
ViennaDirectoryBrowser >> basicAcceptWorkspace: aStringOrText [
	super acceptWorkspace: aStringOrText
]

{ #category : #'module list menu' }
ViennaDirectoryBrowser >> moduleListMenu: aMenu [
	^ aMenu addAllFromPragma: 'viennaDirectoryBrowserModuleListMenu' target: self
]

{ #category : #'module list menu' }
ViennaDirectoryBrowser >> openDirectory [
	self requestBasePath
		ifNotNil: [ :dirRef | 
			self basePath: dirRef.
			self
				basicAcceptCode:
					(String
						new: 1024
						streamContents: [ :writeStream | 
							dirRef files
								do: [ :fileRef | 
									(fileRef basename endsWith: '.vdmsl')
										ifTrue: [ fileRef
												readStreamDo:
													[ :stream | writeStream nextPutAll: (stream contents replaceAll: Character lf with: Character cr) ] ] ] ]).
			dirRef / '.workspace'
				in: [ :workspaceFile | 
					workspaceFile isFile
						ifTrue: [ self
								basicAcceptWorkspace: (workspaceFile contents replaceAll: Character lf with: Character cr) ] ] ]
]

{ #category : #'module list menu' }
ViennaDirectoryBrowser >> removeModule [
	^ self selectedModule
		ifNotNil: [ :module | 
			super removeModule
				and: [ | file |
					file := self basePath / (module , '.vdmsl').
					(file isFile and: [ UIManager default confirm: 'Remove the ' , file basename , ' file?' ])
						ifTrue: [ file delete ].
					true ] ]
		ifNil: [ false ]
]

{ #category : #accessing }
ViennaDirectoryBrowser >> requestBasePath [
	^ (UIManager default
		chooseDirectory: 'Choose a VDM spec directory'
		from: self class defaultBasePath) ifNotNil: [ :dir | DefaultBasePath := dir ]
]

{ #category : #'module list menu' }
ViennaDirectoryBrowser >> saveModule: aString [
	((self modulePositionsFrom: animation specification)
		detect: [ :assoc | assoc key = aString ]
		ifNone: [  ])
		ifNotNil: [ :assoc | 
			self basePath / (aString , '.vdmsl')
				writeStreamDo: [ :stream | 
					stream
						truncate;
						nextPutAll:
							((animation specification copyFrom: assoc value first to: assoc value last)
								replaceAll: Character cr
								with: Character lf);
						close ] ]
]
