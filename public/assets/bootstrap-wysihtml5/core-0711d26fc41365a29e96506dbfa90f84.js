!function(e,t){"use strict";var n={"font-styles":function(e,t){var n=t&&t.size?" btn-"+t.size:"";return"<li class='dropdown'><a class='btn dropdown-toggle"+n+"' data-toggle='dropdown' href='#'>"+"<i class='icon-font'></i>&nbsp;<span class='current-font'>"+e.font_styles.normal+"</span>&nbsp;<b class='caret'></b>"+"</a>"+"<ul class='dropdown-menu'>"+"<li><a data-wysihtml5-command='formatBlock' data-wysihtml5-command-value='div'>"+e.font_styles.normal+"</a></li>"+"<li><a data-wysihtml5-command='formatBlock' data-wysihtml5-command-value='h1'>"+e.font_styles.h1+"</a></li>"+"<li><a data-wysihtml5-command='formatBlock' data-wysihtml5-command-value='h2'>"+e.font_styles.h2+"</a></li>"+"<li><a data-wysihtml5-command='formatBlock' data-wysihtml5-command-value='h3'>"+e.font_styles.h3+"</a></li>"+"</ul>"+"</li>"},emphasis:function(e,t){var n=t&&t.size?" btn-"+t.size:"";return"<li><div class='btn-group'><a class='btn"+n+"' data-wysihtml5-command='bold' title='CTRL+B'>"+e.emphasis.bold+"</a>"+"<a class='btn"+n+"' data-wysihtml5-command='italic' title='CTRL+I'>"+e.emphasis.italic+"</a>"+"<a class='btn"+n+"' data-wysihtml5-command='underline' title='CTRL+U'>"+e.emphasis.underline+"</a>"+"</div>"+"</li>"},lists:function(e,t){var n=t&&t.size?" btn-"+t.size:"";return"<li><div class='btn-group'><a class='btn"+n+"' data-wysihtml5-command='insertUnorderedList' title='"+e.lists.unordered+"'><i class='icon-list'></i></a>"+"<a class='btn"+n+"' data-wysihtml5-command='insertOrderedList' title='"+e.lists.ordered+"'><i class='icon-th-list'></i></a>"+"<a class='btn"+n+"' data-wysihtml5-command='Outdent' title='"+e.lists.outdent+"'><i class='icon-indent-right'></i></a>"+"<a class='btn"+n+"' data-wysihtml5-command='Indent' title='"+e.lists.indent+"'><i class='icon-indent-left'></i></a>"+"</div>"+"</li>"},link:function(e,t){var n=t&&t.size?" btn-"+t.size:"";return"<li><div class='bootstrap-wysihtml5-insert-link-modal modal hide fade'><div class='modal-header'><a class='close' data-dismiss='modal'>&times;</a><h3>"+e.link.insert+"</h3>"+"</div>"+"<div class='modal-body'>"+"<input value='http://' class='bootstrap-wysihtml5-insert-link-url input-xlarge'>"+"</div>"+"<div class='modal-footer'>"+"<a href='#' class='btn' data-dismiss='modal'>"+e.link.cancel+"</a>"+"<a href='#' class='btn btn-primary' data-dismiss='modal'>"+e.link.insert+"</a>"+"</div>"+"</div>"+"<a class='btn"+n+"' data-wysihtml5-command='createLink' title='"+e.link.insert+"'><i class='icon-share'></i></a>"+"</li>"},image:function(e,t){var n=t&&t.size?" btn-"+t.size:"";return"<li><div class='bootstrap-wysihtml5-insert-image-modal modal hide fade'><div class='modal-header'><a class='close' data-dismiss='modal'>&times;</a><h3>"+e.image.insert+"</h3>"+"</div>"+"<div class='modal-body'>"+"<input value='http://' class='bootstrap-wysihtml5-insert-image-url input-xlarge'>"+"</div>"+"<div class='modal-footer'>"+"<a href='#' class='btn' data-dismiss='modal'>"+e.image.cancel+"</a>"+"<a href='#' class='btn btn-primary' data-dismiss='modal'>"+e.image.insert+"</a>"+"</div>"+"</div>"+"<a class='btn"+n+"' data-wysihtml5-command='insertImage' title='"+e.image.insert+"'><i class='icon-picture'></i></a>"+"</li>"},html:function(e,t){var n=t&&t.size?" btn-"+t.size:"";return"<li><div class='btn-group'><a class='btn"+n+"' data-wysihtml5-action='change_view' title='"+e.html.edit+"'><i class='icon-pencil'></i></a>"+"</div>"+"</li>"},color:function(e,t){var n=t&&t.size?" btn-"+t.size:"";return"<li class='dropdown'><a class='btn dropdown-toggle"+n+"' data-toggle='dropdown' href='#'>"+"<span class='current-color'>"+e.colours.black+"</span>&nbsp;<b class='caret'></b>"+"</a>"+"<ul class='dropdown-menu'>"+"<li><div class='wysihtml5-colors' data-wysihtml5-command-value='black'></div><a class='wysihtml5-colors-title' data-wysihtml5-command='foreColor' data-wysihtml5-command-value='black'>"+e.colours.black+"</a></li>"+"<li><div class='wysihtml5-colors' data-wysihtml5-command-value='silver'></div><a class='wysihtml5-colors-title' data-wysihtml5-command='foreColor' data-wysihtml5-command-value='silver'>"+e.colours.silver+"</a></li>"+"<li><div class='wysihtml5-colors' data-wysihtml5-command-value='gray'></div><a class='wysihtml5-colors-title' data-wysihtml5-command='foreColor' data-wysihtml5-command-value='gray'>"+e.colours.gray+"</a></li>"+"<li><div class='wysihtml5-colors' data-wysihtml5-command-value='maroon'></div><a class='wysihtml5-colors-title' data-wysihtml5-command='foreColor' data-wysihtml5-command-value='maroon'>"+e.colours.maroon+"</a></li>"+"<li><div class='wysihtml5-colors' data-wysihtml5-command-value='red'></div><a class='wysihtml5-colors-title' data-wysihtml5-command='foreColor' data-wysihtml5-command-value='red'>"+e.colours.red+"</a></li>"+"<li><div class='wysihtml5-colors' data-wysihtml5-command-value='purple'></div><a class='wysihtml5-colors-title' data-wysihtml5-command='foreColor' data-wysihtml5-command-value='purple'>"+e.colours.purple+"</a></li>"+"<li><div class='wysihtml5-colors' data-wysihtml5-command-value='green'></div><a class='wysihtml5-colors-title' data-wysihtml5-command='foreColor' data-wysihtml5-command-value='green'>"+e.colours.green+"</a></li>"+"<li><div class='wysihtml5-colors' data-wysihtml5-command-value='olive'></div><a class='wysihtml5-colors-title' data-wysihtml5-command='foreColor' data-wysihtml5-command-value='olive'>"+e.colours.olive+"</a></li>"+"<li><div class='wysihtml5-colors' data-wysihtml5-command-value='navy'></div><a class='wysihtml5-colors-title' data-wysihtml5-command='foreColor' data-wysihtml5-command-value='navy'>"+e.colours.navy+"</a></li>"+"<li><div class='wysihtml5-colors' data-wysihtml5-command-value='blue'></div><a class='wysihtml5-colors-title' data-wysihtml5-command='foreColor' data-wysihtml5-command-value='blue'>"+e.colours.blue+"</a></li>"+"<li><div class='wysihtml5-colors' data-wysihtml5-command-value='orange'></div><a class='wysihtml5-colors-title' data-wysihtml5-command='foreColor' data-wysihtml5-command-value='orange'>"+e.colours.orange+"</a></li>"+"</ul>"+"</li>"}},r=function(e,t,r){return n[e](t,r)},i=function(t,r){this.el=t;var i=r||o;for(var s in i.customTemplates)n[s]=i.customTemplates[s];this.toolbar=this.createToolbar(t,i),this.editor=this.createEditor(r),window.editor=this.editor,e("iframe.wysihtml5-sandbox").each(function(t,n){e(n.contentWindow).off("focus.wysihtml5").on({"focus.wysihtml5":function(){e("li.dropdown").removeClass("open")}})})};i.prototype={constructor:i,createEditor:function(e){e=e||{},e.toolbar=this.toolbar[0];var n=new t.Editor(this.el[0],e);if(e&&e.events)for(var r in e.events)n.on(r,e.events[r]);return n},createToolbar:function(t,n){var i=this,s=e("<ul/>",{"class":"wysihtml5-toolbar",style:"display:none"}),a=n.locale||o.locale||"en";for(var f in o){var l=!1;n[f]!==undefined?n[f]===!0&&(l=!0):l=o[f],l===!0&&(s.append(r(f,u[a],n)),f==="html"&&this.initHtml(s),f==="link"&&this.initInsertLink(s),f==="image"&&this.initInsertImage(s))}if(n.toolbar)for(f in n.toolbar)s.append(n.toolbar[f]);return s.find("a[data-wysihtml5-command='formatBlock']").click(function(t){var n=t.target||t.srcElement,r=e(n);i.toolbar.find(".current-font").text(r.html())}),s.find("a[data-wysihtml5-command='foreColor']").click(function(t){var n=t.target||t.srcElement,r=e(n);i.toolbar.find(".current-color").text(r.html())}),this.el.before(s),s},initHtml:function(e){var t="a[data-wysihtml5-action='change_view']";e.find(t).click(function(n){e.find("a.btn").not(t).toggleClass("disabled")})},initInsertImage:function(t){var n=this,r=t.find(".bootstrap-wysihtml5-insert-image-modal"),i=r.find(".bootstrap-wysihtml5-insert-image-url"),s=r.find("a.btn-primary"),o=i.val(),u,a=function(){var e=i.val();i.val(o),n.editor.currentView.element.focus(),u&&(n.editor.composer.selection.setBookmark(u),u=null),n.editor.composer.commands.exec("insertImage",e)};i.keypress(function(e){e.which==13&&(a(),r.modal("hide"))}),s.click(a),r.on("shown",function(){i.focus()}),r.on("hide",function(){n.editor.currentView.element.focus()}),t.find("a[data-wysihtml5-command=insertImage]").click(function(){var t=e(this).hasClass("wysihtml5-command-active");return t?!0:(n.editor.currentView.element.focus(!1),u=n.editor.composer.selection.getBookmark(),r.modal("show"),r.on("click.dismiss.modal",'[data-dismiss="modal"]',function(e){e.stopPropagation()}),!1)})},initInsertLink:function(t){var n=this,r=t.find(".bootstrap-wysihtml5-insert-link-modal"),i=r.find(".bootstrap-wysihtml5-insert-link-url"),s=r.find("a.btn-primary"),o=i.val(),u,a=function(){var e=i.val();i.val(o),n.editor.currentView.element.focus(),u&&(n.editor.composer.selection.setBookmark(u),u=null),n.editor.composer.commands.exec("createLink",{href:e,target:"_blank",rel:"nofollow"})},f=!1;i.keypress(function(e){e.which==13&&(a(),r.modal("hide"))}),s.click(a),r.on("shown",function(){i.focus()}),r.on("hide",function(){n.editor.currentView.element.focus()}),t.find("a[data-wysihtml5-command=createLink]").click(function(){var t=e(this).hasClass("wysihtml5-command-active");return t?!0:(n.editor.currentView.element.focus(!1),u=n.editor.composer.selection.getBookmark(),r.appendTo("body").modal("show"),r.on("click.dismiss.modal",'[data-dismiss="modal"]',function(e){e.stopPropagation()}),!1)})}};var s={resetDefaults:function(){e.fn.wysihtml5.defaultOptions=e.extend(!0,{},e.fn.wysihtml5.defaultOptionsCache)},bypassDefaults:function(t){return this.each(function(){var n=e(this);n.data("wysihtml5",new i(n,t))})},shallowExtend:function(t){var n=e.extend({},e.fn.wysihtml5.defaultOptions,t||{}),r=this;return s.bypassDefaults.apply(r,[n])},deepExtend:function(t){var n=e.extend(!0,{},e.fn.wysihtml5.defaultOptions,t||{}),r=this;return s.bypassDefaults.apply(r,[n])},init:function(e){var t=this;return s.shallowExtend.apply(t,[e])}};e.fn.wysihtml5=function(t){if(s[t])return s[t].apply(this,Array.prototype.slice.call(arguments,1));if(typeof t=="object"||!t)return s.init.apply(this,arguments);e.error("Method "+t+" does not exist on jQuery.wysihtml5")},e.fn.wysihtml5.Constructor=i;var o=e.fn.wysihtml5.defaultOptions={"font-styles":!0,color:!1,emphasis:!0,lists:!0,html:!1,link:!0,image:!0,events:{},parserRules:{classes:{"wysiwyg-color-silver":1,"wysiwyg-color-gray":1,"wysiwyg-color-white":1,"wysiwyg-color-maroon":1,"wysiwyg-color-red":1,"wysiwyg-color-purple":1,"wysiwyg-color-fuchsia":1,"wysiwyg-color-green":1,"wysiwyg-color-lime":1,"wysiwyg-color-olive":1,"wysiwyg-color-yellow":1,"wysiwyg-color-navy":1,"wysiwyg-color-blue":1,"wysiwyg-color-teal":1,"wysiwyg-color-aqua":1,"wysiwyg-color-orange":1},tags:{b:{},i:{},br:{},ol:{},ul:{},li:{},h1:{},h2:{},h3:{},blockquote:{},u:1,img:{check_attributes:{width:"numbers",alt:"alt",src:"url",height:"numbers"}},a:{set_attributes:{target:"_blank",rel:"nofollow"},check_attributes:{href:"url"}},span:1,div:1}},stylesheets:["/assets/bootstrap-wysihtml5/wysiwyg-color.css"],locale:"en"};typeof e.fn.wysihtml5.defaultOptionsCache=="undefined"&&(e.fn.wysihtml5.defaultOptionsCache=e.extend(!0,{},e.fn.wysihtml5.defaultOptions));var u=e.fn.wysihtml5.locale={en:{font_styles:{normal:"Normal text",h1:"Heading 1",h2:"Heading 2",h3:"Heading 3"},emphasis:{bold:"Bold",italic:"Italic",underline:"Underline"},lists:{unordered:"Unordered list",ordered:"Ordered list",outdent:"Outdent",indent:"Indent"},link:{insert:"Insert link",cancel:"Cancel"},image:{insert:"Insert image",cancel:"Cancel"},html:{edit:"Edit HTML"},colours:{black:"Black",silver:"Silver",gray:"Grey",maroon:"Maroon",red:"Red",purple:"Purple",green:"Green",olive:"Olive",navy:"Navy",blue:"Blue",orange:"Orange"}}}}(window.jQuery,window.wysihtml5);