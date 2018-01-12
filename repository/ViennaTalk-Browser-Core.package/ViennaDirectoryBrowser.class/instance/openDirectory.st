module list menu
openDirectory
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