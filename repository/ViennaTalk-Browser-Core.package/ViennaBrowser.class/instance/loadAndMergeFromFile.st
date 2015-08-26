module list menu
loadAndMergeFromFile
	self fileOpen: 'Load and merge ...' do: [ :stream | self acceptCode: stream contents ]