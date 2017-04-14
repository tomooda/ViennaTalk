menu
moduleListMenu: aBuilder
	<contextMenu>
	<viennaBrowserModuleListMenu>
	(aBuilder item: #'new and load...' translated) selector: #newAndLoadFromFile.
	(aBuilder item: #'load and merge...' translated) selector: #loadAndMergeFromFile.
	(aBuilder item: #'save snapshot...' translated) selector: #saveSnapshotToFile.
	(aBuilder item: #'save all modules...' translated) selector: #saveAllModulesToFile.
	aBuilder model selectedModule
		ifNotNil: [ (aBuilder item: #'save the module...' translated) selector: #saveAModuleToFile ].
	aBuilder items last withSeparatorAfter.
	(aBuilder item: #'remove module' translated)
		selector: #removeModulel;
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