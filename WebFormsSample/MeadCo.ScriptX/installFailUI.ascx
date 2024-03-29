﻿<%@ Control Language="C#" AutoEventWireup="true" %>

<script runat="server">
    public string LoadingElementID { get; set; }
    public string SuccessElementID { get; set; }
    public string OnSuccess { get; set; }
</script>

<div id="MeadCo_ScriptX_installFailure" style="display:none">
    <p>It looks like the install/upgrade has not started yet or has failed.</p>
    <% if ( Request.Browser.MajorVersion < 9)
        {
            if (Request.Browser.MajorVersion < 8)
            {
    %>
    <p><b>Has the Infobar appeared?</b></p>
    <p>If you are using Internet Explorer 6 or later on Windows XP SP2 or later then the Explorer Information bar may appear while trying to install ScriptX, it looks like this:</p>
    <p style="padding: 4px"><img id="infobarimg" runat="server" src="~/Content/MeadCo.ScriptX/images/infobar.png"></p>
    <p>If the bar has appeared, follow the instructions: click on the bar and then select <i>Install ActiveX Control...</i></p>
    <p><b>Are you an administrator?</b></p>
    <p>ScriptX is code that requires you have administrator rights on your machine in order to install it successfully.</p>
    <p>If you are not an administrator, please contact your administrator and ask them to install ScriptX for you.</p>
    <% }
            else
            { %>
    <p><b>Has the Infobar appeared?</b></p>
    <p>If you are using Internet Explorer 8 or later on Windows XP SP2 or later then the Explorer Information bar may appear while trying to install ScriptX, it looks like this:</p>
    <p style="padding: 4px"><img id="infobar8img" runat="server" src="~/Content/MeadCo.ScriptX/images/infobar8.png"></p>
    <p>If the bar has appeared, follow the instructions: click on the bar and then select <i>Install This Add-on for All Users on This Computer...</i></p>
    <p><b>Are you an administrator?</b></p>
    <p>ScriptX is code that requires you have administrator rights on your machine in order to install it successfully.</p>
    <p>If you are not an administrator, please contact your administrator and ask them to install ScriptX for you.</p>
    <% }
        } 
        else
        { %>
    <p><b>Has Internet Explorer notified you?</b></p>
    <p>If you are using Internet Explorer 9 or later then Internet Explorer will notify you of the attempt to install ScriptX and ask your permission, the notification bar looks like this:</p>
    <p style="padding: 4px"><img id="notificationbarimg" runat="server" src="~/Content/MeadCo.ScriptX/images/notificationbar.png"></p>
    <p>If the bar has appeared, click <i>Install</i> to install ScriptX.</p>
    <p><b>Are you an administrator?</b></p>
    <p>ScriptX is code that requires you have administrator rights on your machine in order to install it successfully.</p>
    <p>If you are not an administrator, please contact your administrator and ask them to install ScriptX for you.</p>
    <% } %>
</div>
 
<div id="MeadCo_ScriptX_ActiveXFiltered" style="display:none">
    <h2>It appears ScriptX is unavailable.</h2>
    <p>Have you enabled ActiveX Filtering on IE 9 or later? If you have, click the blue icon in the address bar and turn off ActiveX Filtering, it looks like this:</p>
    <p style="padding: 4px"><img id="activexfilteringimg" runat="server" src="~/Content/MeadCo.ScriptX/images/activexfiltering.png" /></p>
    <p>If there is no blue icon, look in the Safety menu of the Gear menu for &quot;ActiveX Filtering&quot; and make sure it isnt checked.</p>
    <p>After turning filtering off, please try again:  <button class="btn btn-primary" onclick="MeadCoInstall.Retry(); return false;">Retry &raquo;</button></p>

</div>

<script type="text/javascript">
    //<![CDATA[
    var MeadCoInstall = {
        setDisplayStyle : function(id,value) {
            var e = document.getElementById(id);
            if ( e != null )
                e.style.display = value;
            },

        hide : function(id) {
            MeadCoInstall.setDisplayStyle(id, "none");
            },

        show : function(id) {
            MeadCoInstall.setDisplayStyle(id, "block");
            },

        callBack : function(fn) {
                fn();
            },

        Retry : function () {
            location.reload(false);
        },
        
        CheckScriptXInstall: function() {
            MeadCoInstall.hide("<%: LoadingElementID %>"); // jquery: $('#wait').hide();
            MeadCoInstall.hide('MeadCo_ScriptX_ActiveXFiltered');
            MeadCoInstall.hide('MeadCo_ScriptX_installFailure');
            if ( !MeadCo.ScriptX.Init() ) {
                // IE9 or later Filtering enabled?
                if (typeof window.external.msActiveXFilteringEnabled != "undefined" && window.external.msActiveXFilteringEnabled() == true) {
                    MeadCoInstall.show('MeadCo_ScriptX_ActiveXFiltered');
                }
                else {
                    MeadCoInstall.show('MeadCo_ScriptX_installFailure');
                }
                MeadCoInstall.hide("<%: SuccessElementID %>");
            }
            else {
                <% if ( !string.IsNullOrWhiteSpace(OnSuccess) ) { %>              
                MeadCoInstall.callBack(<%: OnSuccess %>);
                <% } %>
                MeadCoInstall.show("<%: SuccessElementID %>");
            }
        }
    }

    if (window.addEventListener) {
        window.addEventListener('load', MeadCoInstall.CheckScriptXInstall, false);
    }
    else {
        window.attachEvent("onload", MeadCoInstall.CheckScriptXInstall);
    }
//]]>
</script>

<div style="display: none;">
    <MeadCoScriptX:ClientPrinting runat="server" ClientValidate="none"></MeadCoScriptX:ClientPrinting>
</div>
