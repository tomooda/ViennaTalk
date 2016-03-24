operations
moveFront
	self owner ifNotNil: [ self owner privateAddMorph: self atIndex: ((self owner submorphIndexOf: self) - 1 max: 1) ]