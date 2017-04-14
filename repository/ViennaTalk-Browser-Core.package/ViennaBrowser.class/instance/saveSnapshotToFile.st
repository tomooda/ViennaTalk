module list menu
saveSnapshotToFile
	| json |
	json := Dictionary new.
	json at: 'engineType' put: self animation engineType.
	json at: 'specification' put: self animation specification.
	json at: 'state' put: self animation state.
	json at: 'workspace' put: self workspace.
	self
		fileSave: 'Save snapshot to...'
		extensions: #('vdmim')
		do: [ :stream | (NeoJSONWriter on: stream) nextPut: json ]