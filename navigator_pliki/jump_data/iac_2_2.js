/*
 * Inter Application Communication 
 * (c) 2009 1&1 Internet AG
 * 
 * Built: 2010-06-10 11:15 
 * Profile: gmx
 */
/* namespace $LastChangedRevision: 3564 $ */
var com=com||{};
com.unitedinternet=com.unitedinternet||{};
com.unitedinternet.portal=com.unitedinternet.portal||{};
com.unitedinternet.portal.iac=com.unitedinternet.portal.iac||{};
com.unitedinternet.portal.navigator=com.unitedinternet.portal.navigator||{};
/* configuration $LastChangedRevision: 3531 $ */
(function(){var a=com.unitedinternet.portal.iac;
a.configuration={flashtransport:{swfurl:"https://js.ui-portal.de/iac/swf/gmx/1.1/iac.swf"}};
}());
/* iaccore $LastChangedRevision: 3818 $ */
(function(){var d=com.unitedinternet.portal.iac;
function c(j,g,i,h){this.source=j;
this.destination=g;
this.data=i;
this.origin=h;
}c.prototype.toString=function(){return"[Message] source: "+this.source+" ("+this.origin+")"+", destination: "+this.destination+", data: "+this.data;
};
function b(i,h,g,j){this.code=i;
this.message=h;
this.details=g;
this.cause=j;
}b.prototype.name="IACError";
b.prototype.toString=function(){return"["+this.name+"|"+this.code+"] "+this.message;
};
function a(i,j,g,h){this.__name=i;
this.__context=j;
this._responder=g||null;
this._protocolHandler=h||null;
this._onMessage=null;
this.status="uninitialized";
}a.isAvailable=function(){var g=typeof window.postMessage;
return g==="function"||g==="object";
};
a.prototype._changeStatus=function(g){this.status=g;
if(this._responder&&this._responder.onStatusChange){this._responder.onStatusChange(g);
}};
a.prototype._sendError=function(g){if(this._responder&&this._responder.onError){this._responder.onError(g);
}};
a.prototype.initialize=function(){var g=this;
this._onMessage=function(h){g._handleMessageReceived(h);
};
if(window.addEventListener){window.addEventListener("message",this._onMessage,false);
}else{if(window.attachEvent){window.attachEvent("onmessage",this._onMessage);
}}this._changeStatus("ready");
};
a.prototype.sendMessage=function(g,h){var k,j;
if(!this._protocolHandler){throw new b("TR_SND_NO_PH","no protocol handler specified");
}k=this._protocolHandler.resolveDestination(g);
if(!k){throw new b("TR_SND_DESTINATION_UNKNOWN","protocol handler could not resolve destination",{destination:g});
}else{if(k.error){throw new b("TR_SND_PH_BAD_DESTINATION","error resolving destination",{destination:g,error:k.error});
}}j="IAC1|"+this.__context+"|"+g+"|"+this.__name+"|"+h;
try{k.targetWindow.postMessage(j,k.targetOrigin);
}catch(i){throw new b("TR_SND_POSTMESSAGE_EXCEPTION","exception occured calling postMessage",{destination:g,data:h},i);
}};
a.prototype._handleMessageReceived=function(h){var j,k,i,m,g,n,o,p;
if(!h.data||h.data.substr(0,5)!=="IAC1|"){return;
}j=h.data.split("|",4);
if(j.length!==4){this._sendError(new b("TR_RCV_MALFORMED_MESSAGE","message incomplete",{data:h.data}));
return;
}i=j[1];
m=j[2];
g=j[3];
n=h.origin;
o=h.source;
k=h.data.substr(4+i.length+m.length+g.length+4);
if(this._responder){p=new c(g,m,k,n);
try{this._responder.onMessage(p);
}catch(l){this._sendError(new b("TR_RCV_RESPONDER_FAILED","exception occured calling responder.onMessage",{message:p},l));
}}if(h.stopPropagation){h.stopPropagation();
}h.cancelBubble=true;
};
function f(i,j,g,h,k){this.__name=i;
this.__context=j;
this.__parentId=k;
this._localConnection=null;
this._responder=g||null;
this._protocolHandler=h||null;
this.status="uninitialized";
}f.isAvailable=function(){return true;
};
f.prototype._changeStatus=function(g){this.status=g;
if(this._responder&&this._responder.onStatusChange){this._responder.onStatusChange(g);
}};
f.prototype._sendError=function(g){if(this._responder&&this._responder.onError){this._responder.onError(g);
}};
f.prototype.initialize=function(){var g,h;
g=this;
window.handleLocalConnectionInit=function(){g._handleLocalConnectionInit();
};
window.handleLocalConnectionMessage=function(){g._handleLocalConnectionMessage.apply(g,arguments);
};
h=function(){g._handleUnload();
};
if(window.addEventListener){window.addEventListener("unload",h,false);
}else{if(window.attachEvent){window.attachEvent("onunload",h);
}}this._changeStatus("loading");
this._insertSWF();
};
f.prototype._insertSWF=function(){var i,h,g,j;
i=d.configuration.flashtransport.swfurl;
h='<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"'+'    id="localConnection" width="1" height="1"'+'    codebase="//fpdownload.macromedia.com/get/flashplayer/current/swflash.cab">'+'<param name="movie" value="'+i+'" />'+'<param name="bgcolor" value="#000000" />'+'<param name="allowScriptAccess" value="always" />'+'<embed id="localConnectionEmbed"'+'    src="'+i+'" bgcolor="#000000"'+'    width="1" height="1" play="true" loop="false"'+'    allowScriptAccess="always"'+'    type="application/x-shockwave-flash"'+'    pluginspage="https://www.adobe.com/go/getflashplayer">'+"</embed>"+"</object>";
if(this.__parentId){g=document.getElementById(this.__parentId);
if(g){g.innerHTML=h;
}else{throw new b("TR_FLASH_INSERT_FAILED","cannot insert swf into DOM: parent element not found",{parentId:this.__parentId});
}}else{j=document.createElement("div");
j.className="iacFlashContainer";
j.style.position="absolute";
j.style.top="0px";
j.style.left="0px";
j.style.width="1px";
j.style.height="1px";
j.style.overflow="hidden";
document.body.appendChild(j);
j.innerHTML=h;
}};
f.prototype._handleLocalConnectionInit=function(){var h,g;
h=document.getElementById("localConnectionEmbed")||document.getElementById("localConnection");
if(!h){this._sendError(new b("TR_FLASH_SWF_NOT_FOUND","cannot locate swf, a mystery..."));
}g=h.connect(this.__name,this.__context);
if(!g){this._sendError(new b("TR_FLASH_CONNECT_REFUSED","swf initialized, but no result on connect"));
}else{if(g.error){this._sendError(new b("TR_FLASH_CONNECT_REFUSED","error connecting swf",{error:g.error}));
}}this._localConnection=h;
this._changeStatus("ready");
};
f.prototype._handleUnload=function(){if(this._localConnection&&this._localConnection.disconnect){try{this._localConnection.disconnect();
}catch(g){}}};
f.prototype.sendMessage=function(h,i){var k,g;
if(!this._protocolHandler){throw new b("TR_SND_NO_PH","no protocol handler specified");
}k=this._protocolHandler.resolveDestination(h);
if(!k){throw new b("TR_SND_DESTINATION_UNKNOWN","protocol handler could not resolve destination",{destination:h});
}else{if(k.error){throw new b("TR_SND_PH_BAD_DESTINATION","error resolving destination",{destination:h,error:k.error});
}}try{g=this._localConnection.sendMessage(k.targetName,h,i,k.targetOrigin);
}catch(j){throw new b("TR_SND_FLASH_EXCEPTION","exception occured calling sendMessage",{destination:h,data:i},j);
}if(g&&g.error){throw new b("TR_SND_FLASH_FAILURE","error returned from sendMessage",{destination:h,data:i,error:g.error});
}};
f.prototype._handleLocalConnectionMessage=function(i,l,g,k){var h;
if(this._responder){h=new c(g,l,i,k);
try{this._responder.onMessage(h);
}catch(j){this._sendError(new b("TR_RCV_RESPONDER_FAILED","exception occured calling responder.onMessage",{message:h},j));
}}};
function e(h,g){this._transport=h;
this._rpcClient=g;
}e.prototype._prepareMessage=function(n,k){var g,m,l,h;
g=k&&k[0];
if(!g){throw new b("RPC_MISSING_PARAMETER","missing methodname",{prefix:n,methodName:g});
}if(g.charAt(0)==="_"){throw new b("RPC_NOT_ALLOWED","call to methods starting with '_' is not allowed",{methodName:g});
}for(l=0,h=k.length;
l<h;
l++){k[l]=(" "+k[l]).replace(/,/g,",,");
}m=n+":"+Array.prototype.join.call(k,",");
return m;
};
e.prototype.prepareRemoteCallData=function(g){var h,i;
h=Array.prototype.slice.call(arguments,0);
i=this._prepareMessage("RPC",h);
return i;
};
e.prototype.prepareRemoteExecuteData=function(g){var h,i;
h=Array.prototype.slice.call(arguments,0);
i=this._prepareMessage("RPE",h);
return i;
};
e.prototype._sendData=function(g,h){if(!g||!h){throw new b("RPC_MISSING_PARAMETER","missing destination or data",{destination:g,data:h});
}try{this._transport.sendMessage(g,h);
}catch(i){throw new b("RPC_SEND_FAILED","exception occured calling transport.sendMessage",{destination:g,data:h},i);
}};
e.prototype.sendRemoteCall=function(g,h){var i,j;
i=Array.prototype.slice.call(arguments,1);
j=this._prepareMessage("RPC",i);
this._sendData(g,j);
};
e.prototype.sendRemoteExecute=function(g,h){var i,j;
i=Array.prototype.slice.call(arguments,1);
j=this._prepareMessage("RPE",i);
this._sendData(g,j);
};
e.prototype.delegateRemoteCall=function(q){var h,m,o,k,g,p,l;
h=q.data;
m=h.substr(0,4);
if(m!=="RPC:"&&m!=="RPE:"){throw new b("RPC_WRONG_MSG","message can not be handled (no rpc?)",{message:q});
}o=h.substr(4).match(/([^,]+(,,)*)+/g);
for(k=0,g=o.length;
k<g;
k++){o[k]=o[k].substr(1).replace(/,,/g,",");
}p=o[0];
o=o.slice(1);
l=this._rpcClient[p];
if(p.charAt(0)==="_"){throw new b("RPC_NOT_ALLOWED","not allowed to call methods starting with '_'",{message:q,methodName:p});
}else{if(!l){throw new b("RPC_METHOD_NOT_FOUND","method not found, nothing to call",{message:q,methodName:p});
}else{if(typeof l!=="function"){throw new b("RPC_METHOD_NOT_CALLABLE","method not found, nothing to call",{message:q,methodName:p});
}else{try{l.apply(this._rpcClient,o);
}catch(n){throw new b("RPC_CLIENT_FAILURE","exception occured calling method",{message:q,methodName:p,args:o});
}}}}};
d.Message=c;
d.IACError=b;
d.PostMessageTransport=a;
d.FlashTransport=f;
d.RPCWrapper=e;
}());
/* iacbridge $LastChangedRevision: 3809 $ */
(function(){var b=com.unitedinternet.portal.iac;
function a(c,d){this._name=c;
this._address="comlib";
this._bridge=d;
this._token=null;
this._status=null;
}a.prototype.subscribe=function(){var c=Array.prototype.concat.apply([this._address,"subscribe",this._name,this._token],arguments);
if(this._status==="ready"){this._bridge.remoteExecute.apply(this._bridge,c);
}else{throw new b.IACError("COMLIB_NOT_REGISTERED","register first with iac comlib interface");
}};
a.prototype.unsubscribe=function(){var c=Array.prototype.concat.apply([this._address,"unsubscribe",this._name,this._token],arguments);
if(this._status==="ready"){this._bridge.remoteExecute.apply(this._bridge,c);
}else{throw new b.IACError("COMLIB_NOT_REGISTERED","register first with iac comlib interface");
}};
a.prototype.execute=function(){var c=Array.prototype.shift.apply(arguments),d=Array.prototype.concat.apply([this._address,c,this._name,this._token],arguments);
if(this._status==="ready"){if(c!=="subscribe"&&c!=="unsubscribe"){this._bridge.remoteExecute.apply(this._bridge,d);
}}else{throw new b.IACError("COMLIB_NOT_REGISTERED","register first with iac comlib interface");
}};
a.prototype.register=function(){var c=[this._address,"addToken",this._name,this._token];
this._bridge.remoteExecute.apply(this._bridge,c);
this._status="ready";
};
a.prototype.unregister=function(){if(this._status==="ready"){var c=[this._address,"removeToken",this._name,this._token];
this._bridge.remoteExecute.apply(this._bridge,c);
this._status=null;
}else{throw new b.IACError("COMLIB_NOT_REGISTERED","register first with iac comlib interface");
}};
a.prototype.isReady=function(){return this._status==="ready";
};
a.prototype.initialize=function(){this._token=new Date().getTime()*Math.floor(Math.random()*100000);
};
b.IACComlib=a;
}());
/* iacbridge $LastChangedRevision: 3825 $ */
(function(){var e=com.unitedinternet.portal.navigator,d=com.unitedinternet.portal.iac;
function c(){this.navigatorWindow=top;
this.navigatorOrigin="*";
}c.prototype.resolveDestination=function(f){return{"targetWindow":this.navigatorWindow,"targetOrigin":this.navigatorOrigin};
};
c.prototype.verifySource=function(h,f,g){return{status:"OK",message:"unverified so far, security will be enhanced"};
};
function b(){this.navigatorName="navigator";
this.navigatorOrigin="*";
}b.prototype.resolveDestination=function(f){return{targetName:this.navigatorName,targetOrigin:this.navigatorOrigin};
};
b.prototype.verifySource=function(g,f,h){return{status:"OK",message:"unverified so far, security will be enhanced"};
};
function a(g,i,h,f){this.name=g;
this.context=i;
this.rpcClient=h;
this.flashParentId=f;
this._transport=null;
this._protocolHandler=null;
this._rpcWrapper=null;
this._hubName="navigator";
this.status="uninitialized";
this.connected=false;
this.comlib=new d.IACComlib(g,this);
}a.isAvailable=function(){return d.PostMessageTransport.isAvailable()||d.FlashTransport.isAvailable();
};
a.prototype.onError=function(f){if(this.rpcClient&&this.rpcClient._onError){this.rpcClient._onError(f);
}};
a.prototype._changeStatus=function(f){this.status=f;
if(this.rpcClient&&this.rpcClient._onStatusChange){this.rpcClient._onStatusChange(f);
}else{if(this.rpcClient&&this.rpcClient._onStatusChanged){this.rpcClient._onStatusChanged(f);
}}};
a.prototype.onStatusChange=function(f){this._changeStatus(f);
if(f==="ready"){this.connect();
}};
a.prototype.onMessage=function(f){var g,h;
g=f.data;
h=g.substr(0,4);
switch(h){case"HUB:":if(g==="HUB:__connected__"){this.connected=true;
this._changeStatus("connected");
}else{if(g==="HUB:__disconnected__"){this.connected=false;
this._changeStatus("disconnected");
}else{if(g==="HUB:__ready__"){if(!this.connected){this._changeStatus("ready");
this.connect();
}}}}break;
case"RPC:":this._rpcWrapper.delegateRemoteCall(f);
break;
case"RPE:":this._rpcWrapper.delegateRemoteCall(f);
break;
default:if(this.rpcClient&&this.rpcClient._onUnhandledMessage){this.rpcClient._onUnhandledMessage(f);
}}};
a.prototype.initialize=function(){if(d.PostMessageTransport.isAvailable()){this._protocolHandler=new c();
this._transport=new d.PostMessageTransport(this.name,this.context,this,this._protocolHandler);
}else{if(d.FlashTransport.isAvailable()){this._protocolHandler=new b();
this._transport=new d.FlashTransport(this.name,this.context,this,this._protocolHandler,this.flashParentId);
}else{throw new d.IACError("BRIDGE_INIT_FAILED","no iac transport available!");
}}this._rpcWrapper=new d.RPCWrapper(this._transport,this.rpcClient);
this._transport.initialize();
this.comlib.initialize();
};
a.prototype.remoteCall=function(){if(!this.connected){throw new d.IACError("BRIDGE_NOT_CONNECTED","not connected to navigator-hub");
}return this._rpcWrapper.sendRemoteCall.apply(this._rpcWrapper,arguments);
};
a.prototype.remoteExecute=function(){if(!this.connected){throw new d.IACError("BRIDGE_NOT_CONNECTED","not connected to navigator-hub");
}return this._rpcWrapper.sendRemoteExecute.apply(this._rpcWrapper,arguments);
};
a.prototype.connect=function(){this._transport.sendMessage(this._hubName,"HUB:__connect__");
};
a.prototype.disconnect=function(){this._transport.sendMessage(this._hubName,"HUB:__disconnect__");
};
e.IACBridge=a;
}());
/* initialize $LastChangedRevision: 3832 $ */
if(window.mailclient&&mailclient.util&&mailclient.util.PackageUtil){mailclient.util.PackageUtil.reportScriptLoaded("//js.ui-portal.de/ih/gmx/iac/v2/iac_2_2.js");
}else{if(window.qxloader&&qxloader.reportSuccessfulLoad){qxloader.reportSuccessfulLoad("iac_2_2.js");
}}