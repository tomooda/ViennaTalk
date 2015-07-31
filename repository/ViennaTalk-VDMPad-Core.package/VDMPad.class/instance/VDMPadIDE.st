request handling-javascript
VDMPadIDE
	^ 'VDMPad = {};
VDMPad.vdmClassicEnabled = false;
VDMPad.invExceptionsEnabled = false;
VDMPad.visualEnabled = false;
VDMPad.runtimeCheckingEnabled = true;
VDMPad.unittestEnabled = false;
VDMPad.unittestRunning = false;
VDMPad.protoTestcase = null;
VDMPad.testcases = [];
VDMPad.currentSource = null;

VDMPad.enableRuntimeChecking = function () {
    if (localStorage) {
        localStorage.setItem("Config`runtimeCheckingEnabled", "true");
    }
    VDMPad.runtimeCheckingEnabled = true;
    VDMPad.loadFromLocalStorage();
};
VDMPad.disableRuntimeChecking = function () {
    if (localStorage) {
        localStorage.setItem("Config`runtimeCheckingEnabled", "false");
    }
    VDMPad.runtimeCheckingEnabled = false;
    VDMPad.loadFromLocalStorage();
};

VDMPad.enableUnittest = function () {
    if (localStorage) {
        localStorage.setItem("Config`unittestEnabled", "true");
    }
    VDMPad.unittestEnabled = true;
    if (VDMPad.protoTestcase != null) {
        VDMPad.enableMakeItATestcaseButton();
    }
    VDMPad.startTests();
};
VDMPad.disableUnittest = function () {
    if (localStorage) {
        localStorage.setItem("Config`unittestEnabled", "false");
    }
    VDMPad.unittestEnabled = false;
    VDMPad.disableMakeItATestcaseButton();
    while (VDMPad.unittestNode.firstChild)
        VDMPad.unittestNode.removeChild(VDMPad.unittestNode.firstChild);
};

VDMPad.enableVisual = function () {
    if (localStorage) {
        localStorage.setItem("Config`visualEnabled", "true");
    }
    VDMPad.visualEnabled = true;
    VDMPad.loadFromLocalStorage();
};

VDMPad.disableVisual = function () {
    if (localStorage) {
        localStorage.setItem("Config`visualEnabled", "false");
    }
    VDMPad.visualEnabled = false;
    VDMPad.loadFromLocalStorage();
};

VDMPad.enableInvExceptions = function () {
    if (localStorage) {
        localStorage.setItem("Config`invExceptionsEnabled", "true");
    }
    VDMPad.invExceptionsEnabled = true;
    VDMPad.loadFromLocalStorage();
};

VDMPad.disableInvExceptions = function () {
    if (localStorage) {
        localStorage.setItem("Config`invExceptionsEnabled", "false");
    }
    VDMPad.invExceptionsEnabled = false;
    VDMPad.loadFromLocalStorage();
};


VDMPad.enableVDMClassic = function () {
    if (localStorage) {
        localStorage.setItem("Config`vdmClassicEnabled", "true");
    }
    VDMPad.vdmClassicEnabled = true;
    VDMPad.loadFromLocalStorage();
};

VDMPad.disableVDMClassic = function () {
    if (localStorage) {
        localStorage.setItem("Config`vdmClassicEnabled", "false");
    }
    VDMPad.vdmClassicEnabled = false;
    VDMPad.loadFromLocalStorage();
};

VDMPad.enableMakeItATestcaseButton = function () {
    VDMPad.makeItATestcaseButtonNode.style.visibility = "visible";
}
VDMPad.disableMakeItATestcaseButton = function () {
    VDMPad.makeItATestcaseButtonNode.style.visibility = "hidden";
}

VDMPad.addTestcase = function() {
    if (VDMPad.protoTestcase != null) {
        VDMPad.testcases.push(VDMPad.protoTestcase);
    }
    if (localStorage) {
        var snapshot = JSON.parse(localStorage.getItem("`lastSnapshot"));
        snapshot.testcases = VDMPad.testcases;
        localStorage.setItem("`lastSnapshot", JSON.stringify(snapshot));
    }
    VDMPad.disableMakeItATestcaseButton();
    VDMPad.startTests();
}

VDMPad.testcase_index = -1;
VDMPad.startTests = function () {
    if (VDMPad.unittestEnabled && !VDMPad.unittestRunning) {
        VDMPad.unittestRunning = true;
        while (VDMPad.unittestNode.firstChild)
            VDMPad.unittestNode.removeChild(VDMPad.unittestNode.firstChild);
        VDMPad.testcase_index = 0;
        window.setTimeout("VDMPad.runOneTestcase()",0);
    }
};

VDMPad.runOneTestcase = function() {
    var testcase = VDMPad.testcases[VDMPad.testcase_index];
    if (VDMPad.unittestEnabled && testcase && VDMPad.currentSource != null) {
        var id = {};
        testcase["id"] = id;
        testcase["source"] = VDMPad.currentSource;
        var req = new XMLHttpRequest();
        req.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200 && VDMPad.unittestEnabled) {
                var result = JSON.parse(this.responseText);
                var okNode = document.createElement("div");
                okNode.style.fontSize = "9pt";
                okNode.style.cursor = "pointer";
                if (result == true) {
                    var message = "OK: "+testcase["expression"];
                    okNode.style.color = "green";
                    okNode.textContent = message;
                    okNode.innerText = message;
                } else {
                    var message = "FAILED: "+testcase["expression"]+" => "+result;
                    okNode.style.color = "red";
                    okNode.textContent = message;
                    okNode.innerText = message;
                }
                var testcase_print = [];
                for (var key in testcase) {
                    if (key == "expression" || key == "value") {
                        testcase_print[key] = key+" : "+testcase[key];
                    }
                    if (key == "prestates" || key == "poststates") {
                        testcase_print[key] = key+" : "+JSON.stringify(testcase[key]);
                    }
                }
                okNode.title = testcase_print["prestates"]+"\n"+ testcase_print["expression"]+"\n"+ testcase_print["value"]+"\n"+ testcase_print["poststates"];
                VDMPad.unittestNode.appendChild(okNode);
                VDMPad.testcase_index = VDMPad.testcase_index + 1;
                okNode.onclick = function () {
                    var testcaseNode = document.createElement("pre");
                    testcaseNode.style.color = "black";
                    testcaseNode.style.marginLeft = "20px";
                    testcaseNode.innerText = okNode.title;
                    testcaseNode.textContent = okNode.title;
                    okNode.appendChild(testcaseNode);
                    okNode.onclick = undefined;
                    okNode.style.cursor = "default";
                    var delNode = document.createElement("div");
                    delNode.style.backgroundColor = "black";
                    delNode.style.color = "white";
                    delNode.style.width = "100px";
                    delNode.style.textAlign = "center";
                    delNode.style.border= "border: solid 2px black";
                    delNode.innerText = "delete";
                    delNode.textContent = "delete";
                    delNode.style.cursor = "pointer";
                    var deleteTestcase = function () {
                        VDMPad.testcases = VDMPad.testcases.filter(function(n) {return n["id"] != id;});
                        okNode.parentNode.removeChild(okNode);
                        if (localStorage) {
                            var snapshot = JSON.parse(localStorage.getItem("`lastSnapshot"));
                            snapshot.testcases = VDMPad.testcases;
                            localStorage.setItem("`lastSnapshot", JSON.stringify(snapshot));
                        }
                    };
                    delNode.onclick= deleteTestcase;
                    testcaseNode.appendChild(delNode);
                };
                window.setTimeout("VDMPad.runOneTestcase()",0);
            }
        };
        var queryOptions = "?";
        if (VDMPad.vdmClassicEnabled) {
            queryOptions += "classic=&";
        }
        if (VDMPad.invExceptionsEnabled) {
            queryOptions += "exceptions=&";
        }
        if (!VDMPad.runtimeCheckingEnabled) {
            queryOptions += "ignoreRuntimeChecking=&";
        }
        req.open("POST", "/test"+queryOptions.substring(0,queryOptions.length-1));
        req.setRequestHeader("Content-Type", "application/json");
        req.send(JSON.stringify(testcase));
    } else {
        VDMPad.testcase_index = -1;
        VDMPad.unittestRunning = false;
    }
}

VDMPad.init = function () {
    VDMPad.messageNode.style.color = "white";
    var value = VDMPad.valueNode.value;
    var req = new XMLHttpRequest();
    req.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            var resultJson = JSON.parse(this.responseText);
            resultJson.expression = VDMPad.expressionNode.getValue();
            resultJson.value = value;
            resultJson.testcases = VDMPad.testcases;
            VDMPad.loadJson(JSON.stringify(resultJson));
            VDMPad.messageNode.style.color = "black";
            VDMPad.disableMakeItATestcaseButton();
        }
    };
    var queryOptions = "?";
    if (VDMPad.vdmClassicEnabled) {
        queryOptions += "classic=&";
    }
    if (VDMPad.invExceptionsEnabled) {
        queryOptions += "exceptions=&";
    }
    if (!VDMPad.runtimeCheckingEnabled) {
        queryOptions += "ignoreRuntimeChecking=&";
    }
    if (VDMPad.visualEnabled) {
        queryOptions += "visual=&";
    }
    if (VDMPad.unittestEnabled) {
        queryOptions += "unittest=&";
    }
    req.open("POST", "/eval"+queryOptions.substring(0,queryOptions.length-1));
    req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    var query = [];
    query.push("source="+encodeURIComponent(VDMPad.sourceNode.getValue()));
    query.push("expression="+encodeURIComponent(""));
    query.push("value="+encodeURIComponent(value));
    query.push("message="+encodeURIComponent(VDMPad.messageNode.textElement || VDMPad.messageNode.textContent));
    query = query.join("&");
    req.send(query);
};

VDMPad.eval = function () {
    VDMPad.disableMakeItATestcaseButton();
    var protoTestcase = {};
    VDMPad.valueNode.style.color = "white";
    VDMPad.messageNode.style.color = "white";
    var req = new XMLHttpRequest();
    var start = VDMPad.expressionNode.getCursor("start");
    var end = VDMPad.expressionNode.getCursor("end");
    if (!VDMPad.expressionNode.somethingSelected()) {
        start.ch = 0;
        end.ch = VDMPad.expressionNode.getLine(end.line).length;
        VDMPad.expressionNode.setSelection(start, end);
    }
    var anchor = VDMPad.expressionNode.getCursor("anchor");
    var head = VDMPad.expressionNode.getCursor("head");
    req.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            var resultJson = JSON.parse(this.responseText);
            resultJson.expression = VDMPad.expressionNode.getValue();
            resultJson.testcases = VDMPad.testcases;
            VDMPad.loadJson(JSON.stringify(resultJson));
            VDMPad.expressionNode.setSelection(anchor, head);
            VDMPad.valueNode.style.color = "black";
            VDMPad.messageNode.style.color = "black";
            protoTestcase["value"] = resultJson.value;
            protoTestcase["poststates"] = {};
            for (var key in resultJson) {
                if (key.indexOf("`") >= 0) {
                    protoTestcase["poststates"][key] = resultJson[key];
                }
            }
            VDMPad.protoTestcase = protoTestcase;
            if (VDMPad.unittestEnabled) VDMPad.enableMakeItATestcaseButton();
            VDMPad.startTests();
        }
    };
    var queryOptions = "?";
    if (VDMPad.vdmClassicEnabled) {
        queryOptions += "classic=&";
    }
    if (VDMPad.invExceptionsEnabled) {
        queryOptions += "exceptions=&";
    }
    if (!VDMPad.runtimeCheckingEnabled) {
        queryOptions += "ignoreRuntimeChecking=&";
    }
    if (VDMPad.visualEnabled) {
        queryOptions += "visual=&";
    }
    if (VDMPad.unittestEnabled) {
        queryOptions += "unittest=&";
    }
    req.open("POST", "/eval"+queryOptions.substring(0,queryOptions.length-1));
    req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    var query = [];
    var expression = VDMPad.expressionNode.getSelection();
    if (!expression)
        expression = VDMPad.expressionNode.getValue();
    protoTestcase["source"] = VDMPad.sourceNode.getValue();
    protoTestcase["expression"] = expression;
    protoTestcase["prestates"] = {};
    query.push("source="+encodeURIComponent(VDMPad.sourceNode.getValue()));
    query.push("expression="+encodeURIComponent(expression));
    query.push("value="+encodeURIComponent(VDMPad.valueNode.value));
    query.push("message="+encodeURIComponent(VDMPad.messageNode.textElement || VDMPad.messageNode.textContent));
    var inputs = document.getElementsByTagName("textarea");
    for (var inputIndex = 0; inputIndex < inputs.length; inputIndex++) {
        var input = inputs[inputIndex];
        if (input.id && input.id.indexOf("`") >= 0) {
            query.push(input.id+"="+encodeURIComponent(input.value));
            protoTestcase["prestates"][input.id] = input.value;
        }
    }
    query = query.join("&");
    req.send(query);
};

VDMPad.loadJson = function(snapshotString) {
    var result;
    try {
        result = JSON.parse(snapshotString);
    } catch (e) {
    }
    if (!result)
        result = {source: "", expression: "", value: "", message: ""};
    if (!result.testcases) {
        result.testcases = [];
    }
    if (localStorage)
        localStorage.setItem("`lastSnapshot", JSON.stringify(result));
    VDMPad.testcases = result.testcases;
    VDMPad.sourceNode.setValue(result.source);
    VDMPad.currentSource = result.source;
    VDMPad.expressionNode.setValue(result.expression);
    VDMPad.valueNode.value = result.value;
    while (VDMPad.valueVisualNode.firstChild) VDMPad.valueVisualNode.removeChild(VDMPad.valueVisualNode.firstChild);
    if (VDMPad.visualEnabled) {
        var visualNode = document.createElement("div");
        VDMPad.valueVisualNode.appendChild(visualNode);
        VDMPad.vdm2html(result.value, visualNode);
    }
    VDMPad.messageNode.innerText = result.message;
    VDMPad.messageNode.textContent = result.message;
    var states = [];
    for (var key in result)
        if (key.indexOf("`") >= 0)
            states.push(key);
    states.sort();
    var lastModuleName = "";
    var moduleNode = null;
    while (VDMPad.stateNode.firstChild)
        VDMPad.stateNode.removeChild(VDMPad.stateNode.firstChild);
    for (var varIndex = 0; varIndex < states.length; varIndex++) {
        var fullname = states[varIndex];
        var backquoteIndex = fullname.indexOf("`");
        var moduleName = fullname.substring(0, backquoteIndex);
        var variableName = fullname.substring(backquoteIndex+1);
        if (moduleName != lastModuleName) {
            lastModuleName = moduleName;
            if (moduleNode != null) {
                VDMPad.stateNode.appendChild(moduleNode);
            }
            moduleNode = document.createElement("div");
            moduleNode.style.marginLeft = "0px";
            moduleNode.style.border =  "dotted 1px black";
            moduleNode.style.margin =  "10px 10px 0px 0px";
            moduleNode.innerText = moduleName;
            moduleNode.textContent = moduleName;
        }
        var variableNode = document.createElement("div");
        variableNode.style.marginLeft = "40px";
        variableNode.innerText = variableName;
        variableNode.textContent = variableName;
        moduleNode.appendChild(variableNode);
        var valueNode = document.createElement("textarea");
        valueNode.id = fullname;
        valueNode.setAttribute("name", fullname);
        valueNode.value = result[fullname];
        valueNode.style.cssText="resize: vertical";
        valueNode.setAttribute("cols", 60);
        valueNode.setAttribute("rows", result[fullname].length / 60 + 1);
        var valueDivNode = document.createElement("div");
        valueDivNode.style.cssText="float: right";
        valueDivNode.appendChild(valueNode);
        variableNode.appendChild(valueDivNode);
        valueDivNode = document.createElement("div");
        valueDivNode.style.cssText="clear: right";
        variableNode.appendChild(valueDivNode);
        if (VDMPad.visualEnabled) {
            var visualNode = document.createElement("div");
            variableNode.appendChild(visualNode);
            VDMPad.vdm2html(result[fullname], visualNode);
        }
    }
    if (moduleNode != null)
        VDMPad.stateNode.appendChild(moduleNode);
    VDMPad.startTests();
};

VDMPad.vdm2html = function(vdm, node) {
    var req = new XMLHttpRequest();
    req.onreadystatechange = function () {
         if (this.readyState == 4 && this.status == 200) {
             node.innerHTML = this.responseText;
             node.htmlContent = this.responseText;
         }
     };
    req.open("POST", "/vdm2html");
    req.send(vdm);
};

VDMPad.load = function (name) {
    VDMPad.unittestRunning = false;
    VDMPad.protoTestcase = null;
    VDMPad.testcases = [];
    VDMPad.loadJson(localStorage.getItem(name));
    if (name != "`lastSnapshot") {
        VDMPad.currentSpec = name;
        if (localStorage)
            localStorage.setItem("`currentSpec", name);
        VDMPad.updateFileItems();
    }
}

VDMPad.acceptDroppedFile = function (event) {
    if (event.dataTransfer && event.dataTransfer.files) {
        var reader = new FileReader();
        reader.onload = function(e) {
            VDMPad.loadJson(e.target.result);
        };
        reader.readAsText(event.dataTransfer.files[0], "utf-8");
    } else {
        alert("Your browser does not support file drag&drop.");
    }
    if (event.stopPropagation)
        event.stopPropagation();
    if (event.preventDefault)
        event.preventDefault();
    event.cancelBubble = true;
    return false;
}

VDMPad.saveAs= function (name, export_flag) {
    var req = new XMLHttpRequest();
    req.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            if (localStorage) {
                localStorage.setItem(name, this.responseText);
                localStorage.setItem("`lastSnapshot", this.responseText);
                localStorage.setItem("`currentSpec", name);
                var files = JSON.parse(localStorage.getItem("`files"));
                if (files.indexOf(name) < 0) {
                    files.push(name);
                    files.sort();
                    localStorage.setItem("`files", JSON.stringify(files));
                }
            }
            if (export_flag) {
                var blob = new Blob([this.responseText], {type: "application/json;charset=utf-8"});
                saveAs(blob, name+".vdmpad");
            }
            VDMPad.currentSpec = name;
            VDMPad.updateFileItems();
        }
    };
    req.open("POST", "/id");
    req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    var query = [];
    query.push("source="+encodeURIComponent(VDMPad.sourceNode.getValue()));
    query.push("expression="+encodeURIComponent(VDMPad.expressionNode.getValue()));
    query.push("value="+encodeURIComponent(VDMPad.valueNode.value));
    query.push("message="+encodeURIComponent(VDMPad.messageNode.textElement || VDMPad.messageNode.textContent || ""));
    var inputs = document.getElementsByTagName("textarea");
    for (var inputIndex = 0; inputIndex < inputs.length; inputIndex++) {
        var input = inputs[inputIndex];
        if (input.id && input.id.indexOf("`") >= 0) {
            query.push(input.id+"="+encodeURIComponent(input.value));
        }
    }
    query = query.join("&");
    req.send(query);
};

VDMPad.remove = function (name) {
    var files = VDMPad.files();
    var index = files.indexOf(name);
    if (index >= 0) {
        files.splice(index, 1);
        if (localStorage)
            localStorage.setItem("`files", JSON.stringify(files));
    }
    if (localStorage)
        localStorage.removeItem(name);
    VDMPad.updateFileItems();
};

VDMPad.loadFromLocalStorage = function () {
    if (localStorage) {
        VDMPad.runtimeCheckingEnabled = localStorage.getItem("Config`runtimeCheckingEnabled") != "false";
        VDMPad.invExceptionsEnabled = localStorage.getItem("Config`invExceptionsEnabled") == "true";
        VDMPad.unittestEnabled = localStorage.getItem("Config`unittestEnabled") == "true";
        VDMPad.visualEnabled = localStorage.getItem("Config`visualEnabled") == "true";
        if (localStorage.getItem("`lastSnapshot") == undefined) {
            var counter = {};
            counter["source"] = "module Counter\nexports all\ndefinitions\nstate counter of\n\tcount : nat\n\tinit s == s = mk_counter(0)\nend\noperations\n\tstep : () ==> nat\n\tstep() == (count := count + 1; return count);\nend Counter\n";
            counter["Counter`count"] = "1002";
            counter["expression"] = "Counter`step()";
            counter["value"] = "";
            counter["message"] = "";
            counter["testcases"] = [];
            localStorage.setItem("example:Counter", JSON.stringify(counter));
            localStorage.setItem("`files", JSON.stringify(["example:Counter"]));
            localStorage.setItem("`lastSnapshot", localStorage.getItem("lastSnapshot"));
            localStorage.removeItem("lastSnapshot");
        }
        VDMPad.load("`lastSnapshot");
        if (localStorage.getItem("`currentSpec") == undefined) {
            localStorage.setItem("`currentSpec", "");
        }          
        VDMPad.currentSpec = localStorage.getItem("`currentSpec");
    }
};

VDMPad.setupIdeNodes = function () {
    VDMPad.node = document.getElementById("all");
    VDMPad.mainNode = document.getElementById("main");
    var tmpSourceNode = document.getElementById("source");
    VDMPad.sourceNode = CodeMirror.fromTextArea(tmpSourceNode, {mode: "vdm", theme: "vdmpad", indentUnit: 4, tabSize: 4, lineWrapping: true, lineNumbers: true, matchBrackets: true, iOSselection: true});
    tmpSourceNode.parentNode.title = tmpSourceNode.title;
    VDMPad.sourceNode.setSize(null, 300);
	var keyArray = [{key:"("},
                {key:")"},
                {key:"{"},
                {key:"}"},
                {key:"`"},
                {key:"mk_"},
                {key:","},
                {key:":"},
                {key:"="},
                {key:"|->"}
                ];
    VDMPad.sourceNode.addKeyrow(keyArray, "/codemirror/addon/iOS/Tock.aiff");
    VDMPad.stateNode = document.getElementById("states");
    var tmpExpressionNode = document.getElementById("expression");
    VDMPad.expressionNode = CodeMirror.fromTextArea(tmpExpressionNode, {mode: "vdm", theme: "vdmpad", indentUnit: 4, tabSize: 4, lineWrapping: true, lineNumbers: false, matchBrackets: true, iOSselection: true, extraKeys: {"Ctrl-P": VDMPad.eval, "Cmd-P": VDMPad.eval}});
    tmpExpressionNode.parentNode.title = tmpExpressionNode.title;
    VDMPad.expressionNode.setSize(null, 100);
    keyArray = [{key:"("},
                {key:")"},
                {key:"{"},
                {key:"}"},
                {key:"`"},
                {key:"mk_"},
                {key:","},
                {key:":"},
                {key:"="},
                {key:"|->"}
                ];
    VDMPad.expressionNode.addKeyrow(keyArray, "/codemirror/addon/iOS/Tock.aiff");
    VDMPad.valueNode = document.getElementById("value");
    VDMPad.valueVisualNode = document.getElementById("valueVisual");
    VDMPad.messageNode = document.getElementById("message");
    VDMPad.unittestNode = document.getElementById("unittest");
    VDMPad.makeItATestcaseButtonNode = document.getElementById("make it a testcase");
};

' copyReplaceAll: String cr with: String crlf