request handling-html
mainPage
	| page |
	page := String new writeStream.
	page nextPutAll: '<html ondragenter="return false;" ondragover="return false;" 
        ondrop="return VDMPad.acceptDroppedFile(event);">'.
	page cr; nextPutAll: '<head>'.
	page cr; nextPutAll: '<title>VDMPad</title>'.
	page cr; nextPutAll: '<script src="/blob.js"></script>'.
	page cr; nextPutAll: '<link rel="stylesheet" href="/codemirror/theme/vdmpad.css">'.
	page cr; nextPutAll: '<link rel="stylesheet" href="/codemirror/lib/codemirror.css">'.
	page cr; nextPutAll: '<script src="/codemirror/lib/codemirror.js"></script>'.
	page cr; nextPutAll: '<script src="/codemirror/addon/edit/matchbrackets.js"></script>'.
	page cr; nextPutAll: '<script src="/codemirror-vdm.js"></script>'.
	page cr; nextPutAll: '<script src="/codemirror/addon/iOS/iOSkeyboard.js"></script>'.
	page cr; nextPutAll: '<script src="/codemirror/addon/iOS/iOSselection.js"></script>'.
	page cr; nextPutAll: '<script src="/tabIndent.js"></script>'.
	page cr; nextPutAll: '<script src="/fileSaver.js"></script>'.
	page cr; nextPutAll: '<script src="/VDMPad.js"></script>'.
	page cr; nextPutAll: '</head>'.
	page cr; nextPutAll: '<body>'.
	page cr; nextPutAll: '<div id="all" style="width: 640px">'.
	page cr; nextPutAll: '<div id="menu" style="float: left; width: 80px">'.
	page cr; nextPutAll: '<div id="root_menu" style="margin-top: 40px" width: 100%><img id="rootMenuIcon" src="/rootMenuOff.png" alt="root menu"></div><div id="file_items" style="width: 100%"></div>'.
	page cr; nextPutAll: '</div>'.
	page cr; nextPutAll: '<div id="main" style="float: right; width: 560px">'.
	page cr; nextPutAll: '<div id="title">'.
	page cr; nextPutAll: '<div style="float: left; font-family: Helvetica, sans-serif; font-size:40px; font-weight: 100">VDMPad</div>  <div style="float: right; font-size: 10px; text-align: right">powered by Squeak Smalltalk with <a style="text-decoration: none" target="VDMJ" href="/VDMJcopyright.html">VDMJ</a><br><a style="text-decoration: none" target="aboutVDMPad" href="/about.html">about VDMPad</a></div>'.
	page cr; nextPutAll: '</div>'.
	page cr; nextPutAll: '<div id="ide" style="width: 100%; float: right">'.
	page cr; nextPutAll: '<form method="POST" action="/eval">'.
	page cr; nextPutAll: '<div style="border-width: 1px; border-style: solid; border-color: black"><textarea title="Enter a specificaton here." id="source" name="source"></textarea></div>'.
	page cr; nextPutAll: '<div id="states" style="margin-top: 20px"></div>'.
	page cr; nextPutAll: '<div align=right><input title="Initializes the states" type="button" onClick="VDMPad.init()" value="Initialize" style="cursor: pointer; background-color: white; width: 150px; height: 20px"></div>'.
	page cr; nextPutAll: '<div id="workspace" align=right style="margin-top: 30px">'.
	page cr; nextPutAll: '<div style="border-width: 1px; border-style: solid; border-color: black" align=left><textarea title="Write expressions to evaluate." id="expression"></textarea></div>'.
	page cr; nextPutAll: '<input title="Evaluates the expression selected in the above textbox" type="button" onClick="VDMPad.eval()" value="evaluate" style="cursor: pointer; background-color: #f0f0f0; width: 200px; height: 30px"><br>'.
	page cr; nextPutAll: '<input id="make it a testcase" title="Makes the previous evaluation as a testcase." type="button" onClick="VDMPad.addTestcase()" value="make it a testcase" style="visibility: hidden; cursor: pointer; background-color: #ffffff; width: 150px; height: 20px"><br>'.
	page cr; nextPutAll: '<textarea  title="Displays the return value of the evaluation." id="value" name="value" readonly  style="width: 100%; height: 50px; resize: vertical"></textarea></div>'.
	page cr; nextPutAll: '<div id="valueVisual"></div>'.
	page cr; nextPutAll: '<hr>'.
	page cr; nextPutAll: '<div title="Displays error messages"  id="message"></div>'.
	page cr; nextPutAll: '<div id="unittest"></div>'.
	page cr; nextPutAll: '</div>'.
	page cr; nextPutAll: '</div>'.
	page cr; nextPutAll: '</div>'.
	page cr; nextPutAll: '<script>var elems = document.getElementsByTagName("textarea"); for (var i = 0; i < elems.length; i++) {var e = elems[i]; if (e.getAttribute("id") != "source") tabIndent.render(e)}; </script>'.
	page cr; nextPutAll: '<script>VDMPad.setupIdeNodes();VDMPad.setupMenuNodes();</script>'.
	page cr; nextPutAll: '<script>VDMPad.loadFromLocalStorage();</script>'.
	page cr; nextPutAll: '</body>'.
	page cr; nextPutAll: '</html>'.
	^ self responseHtml: page contents