<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="Online.Entity.login" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <!-- Style Sheets -->
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />
    <link href="<%: ResolveUrl("~/Scripts/colorbox/colorbox.css")%>" rel="stylesheet" />
    <link href="<%: ResolveUrl("~/Scripts/bootstrap-datetimepicker/bootstrap-datetimepicker.min.css")%>" rel="stylesheet" />


    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Scripts/jquery-2.2.0.min.js")%>"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>

    <script type="text/javascript">
        // Change JQueryUI plugin names to fix name collision with Bootstrap.
        $.widget.bridge('uitooltip', $.ui.tooltip);
        $.widget.bridge('uibutton', $.ui.button);
    </script>

    <script src="<%: ResolveUrl("~/Scripts/bootstrap.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Scripts/colorbox/jquery.colorbox-min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Scripts/jquery.validate.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Scripts/additional-methods.js")%>"></script>
    <!--additional-methods.min.js-->

    <script src="//cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.js"></script>
    <script src="<%: ResolveUrl("~/Scripts/bootstrap-datetimepicker/bootstrap-datetimepicker.min.js")%>"></script>

    <script type="text/javascript">
        $(document).ready(function () {

            $("#pagehelp").colorbox({ href: "LoginHelp.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });

                      

        }); //document.ready
    </script>


</head>
<body>
    <form id="form1" runat="server">
        <div>

           
            <a id="pagehelp">
                <img id="helpicon" src="http://wdc.whanganui.govt.nz/online/images/question.png" title="Click on me for specific help on this page." /></a>

            <h1>Log in
            </h1>

            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_usernameemailaddress">Email address or User name</label>
                <div class="col-sm-8">
                    <input id="tb_usernameemailaddress" name="tb_usernameemailaddress" type="text" class="form-control" required="required" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_password">Password</label>
                <div class="col-sm-8">
                    <input id="tb_password" name="tb_password" type="password" class="form-control" required="required" />
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-4">
                </div>
                <div class="col-sm-8">
                    <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info" Text="Submit" />
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-4">
                </div>
                <div class="col-sm-8">
                    <%
                        string url = Request.Url.Query;
                        if (url == "")
                        {
                            url = "?create=true";
                        }
                        else
                        {
                            url = url + "&create=true";
                        }
                    %>
                    <img src="../Images/questionsmall.png" title="Register: If you haven't already done so, please click on the 'Register' link. Log in assistance: If you have previously registered but are having problems logging in please click on 'Log in assistance'." />
                    <a href="entity.aspx<%=url %>">Register</a> | <a href="loginassistance.aspx<%=url %>">Log in assistance</a>
                </div>
            </div>


        </div>
    </form>
</body>
</html>


