menu
moduleListMenu: aBuilder
	<contextMenu>
	<viennaDirectoryBrowserModuleListMenu>
	(aBuilder item: #'open dir...' translated) selector: #openDirectory.
	(aBuilder item: #'copy and merge file...' translated) selector: #loadAndMergeFromFile.
	aBuilder items last withSeparatorAfter.
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
	aBuilder model importerModules
		ifNotEmpty: [ :modules | 
			(aBuilder item: #'imported by...' translated)
				with: [ modules
						do: [ :module | 
							(aBuilder item: module asSymbol)
								selector: #selectModuleNamed:;
								arguments: (Array with: module asString) ] ] ]