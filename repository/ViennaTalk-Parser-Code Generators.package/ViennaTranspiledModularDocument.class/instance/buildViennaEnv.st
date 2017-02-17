private
buildViennaEnv
	| env |
	env := Dictionary new.
	self keysDo: [ :key | env at: key put: '(self at: ' , key storeString , ')' ].
	viennaEnv := env