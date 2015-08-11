module list menu
importerModules
	| parser |
	self selectedModule isNil
		ifTrue: [ ^ Array new ].
	parser := 'from' asParser , #space asParser plus , self selectedModule asParser , #space asParser.
	^ ((self modulePositionsFrom: vdmc specification)
		select: [ :assoc | 
			assoc key ~= self selectedModule
				and: [ (parser matchesIn: (vdmc specification copyFrom: assoc value first to: assoc value last)) notEmpty ] ])
		collect: [ :assoc | assoc key ]