module list menu
saveAModuleToFile
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