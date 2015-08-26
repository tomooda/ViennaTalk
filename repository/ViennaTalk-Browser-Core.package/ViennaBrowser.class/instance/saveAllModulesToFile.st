module list menu
saveAllModulesToFile
	self
		fileSave: 'Save all modules to...'
		do: [ :stream | 
			stream
				nextPutAll: vdmc specification;
				close ]