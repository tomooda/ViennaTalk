private
fileOpen: title do: aBlock
	(UIManager default
		fileOpen: title
		extensions: #('vdm' 'vdmsl')
		path: self directory
		preview: #text)
		ifNotNil: [ :stream | 
			directory := stream name asFileReference parent.
			aBlock value: stream ]