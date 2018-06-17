registry
register: aViennaVDMJ
	(self registry includes: self)
		ifFalse: [ self registry add: aViennaVDMJ ].
	^ aViennaVDMJ