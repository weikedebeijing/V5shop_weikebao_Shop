﻿<%@ Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
    void Page_Load(Object Sender, EventArgs e)
    {
        CheckBrowserCaps();
    }

    void CheckBrowserCaps()
    {
        String labelText = "";
        string ua = Request.ServerVariables["HTTP_USER_AGENT"];
        labelText = ua;
        //if (((System.Web.Configuration.HttpCapabilitiesBase)myBrowserCaps).Browser.ToUpper().IndexOf("IE") >= 0)
        //{
        //    labelText = "Browser is Internet Explorer.";
        //}
        //else
        //{
        //    labelText = "Browser is not Internet Explorer.";
        //}

        Label1.Text = labelText;
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Browser Capabilities Sample</title>
</head>
<body>
    <form runat="server" id="form1">
    <div>
        Browser Capabilities:
        <p />
        <asp:Label ID="Label1" runat="server" />
    </div>
    </form>
</body>
</html>