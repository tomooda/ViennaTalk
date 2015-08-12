accessing
vdmc
	^ vdmc ifNil: [ vdmc := self defaultVDMC ]