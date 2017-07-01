building presentations
vdmSourceWidgetIn: composite forContext: aContext

	^ composite vdmSource
		title: 'VDM';
		format: [ aContext specification ifNotNil: #debuggerSource ifNil: [ Text new ] ]