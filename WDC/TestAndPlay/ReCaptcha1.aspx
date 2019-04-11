<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ReCaptcha1.aspx.cs" Inherits="Online.TestAndPlay.ReCaptcha1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">
        $(document).ready(function () {


            $("#form1").validate({
                
                submitHandler: function (form) {
                    alert(grecaptcha.getResponse());
                    if (grecaptcha.getResponse() != '') {
                        alert("submitting");
                        form.submit();
                    } else {
                        $("#dialog-text").attr('title', 'Captca');
                        $("#dialog-text").html("Please confirm you are not a robot to proceed");
                        $("#dialog").dialog();
                    }
                }

            });

      

            <% =Online.WDCFunctions.WDCFunctions.googleanalyticstracking(false)%>

        }); //document.ready


    </script>

     <script src='https://www.google.com/recaptcha/api.js'></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <%
        if (HttpContext.Current.Request.Url.AbsolutePath.ToLower().Substring(0, 8) == "/online/" || 1 == 1)
        {
    %>

    <!--CAPTCHA-->

    <div class="form-group">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8 g-recaptcha" data-sitekey="6Lfate4SAAAAACwvT4b-W86_cBOSm4LveQYO1HoA">
        </div>
    </div>

        <div id="dialog" title="">
        <p><span id="dialog-text"></span></p>
    </div>

    <%
        }
    %>

    <!-- SUBMIT -->

    <div class="form-group">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
            <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info" Text="Submit" />
        </div>
    </div>


    <asp:Literal ID="Literal1" runat="server"></asp:Literal>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
