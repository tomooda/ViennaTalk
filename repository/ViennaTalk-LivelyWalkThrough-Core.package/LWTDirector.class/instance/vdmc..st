accessing
vdmc: aVDMC
	vdmc
		ifNotNil: [ 
			aVDMC specification: vdmc specification.
			vdmc state keysAndValuesDo: [ :key :value | aVDMC plainAt: key put: value ] ].
	vdmc := aVDMC