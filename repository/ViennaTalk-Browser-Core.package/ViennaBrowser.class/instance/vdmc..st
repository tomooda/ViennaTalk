accessing
vdmc: aVDMC
	vdmc ifNotNil: [ vdmc removeDependent: self ].
	vdmc := aVDMC.
	aVDMC addDependent: self