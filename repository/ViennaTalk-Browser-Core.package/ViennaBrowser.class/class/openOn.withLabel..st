instance creation
openOn: aVDMC withLabel: label
	^ self new
		vdmc: aVDMC;
		openLabel: label