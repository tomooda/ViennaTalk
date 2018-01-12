module list menu
removeModule
	^ self selectedModule
		ifNotNil: [ :module | 
			super removeModule
				and: [ | file |
					file := self basePath / (module , '.vdmsl').
					(file isFile and: [ UIManager default confirm: 'Remove the ' , file basename , ' file?' ])
						ifTrue: [ file delete ].
					true ] ]
		ifNil: [ false ]