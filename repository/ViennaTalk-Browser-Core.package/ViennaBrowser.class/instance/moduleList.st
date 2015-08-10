module list
moduleList
	^ vdmc
		ifNil: [ Array new ]
		ifNotNil: [ (cachedModulePositions ifNil: [ cachedModulePositions := self modulePositionsFrom: vdmc specification ]) collect: #key ]