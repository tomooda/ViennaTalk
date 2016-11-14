accessing
animation: aViennaAnimation
	animation
		ifNotNil: [ aViennaAnimation specification: animation specification.
			animation state keysAndValuesDo: [ :key :value | aViennaAnimation plainAt: key put: value ] ].
	animation := aViennaAnimation