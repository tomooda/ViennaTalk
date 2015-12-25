converting
formatWidth: anInteger
	^ ViennaVDMFormatter new
		maxSizePerLine: anInteger;
		format: self