accessing
nameFontForWidgets
	^ LogicalFont
		familyName: TextStyle default defaultFont familyName
		pointSize: TextStyle default defaultFont pointSize
		stretchValue: 5
		weightValue: 700
		slantValue: 0