code generation-definitions
modularDocument: aViennaNode env: aDictionary
	| moduleNames classNames documentClass |
	moduleNames := aViennaNode collect: #first.
	documentClass := self createDocumentClassWithInstVars: (moduleNames collect: #uncapitalized).
	classNames := moduleNames
		collect: [ :moduleName | 
			(self requestClassName: moduleName)
				ifNil: [ ^ nil ]
				ifNotNil: [ :name | 
					aDictionary at: moduleName put: name.
					name ] ].
	aViennaNode do: [ :node | self generate: node env: aDictionary ].
	self
		defineMethod:
			(String
				new: 1024
				streamContents: [ :stream | 
					stream
						nextPutAll: 'initialize';
						cr;
						nextPutAll: 'super initialize.';
						cr.
					moduleNames
						with: classNames
						do: [ :moduleName :className | 
							stream
								nextPutAll: moduleName uncapitalized;
								nextPutAll: ' := ';
								nextPutAll: className;
								nextPutAll: ' new.';
								cr ].
					aViennaNode
						do: [ :moduleNode | 
							| moduleName |
							moduleName := moduleNode first.
							moduleNode second first
								ifNotNil: [ :importDefinitionListNode | 
									importDefinitionListNode
										do: [ :importDefinitionNode | 
											| importedModuleName |
											importedModuleName := importDefinitionNode first.
											stream
												nextPutAll: moduleName uncapitalized;
												nextPutAll: String space;
												nextPutAll: importedModuleName;
												nextPutAll: ': ';
												nextPutAll: importedModuleName uncapitalized;
												nextPutAll: '.';
												cr ] ] ].
					moduleNames
						do: [ :moduleName | 
							stream
								nextPutAll: moduleName uncapitalized;
								nextPutAll: ' init.';
								cr ] ])
		in: documentClass
		protocol: 'initialize-release'.
	moduleNames
		do: [ :moduleName | self defineMethod: moduleName , ' ^' , moduleName uncapitalized in: documentClass protocol: 'accessing' ].
	^ documentClass