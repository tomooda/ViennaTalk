accessing
animation: aViennaAnimation
	animation ifNotNil: [ animation removeDependent: self ].
	animation := aViennaAnimation.
	aViennaAnimation addDependent: self