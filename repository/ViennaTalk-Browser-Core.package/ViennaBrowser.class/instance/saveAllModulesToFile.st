module list menu
saveAllModulesToFile
	self
		fileSave: 'Save all modules to...'
		extensions: #('vdm' 'vdmsl')
		do: [ :stream | 
			stream
				nextPutAll: animation specification;
				close ]