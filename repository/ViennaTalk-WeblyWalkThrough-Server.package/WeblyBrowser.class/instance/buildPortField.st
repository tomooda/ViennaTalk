user interface
buildPortField
	^ (PluggableTextFieldMorph on: self text: #port accept: #port:)
		setBalloonText: 'port number of the web api server';
		askBeforeDiscardingEdits: true;
		acceptOnCR: true;
		convertTo: Integer;
		hideScrollBarsIndefinitely: true;
		yourself