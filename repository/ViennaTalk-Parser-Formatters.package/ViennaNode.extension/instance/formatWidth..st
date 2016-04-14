*ViennaTalk-Parser-Formatters
formatWidth: anInteger
	^ ViennaVDMFormatter new
		maxSizePerLine: anInteger;
		format: self