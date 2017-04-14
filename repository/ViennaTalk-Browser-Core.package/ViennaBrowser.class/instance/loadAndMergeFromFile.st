module list menu
loadAndMergeFromFile
	self
		fileOpen: 'Load and merge ...'
		extensions: #('vdm' 'vdmsl')
		do: [ :stream | self acceptCode: stream contents ]