private
fileSave: title do: aBlock
	(UIManager default fileSave: title extensions: #('vdm' 'vdmsl') path: self directory)
		ifNotNil: [ :reference | 
			directory := reference parent.
			reference writeStreamDo: aBlock ]