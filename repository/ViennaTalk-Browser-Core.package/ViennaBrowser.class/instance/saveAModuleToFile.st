module list menu
saveAModuleToFile
	self selectedModule
		ifNotNil: [ :module | 
			((self modulePositionsFrom: animation specification)
				detect: [ :assoc | assoc key = module ]
				ifNone: [  ])
				ifNotNil: [ :assoc | 
					self
						fileSave: 'Save the "' , module , '" modules to...'
						extensions: #('vdm' 'vdmsl')
						do: [ :stream | 
							stream
								nextPutAll: (animation specification copyFrom: assoc value first to: assoc value last) close ] ] ]