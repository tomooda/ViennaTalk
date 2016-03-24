operations
moveBack
	self owner
		ifNotNil: [ self owner privateAddMorph: self atIndex: ((self owner submorphIndexOf: self) + 2 min: self owner submorphs size + 1) ]