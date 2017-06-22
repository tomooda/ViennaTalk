building
debuggerTransmissionsIn: browser

	super debuggerTransmissionsIn: browser.
	browser transmit
		from: #stack port: #selection;
		to: #vdmSource;
		andShow: [ :composite :aContext | self vdmSourceIn: composite forContext: aContext ]
