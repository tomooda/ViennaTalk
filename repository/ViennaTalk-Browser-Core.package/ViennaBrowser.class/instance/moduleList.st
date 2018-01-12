module list
moduleList
	^ animation ifNil: [ Array new ] ifNotNil: [ ((self modulePositionsFrom: animation specification) collect: #key) asSortedCollection asArray]