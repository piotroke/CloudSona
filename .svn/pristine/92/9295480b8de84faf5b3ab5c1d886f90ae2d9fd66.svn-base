com = com || {};
com.unitedinternet = com.unitedinternet || {};
com.unitedinternet.mailclassic = com.unitedinternet.mailclassic || {}; 

(function($, window, undefined){ // module begin

var navInterface, iacBridge, utility, bridge, messenger,
mail = com.unitedinternet.mailclassic,
nx = com.unitedinternet.portal.navigator,
timeStamp = new Date().getTime();


// IAC helper
function iacBridgeAvailable() {
	if (!iacBridge) {
		iacBridge = mail && mail.navigator && mail.navigator.iacBridge;
	}
	if (!iacBridge){
		// TODO: log something, but not this.logText()
	}
	return !!iacBridge; 
}

/**
 * Utility wrapper
 */
utility = {
	decodeAmp: function(somestring) {
		return somestring.replace(/&amp;/g, "&");
	}
};

/**
 * IacBridge wrapper
 */
bridge = {
	openChat: function(user) {
		if (iacBridgeAvailable()) {
			iacBridge.remoteCall('messenger', 'startSimpleChat', user);
		}
	},

	tutorialGoTo: function(target) {
		if (iacBridgeAvailable()) {
			iacBridge.remoteCall('tutorial', 'goTo', target);
		}
	},

	editContact: function(personId) {
		if (iacBridgeAvailable()) {
			iacBridge.remoteCall('addressbook', 'editContact', personId);
		}
	},

	editVcard: function() {
		if (iacBridgeAvailable()) {
			iacBridge.remoteCall('addressbook', 'editAccountOwner', 'mail');
		}
	},

	addAddress: function(mailaddy) {
		if (iacBridgeAvailable()) {
			iacBridge.remoteCall('addressbook', 'addContacts', mailaddy, 'mail');
		}
	},

	mcSmsGoTo: function() {
		if (iacBridgeAvailable()) {
			iacBridge.remoteCall('riamail', 'bankDetailsDenoted');
		}
	},

	openThinkFree: function(app, url, fileName) {
		if (iacBridgeAvailable()) {
			iacBridge.remoteCall(app, 'setDocumentOpen', 'mail', url, fileName);
		}
	},

	sdShowOpenDialog: function(state, mode) {
		if (iacBridgeAvailable()) {
			mail.smartdriveState = state;
			mail.smartdriveMode = mode;
			iacBridge.remoteCall('smartdrivedialog', 'showAttachDialog', 'mail', mode, '/', '', null, null, state);
		}
	}
};

/**
 * RPC Client
 */
function MailRPCClient(){}

MailRPCClient.prototype._onError = function(error){
	this.logText("ERROR", error);
};

MailRPCClient.prototype._onStatusChange = function(status){
	this.logText("STATUS", status);
};

MailRPCClient.prototype.navigatorEvent = function(name){
	this.logText("[mail] NavigatorEvent: "+name);
};

MailRPCClient.prototype.logText = function(from, message){
	var targetIFrame = document.getElementById("iframe_mail"),
	targetWindow = targetIFrame.contentWindow || targetIFrame;
	targetWindow.logText.call(targetWindow, from, message);
};

MailRPCClient.prototype.newMail = function(to, subject) {
	var url = window.iframe_mail.document.location.href,
	changeSite = true;
	if (url.indexOf("/mail/new") != -1) {
	changeSite = confirm("Neue E-Mail schreiben\nSie haben bereits eine E-Mail in Bearbeitung. Falls Sie den Vorgang fortsetzen gehen alle Aenderungen verloren und koennen nicht wieder hergestellt werden!\n Wollen Sie den Vorgang dennoch fortsetzen und eine neue E-Mail schreiben?");
}
if (changeSite) {
	$("#iframe_mail").attr("src", mail.mcgibase+"g.fcgi/mail/new?to="+to+"&subject="+subject+"&sid="+mail.sid);
	}
};

MailRPCClient.prototype.newSMS = function(to) {
	var url = window.iframe_mail.document.location.href,
	changeSite = true;
	urlpart = "/sms";
if (url.indexOf("/sms/send") != -1) {
	changeSite = confirm("Neue SMS schreiben\nSie haben bereits eine SMS in Bearbeitung. Falls Sie den Vorgang fortsetzen gehen alle Aenderungen verloren und koennen nicht wieder hergestellt werden!\n Wollen Sie den Vorgang dennoch fortsetzen und eine neue SMS schreiben?");
	urlpart = "/sms";
}
if (changeSite) {
	$("#iframe_mail").attr("src", mail.mcgibase+"g.fcgi"+urlpart+"?number="+encodeURIComponent(to)+"&sid="+mail.sid);
	}
};

MailRPCClient.prototype.newFax = function(to) {
	var url = window.iframe_mail.document.location.href,
	changeSite = true,
	urlpart = "/fax";
if (url.indexOf("/fax/send") != -1) {
	changeSite = confirm("Neues Fax schreiben\nSie haben bereits ein Fax in Bearbeitung. Falls Sie den Vorgang fortsetzen gehen alle Aenderungen verloren und koennen nicht wieder hergestellt werden!\n Wollen Sie den Vorgang dennoch fortsetzen und ein neues Fax schreiben?");
	urlpart = "/fax/send";
}
if (changeSite) {
	$("#iframe_mail").attr("src", mail.mcgibase+"g.fcgi"+urlpart+"?to_fax="+encodeURIComponent(to)+"&tariffCheck=faxsend&sid="+mail.sid);
	}
};

MailRPCClient.prototype.checkDomain = function(domain, tld, mc) {
	var urlpart = "/products/maildomain/landing";
	$("#iframe_mail").attr("src", mail.mcgibase+"g.fcgi"+urlpart+"?domain="+encodeURIComponent(domain)+"&tld="+encodeURIComponent(tld)+"&mc="+encodeURIComponent(mc)+"&buttonSubmit=1&sid="+mail.sid);
};

MailRPCClient.prototype.smsAlarm = function(emails) {
	var urlpart = "/config/sms/notification/settings/short";
	$("#iframe_mail").attr("src", mail.mcgibase+"g.fcgi"+urlpart+"?emails="+encodeURIComponent(emails)+"&sid="+mail.sid);
};

MailRPCClient.prototype.internalJump = function(url) {
	var delimiter = (url.indexOf("?") == -1) ? "?" : "&";
	$("#iframe_mail").attr("src", url+delimiter+mail.optlink);
};

MailRPCClient.prototype.getInternalJumpUrl = function(windowId, url) {
	var delimiter = (url.indexOf("?") == -1) ? "?" : "&",
	url_complete = url+delimiter+"sid="+mail.sid;
	iacBridge.remoteCall('riamail', 'setInternalJumpUrl', windowId, url_complete);
};

MailRPCClient.prototype.getClassicUrl = function(target) {
	var url = "", url_complete,
	targets = {
		fax : "g.fcgi/fax/v3c?",
		invitations : "g.fcgi/ccc/invitations/present?"
	};
	// richtige URL zum Ziel raussuchen
	if(!!targets[target] && typeof targets[target] === 'string') {
		url = targets[target];
	}
	url_complete = mail.mcgibase+url+"sid="+mail.sid;
	iacBridge.remoteCall('riamail', 'setClassicUrl', url_complete, target);
};

MailRPCClient.prototype.goTo = function(target, urlparams) {
	
	var url = "",
	targets = {
			support : "ng.fcgi/helpform?site=start&",
			addspace : "g.fcgi/tariff/upgrade/mailboxsize?tariffCheck=mailboxsize&from=riamail&",
			addspaceSD : "g.fcgi/tariff/upgrade/mailboxsize?tariffCheck=mailboxsize&from=mediacenter&",
			smartdrive : "g.fcgi/tariff/upgrade/smartdrive?tariffCheck=smartdrive&linktype=mkt&from=mediacenter&",
			organizer : "g.fcgi/organizer?tariffCheck=pim&from=riamail&",
			mediacenter: "g.fcgi/mediacenter?",
			mms: "g.fcgi/mms?",
			dsltelefonie: "g.fcgi/config/phone/numbers?",
			dsltelefonieInfo: "g.fcgi/products/access?",
			filterrules: "ng.fcgi/cffilter?",
			internet: "g.fcgi/config/access?",
			sicherheit: "g.fcgi/products/security/landing?",
			sicherheitTools: "g.fcgi/gmxtools/nis?",
			sicherheitPremium: "g.fcgi/entertainment/nis?",
			homebanking: "g.fcgi/homebanking?",
			foto: "g.fcgi/photo?",
			maildomain: "g.fcgi/maildomain/overview?",
			maildomainInfo: "g.fcgi/products/maildomain/landing?",
			mobile: "g.fcgi/products/mobile/landing?",
			imap: "g.fcgi/imap?",
			attbig_up: "g.fcgi/tariff/upgrade/attbig?tariffCheck=attbig&from=riamail&",
			profilevel_up: "g.fcgi/tariff/upgrade/profilevel?tariffCheck=profilevel&from=riamail&",
			movieflat_up: "g.fcgi/tariff/upgrade/maxdome?tariffCheck=maxdome&from=riamail&",
			advertising_up: "g.fcgi/tariff/upgrade/advertising?tariffCheck=advertising&from=riamail&",
			imap_up: "g.fcgi/tariff/upgrade/imap?tariffCheck=imap&from=riamail&",
			bestprice: "g.fcgi/config/mailing/bestprice?",
			mailinfoservice: "g.fcgi/config/mailing/infoservice?",
			movieflat: "g.fcgi/entertainment/maxdome?",
			ums: "g.fcgi/config/ums/032?",
			wishnumber_up: "g.fcgi/tariff/upgrade/ums?tariffCheck=ums&from=riamail&",
			pushmail: "g.fcgi/pushmail/feature?",
			profifax: "g.fcgi/gmxtools/profifax?",
			magazin: "g.fcgi/config/mailing/magazin?",
			premiumnews: "g.fcgi/config/mailing/premium?",
			gmxpremium: "g.fcgi/entertainment?",
			gmxtools: "g.fcgi/gmxtools?",
			uploadmanager: "g.fcgi/gmxtools/uploadmanager?",
			smsalarm: "g.fcgi/config/sms/notification?",
			virenschutz: "g.fcgi/config/virus?tariffCheck=virus&from=riamail&",
			spamschutz: "g.fcgi/config/spam?",
			smartsurfer: "g.fcgi/products/smartsurfer/overview?",
			netphone: "g.fcgi/gmxtools/netphone?",
			persdaten: "g.fcgi/config/address?",
			bank: "g.fcgi/config/payment?",
			altemail: "g.fcgi/config/password/recover?",
			passwort: "g.fcgi/config/password/change?",
			aliasnew: "g.fcgi/config/alias/gmx/new/wishname?",
			alias: "g.fcgi/config/alias?",
			topmail_up: "g.fcgi/products/mail/topmail/landing?",
			upgradefax: "g.fcgi/tariff/upgrade/freefax?tariffCheck=freefax&linktype=mkt&from=riamail&",
			smsoptionen: "g.fcgi/config/sms?",
			smspro_up: "g.fcgi/tariff/upgrade/freesmspro?tariffCheck=freesmspro&linktype=mkt&from=riamail&",
			smstop_up: "g.fcgi/tariff/upgrade/freesmstop?tariffCheck=freesmstop&linktype=mkt&from=riamail&",
			tariff_change_1: "g.fcgi/tariff/change?destinationTariff=1&from=riamail&",
			tariff_change: "g.fcgi/tariff/change?from=riamail&",
			design_up: "g.fcgi/tariff/upgrade/design?tariffCheck=design&from=riamail&",
			account: "g.fcgi/account?",
			office_up: "g.fcgi/tariff/upgrade/office?tariffCheck=office&from=onlineoffice&",
			birthday: "g.fcgi/config/mailing/birthday?",
			tariff_change_4: "g.fcgi/tariff/change?destinationTariff=4&",
			tariff_change_2: "g.fcgi/tariff/change?destinationTariff=2&",
			mediacenter_xl: "g.fcgi/products/mediacenter/landing?"
	};
	// richtige URL zum Ziel raussuchen
	if(!!targets[target] && typeof targets[target] === 'string') {
		url = targets[target];
	}
	
	if (url.length === 0) {
		url = "g.fcgi/startpage?";
	}
	
	urlparams = typeof urlparams != "undefined"?"&"+urlparams:"";
	
	$("#iframe_mail").attr("src", mail.mcgibase+url+mail.optlink+urlparams);
};

/* Smartdrive functions */
MailRPCClient.prototype.onSDWidgetInitialized = function() {
	if (iacBridgeAvailable()) {
		iacBridge.remoteCall('smartdrivedialog', 'showAttachDialog', 'mail', mail.smartdriveMode, '/', '', null, null, mail.smartdriveState);
	}
}
/* Smartdrive functions */
MailRPCClient.prototype.sendAsEmailAttachment = function(fileJSON, recipients, state) {
	
	if (!state || !state.length || state == 'undefined') {
		state = "normal";
	}
	
	$.ajax({
		type: "POST",
		url: mail.mcgibase+"g.fcgi/mail/update/attachment/add/smartdrive?"+mail.optlink,
		contentType: "application/json",
		dataType: "text",
		data: "fileJSON="+encodeURIComponent(fileJSON),
		success: function(req) {
			if(state == "normal") {
				var url = window.iframe_mail.document.location.href;
				if (url.indexOf("mail/update") != -1 || url.indexOf("mail/reply") != -1 || url.indexOf("mail/edit") != -1 || url.indexOf("mail/forward") != -1 || url.indexOf("mail/new") != -1) {
					/* add attachment to mail and submit form */
					var uid = window.frames['iframe_mail'].getUID();
					
					$.ajax({
						type: "POST",
						url: mail.mcgibase+"g.fcgi/mail/update/attachment/add?"+mail.optlink,
						contentType: "application/json",
						dataType: "text",
						data: "uid="+uid,
						success: function(req) {
							if(!recipients || !recipients.length || recipients != 'null') {
								var to = window.frames['iframe_mail'].document.getElementById('to');
								if (to.value.length != 0) {
									to.value += ','+recipients;
								} else {
									to.value = recipients;
								}
							}
							
							window.frames['iframe_mail'].submitMailForm(req);
						},
						error: function(req) {
							/* fail! */
						}
					});
				}
				else {
					/* create a new mail */
					$("#iframe_mail").attr("src", mail.mcgibase+"g.fcgi/mail/new?to="+encodeURIComponent(recipients)+"&addAttachment=true&sid="+mail.sid);
				}
			}
			else {
				/*add inline attachment*/
				var uid = window.frames['iframe_mail'].getUID();
				$.ajax({
					type: "GET",
					url: mail.mcgibase+"g.fcgi/mail/update/attachment/inline/add?"+mail.optlink,
					dataType: "text",
					data: "uid="+uid,
					success: function(req) {
						var cids = req.split(",");
						$.each(cids, function(index, value) { 
							window.frames['iframe_mail'].insertImage(value, '');
						});
					},
					error: function(req) {
						/* fail! */
					}
				});
			}
		},
		error: function(req) {
			/* fail! */
		}
	});

};

/**
 * Initialize function
 */
mail.initialize = function(options) {
	var appData, statsData, mailRPCClient;
	
	// Append web analytics payload
	if (nx.config.statistics.analytics) {
		nx.config.statistics.analytics.payload = {
			country: options.country, 
			lang: options.lang, 
			n_user_level: options.userLevel
		};
	}

	// Generate web analytics config
	function generateAppConfig(appName) {
		return {
			'show': new nx.WaPixel('event', appName, 'show').toString(),
			'switch': new nx.WaPixel('event', appName, 'switch').toString(),
			'click': {
				'uim': new nx.UimPixel('navigator', appName, 'navigator').toString()
			}
		};
	}
	// Generate navigator config
	function generateNavConfig() {
		// ns = window.ns;
		return {
			'startup': new nx.WaPixel('event', 'navigator', 'startup').toString(),
			'sortstop': new nx.WaPixel('event', 'navigator', 'sortstop').toString()
		};
	}
	//Generate stats config
	function generateStatsConfig(statsName, targetName, sectionName, clickName, clickPage) {
		if (clickName && clickPage) {
			return {
				'click': {
					'wa': new nx.WaPixel('click', statsName, sectionName, targetName).toString(),
					'uim': new nx.UimPixel(clickName, targetName, clickPage).toString()
				},
				'switch': new nx.WaPixel('event', statsName, 'switch', targetName).toString()
			};
		}
		else {
			return {
				'click': {
					'wa': new nx.WaPixel('click', statsName, sectionName, targetName).toString()
				},
				'switch': new nx.WaPixel('event', statsName, 'switch', targetName).toString()
			};
		}
	}

// Anwendungskonfiguration - pro Anwendung:
// * id = Name der Anwendung hier im HTML *UND* gleichzeitig der Name für die IAC-Kommunikation
// * url = Mit diesem Link wird das iFrame beim Start einer Anwendung in den DOM geschrieben.
// * properties = Eigneschaften einer Anwendung zur Laufzeit, z.B. runState, comState
// * events = Liste von Events welche die Anwendung bekommen möchte, oder true/false.
// * statistics = Mapping von Events (start, show) auf WebAnalytics Pixel urls.
// * help = Bietet die Anwendung eine eigene, kontextabhängige Hilfe an?
// * settings = Bietet die Anwendung eigene, kontextabhängige Settings an?
// * styles = Liste von optionalen styles welche der navigator für die Anwendung setzt.
// * current = Optionales Flag der bei initialisierung laufenden Anwendung (mail).
	appData = {
		mail : {
			id : "mail",
			url : options.mail,
			properties : {},
			events : [ 'show', 'hide' ],
			widgets: ['smartdrivedialog'],
			statistics : generateAppConfig('mail')
		},

		riamail : {
			id : "riamail",
			url : options.riamail,
			properties : {},
			statistics : generateAppConfig('riamail'),
			help: {type: "popup", defaultUrl: "http://hilfe.webmail.gmx.de/",windowParams: {height: 655, width: 800, scrollbars: 'yes'}},
			settings: {type: 'iac'}
		},
		
		messenger : {
			id : "messenger",
			url : options.messenger,
			autoStart: {url: options.autoStartUrl, delay: 8000},
			events : [ 'show', 'hide' ],
			statistics : generateAppConfig('messenger')
		},

		smartdrive : {
			id : "smartdrive",
			url : options.smartdrive,
			statistics : generateAppConfig('smartdrive')
		},
		
		smartdrivedialog: {
			id : 'smartdrivedialog',
			url : options.smartdrivedialog,
			styles: { frame: {top: '10px', left: '135px', width: '700px', height: '450px', 'z-index': 10000}},
			statistics : generateAppConfig('smartdrivedialog')
		},

		fotomanager : {
			id : "fotomanager",
			url : options.fotomanager,
			statistics : generateAppConfig('fotomanager')
		},

		officewrite : {
			id : "officewrite",
			url : options.officewrite,
			statistics : generateAppConfig('officewrite')
		},
		officeshow : {
			id : "officeshow",
			url : options.officeshow,
			statistics : generateAppConfig('officeshow')
		},
		officecalc : {
			id : "officecalc",
			url : options.officecalc,
			statistics : generateAppConfig('officecalc')
		},

		demail : {
			id : "demail",
			url : options.demail,
			statistics : generateAppConfig('demail')
		},
		
		addressbook : {
			id : "addressbook",
			url : options.addressbook,
			statistics : generateAppConfig('addressbook')
		},

		rssreader : {
			id : "rssreader",
			url : options.rssreader,
			statistics : generateAppConfig('rssreader')
		},

		ereader : {
			id : "ereader",
			url : options.ereader,
			statistics : generateAppConfig('ereader')
		},

		bookmarks : {
			id : "bookmarks",
			url : options.bookmarks,
			statistics : generateAppConfig('bookmarks')
		},

		notes : {
			id : "notes",
			url : options.notes,
			statistics : generateAppConfig('notes')
		},

		loginzentrale : {
			id : "loginzentrale",
			url : options.loginzentrale,
			loginUrl : options.loginUrl,
			statistics : generateAppConfig('loginzentrale')
		},

		bild: {
			id : 'bild',
			url : options.bild,
			statistics : generateAppConfig('bild')
		},

		welt: {
			id : 'welt',
			url : options.welt,
			statistics : generateAppConfig('welt')
		},

		ebay : {
			id : "ebay",
			url : options.ebay,
			statistics : generateAppConfig('ebay')
		},
		
		brandstogo : {
			id : "brandstogo",
			url : options.brandstogo,
			statistics : generateAppConfig('brandstogo')
		},
		
		mafo : {
			id : "mafo",
			url : options.mafo,
			statistics : generateAppConfig('mafo')
		},
		
		tutorial : {
			id : "tutorial",
			url : options.tutorial,
			statistics : generateAppConfig('tutorial')
		},

		search : {
			id : "search",
			url : "javascript:'search loading...'",
			searchUrl : options.searchUrl,
			preventFocus : true,
			statistics : generateAppConfig('search')
		},
		umsapp : {
			id : "umsapp",
			url : options.umsapp,
			statistics : generateAppConfig('umsapp')
		}
	};

// Set running mailer
if (options.mailClient && options.mailClient == "mail") {
	appData.mail.properties.runState = "running";
	appData.mail.current = true;
}
else {
	appData.riamail.properties.startTime = timeStamp;
	appData.riamail.url = (appData.riamail.url||"").replace(/\$\{starttime\}/g, timeStamp);
	appData.riamail.current = true;
	appData.mail.properties.runState = "prepared";
	appData.riamail.properties.runState = "running";
	$("#iframe_riamail").attr('src', appData.riamail.url);
}

// Additional statistics mapping
statsData = {
	navigator:	generateNavConfig(),
	help:		generateStatsConfig('bar', 'help', 'activate', 'navigator', 'navigator'),
	settings:	generateStatsConfig('bar', 'settings', 'activate', 'navigator', 'navigator'),
	search:		generateStatsConfig('bar', 'search', 'activate', 'navigator', 'navigator'),
	facebook:	generateStatsConfig('bar', 'facebook', 'login', 'zumshop', 'zumshop'),
	hybridmail:	generateStatsConfig('bar', 'hybridmail', 'login', 'zumshop', 'zumshop'),
	portal:		generateStatsConfig('bar', 'portal', 'to_home', 'vertrieb', 'portal'),
	portal_topmail:		generateStatsConfig('pulldown', 'topmail', 'to_home', 'vertrieb', 'portal'),
	portal_security:	generateStatsConfig('pulldown', 'pcsicherheit', 'to_home', 'vertrieb', 'portal'),
	portal_dsl:			generateStatsConfig('pulldown', 'dsl', 'to_home', 'vertrieb', 'portal'),
	portal_domain: 		generateStatsConfig('pulldown', 'domain', 'to_home', 'vertrieb', 'portal'),
	portal_magazines:	generateStatsConfig('pulldown', 'magazine', 'to_home', 'vertrieb', 'portal'),
	portal_shopping:	generateStatsConfig('pulldown', 'shopping', 'to_home', 'vertrieb', 'portal'),
	portal_bestprice:	generateStatsConfig('pulldown', 'bestprice', 'to_home', 'vertrieb', 'portal'),
	portal_auktion:		generateStatsConfig('pulldown', 'auktion', 'to_home', 'vertrieb', 'portal')
};

// Mail RPC client
mailRPCClient = new MailRPCClient();

// Navigator bootstrap
navInterface = nx.bootstrap({
	appData: appData, 
	statsData: statsData,
	iacToken: options.gid,
	cryptParam: options.crypt,
	hmacParam: options.hmac,
	sessionId: options.sid,
	mailClient: options.mailClient,
	rpcName: "mail",
	rpcClient: mailRPCClient
});

// Interface export
mail.navigator = navInterface;
// Downwards compatible
window.nav = navInterface;
window.loginExtPartner = navInterface.loginExtPartner;

// Get iacBridge
$(document).ready(function() {
	iacBridgeAvailable();
});
};

// Utility export
mail.utility = utility;

// Bridge export
mail.bridge = bridge;
// Downwards compatible
document.openChat = function() {
	bridge.openChat.apply(bridge, arguments);
};
document.tutorialGoTo = function() {
	bridge.tutorialGoTo.apply(bridge, arguments);
};
document.editContact = function() {
	bridge.editContact.apply(bridge, arguments);
};
document.editVcard = function() {
	bridge.editVcard.apply(bridge, arguments);
};
document.addAddress = function() {
	bridge.addAddress.apply(bridge, arguments);
};
document.mcSmsGoTo = function() {
	bridge.mcSmsGoTo.apply(bridge, arguments);
};

})(jQuery, window); // module end
