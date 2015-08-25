accessing
plotWidget
	^ plotWidget
		ifNil: [ 
			plotWidget := LWTPlotWidget new
				freeze;
				name: 'Plot';
				nameColor: Color black;
				nameFont: self nameFontForWidgets;
				extent: 80 @ 80;
				data: ((0 to: 4) collect: [ :t | t asFloat cos ]);
				yourself ]