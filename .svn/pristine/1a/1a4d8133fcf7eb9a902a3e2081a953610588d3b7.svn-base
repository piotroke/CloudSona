/* --------------------------------------------------------
 * @author: GMX - 1&1 Internet AG
 * @originator Speer, Christian
 * @maintainer Speer, Christian
 * AdIframe EIC for UIM/UID
 */

var com = com || {};
com.unitedinternet = com.unitedinternet || {};
com.unitedinternet.mailclassic = com.unitedinternet.mailclassic || {};
 
var mail = com.unitedinternet.mailclassic;

(function(ui) {
	var frameID = 0;
	
	ui.mailclassic.frames = {

		create : function(element, options) {
			if (!element) {
				throw new Error('Missing argument element');
			}
			if (!options) {
				throw new Error('Missing argument options');
			}
			var $frame = $('<iframe/>'),
				attributes = {
					height: options.height || 0,
					width: options.width || 0,
					scrolling: 'no'
				};
		
			if ($.browser.msie) {
				attributes['frameBorder'] = '0';
			}
			else {
				attributes['frameborder'] = 0;
			}
			$frame.attr(attributes);

			if (options.css) {
				$frame.css(options.css);
			}

			if (ui.eic) {
				$frame.attr('src', options.url + '#' + ui.eic.params({ id: frameID++, url: location.href }));
				ui.eic.frames = ui.eic.frames || [];
				ui.eic.frames.push($frame[0]);
			}
			else {
				$frame.attr('src', options.url);
			}
			
			$frame.appendTo(element);
		},
		
		run : function() {
			if (ui.eic) {
				ui.eic.commands = {
					resizeFrame : function(width_height) {
						if ( !!width_height && /^\d+,\d+$/.test( width_height ) ) {
							var params	= width_height.split(','),
								width	= parseInt(params[0], 10),
								height	= parseInt(params[1], 10);
						
							$(this).css({ width: width,  height: height});
						}
					},
					leadBanner: function(coregId) { 
						if (coregId) {
							window.location.href = mail.mcgibase+"g.fcgi/leadbanner?"+mail.optlink+"&coregId="+coregId;
						}
					},
					tandem: function(adParam) { 
						if (adParam) {
							mail.ad_sky  += "&"+adParam.replace(/_/g,"=");
							$("#adv-sky > iframe").attr("src", mail.ad_sky);
						}
					},
					jumpto: function(app) {
						if (app == "uid_limango") {
							var limango_service = top.nav.getServiceInfoByEmail("@limango.de");
							if ( !limango_service.hasCredentials ) {
								top.nav.sendRegisterService(limango_service.id);
							}
							else {
								window.open(mail.mcgibase+"g.fcgi/go?"+mail.optlink+"&to=limango&goTo="+limango_service.gotoParam);
							}
						}
						else if(app == "uid_freereader") {
							top.com.unitedinternet.mailclassic.navigator.activate('ereader');
						}
					}
				};
				ui.eic.listen();
			}
		}
	};
})(com.unitedinternet);

/* Quickfix for AD SKYBANNER Halfpage */
mail.ad_sky_width = 160;
if(typeof mail.ad_sky  != "undefined") {
	if($(window).width() >= 1100) {
		mail.ad_sky  += "&adsize=300x600";
		mail.ad_sky_width = 303;
	}
}
if(typeof mail.ad_top  != "undefined") { mail.frames.create('#adv', {url: mail.ad_top, height: 92, width: 778}); }
if(typeof mail.ad_sky  != "undefined") { mail.frames.create('#adv-sky', {url: mail.ad_sky, height: 600, width: mail.ad_sky_width}); }
mail.frames.run();