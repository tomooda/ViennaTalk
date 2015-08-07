module list
moduleList
	^ vdmc ifNil: [ Array new ] ifNotNil: [ (self modulePositionsFrom: vdmc specification) collect: #key ]