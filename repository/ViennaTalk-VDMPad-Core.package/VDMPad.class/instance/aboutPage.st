request handling-html
aboutPage
	| page |
	page := String new writeStream.
	page nextPutAll: '<html>'.
	page
		cr;
		nextPutAll: '<head>'.
	page
		cr;
		nextPutAll: '<title>about VDMPad</title>'.
	page
		cr;
		nextPutAll: '</head>'.
	page
		cr;
		nextPutAll: '<body>'.
	page
		cr;
		nextPutAll: '<div id="all" style="width: 640px">'.
	page
		cr;
		nextPutAll: '<div id="main" style="float: right; width: 560px">'.
	page
		cr;
		nextPutAll: '<div id="title">'.
	page
		cr;
		nextPutAll:
				'<div style="float: left; font-family: Helvetica, sans-serif; font-size:40px; font-weight: 100">about VDMPad</div> '.
	page
		cr;
		nextPutAll: '</div>'.
	page
		cr;
		nextPutAll: '<div id="ide" style="width: 100%; float: right">'.
	page
		cr;
		nextPutAll: '<p>author: Tomohiro Oda</p>'.
	page
		cr;
		nextPutAll: '<p>copyright: Tomohiro Oda, Software Research Associates, Inc. and Kyushu University</p>'.
	page
		cr;
		nextPutAll: '<p>license: the MIT license</p>'.
	page
		cr;
		nextPutAll: '<hr>'.
	page
		cr;
		nextPutAll:
				'<p>VDMPad is a component provided by <a href="https://github.com/tomooda/ViennaTalk-doc" target="ViennaTalk">ViennaTalk</a> built on <a href="http://pharo.org/" target="pharo">Pharo Smalltalk</a> and the following packages.'.
	page
		cr;
		nextPutAll: '<ul><li><a target="modules" href="http://www.squeaksource.com/OSProcess.html">OSProcess</a></li>'.
	page
		cr;
		nextPutAll: '<li><a target="modules" href="http://zn.stfx.eu/zn/index.html">ZincHTTPComponents</a></li>'.
	page
		cr;
		nextPutAll: '<li><a target="modules" href="http://source.lukas-renggli.ch/petit.html">PetitParser</a></li>'.
	page
		cr;
		nextPutAll: '<li><a target="modules" href="http://stfx.eu/neojson/">NeoJSON</a></li>'.
	page
		cr;
		nextPutAll: '</ul></p>'.
	page
		cr;
		nextPutAll: '<p>VDMPad also uses VDMJ to animate VDM-SL specs.'.
	page
		cr;
		nextPutAll:
				'<ul><li><a target="VDMJ" href="https://sites.google.com/site/nickbattle/home/vdmj">VDMJ</a></li></ul></p>'.
	page
		cr;
		nextPutAll: '<p>VDMPad contains JavaScript programs listed below.'.
	page
		cr;
		nextPutAll: '<ul><li><a target="javascript" href="https://github.com/julianlam/tabIndent.js">tabIndent.js</a></li>'.
	page
		cr;
		nextPutAll: '<li><a target="javascript" href="https://github.com/eligrey/Blob.js">Blob.js</a></li>'.
	page
		cr;
		nextPutAll: '<li><a target="javascript" href="https://github.com/eligrey/FileSaver.js">FileSaver.js</a></li>'.
	page
		cr;
		nextPutAll: '<li><a target="javascript" href="http://codemirror.net/">CodeMirror</a></li></ul></p>'.
	page
		cr;
		nextPutAll:
				'The author(s) of VDMPad deeply appreciate creators and contributors of the above mentioned great pieces of software.'.
	page
		cr;
		nextPutAll:
				'<hr><pre>Copyright (c) 2013-2016 Tomohiro Oda, Software Research Associates, Inc and Kyushu University.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.</pre>'.
	page
		cr;
		nextPutAll: '</div>'.
	page
		cr;
		nextPutAll: '</div>'.
	page
		cr;
		nextPutAll: '</body>'.
	page
		cr;
		nextPutAll: '</html>'.
	^ self responseHtml: page contents