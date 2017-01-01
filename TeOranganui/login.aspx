<%@ Page Title="" Language="C#" MasterPageFile="~/TeOranganui.Master" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="TeOranganui.login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $(document).uitooltip({
                position: {
                    my: "right center",
                    at: "left center"
                }
            });

            $("#form1").validate();

            $("#btn_submit").click(function () {
                if ($("#form1").valid()) {
                    var arForm = $('#tb_login_name, #tb_password').serializeArray();
                    var formData = JSON.stringify({ formVars: arForm });
                    $.ajax({
                        type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                        async: false,
                        contentType: "application/json; charset=utf-8",
                        url: 'functions/posts.asmx/login', // the url where we want to POST
                        data: formData,
                        dataType: 'json', // what type of data do we expect back from the server
                        success: function (result) {
                            item = $.parseJSON(result.d);
                            if (item.user_id != '') {
                                window.location = "default.aspx";
                                //alert('Hi ' + item.user_name);
                            } else {
                                alert('Invalid Username / Password combination')
                            }
                        }
                    });
                }
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_login_name">User name</label><div class="col-sm-8">
            <input id="tb_login_name" name="tb_login_name" type="text" class="form-control" required />
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_password">Password</label><div class="col-sm-8">
            <input id="tb_password" name="tb_password" type="password" class="form-control" required />
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
            <input id="btn_submit" type="button" value="Submit" class="btn btn-info" />

        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
