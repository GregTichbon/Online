<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="Auction.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Auction log in</title>

    <link href="_Includes/css/main.css" rel="stylesheet" />
    <script type="text/javascript">
        $(document).ready(function () {
            $('#btn_submit').click(function () {
                if ($("#formLogin").valid()) {
                    alert($('#r_keepmeloggedin').is(":checked"));
                    var arForm = [{ "name": "URL", "value": "<%=Request.Url.AbsoluteUri%>" }, { "name": "emailaddress", "value": $('#r_emailaddress').val() }, { "name": "passcode", "value": $('#r_passcode').val() }, { "name": "keepmeloggedin", "value": $('#r_keepmeloggedin').is(":checked") }];
                    var formData = JSON.stringify({ formVars: arForm });
                    $.ajax({
                        type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                        contentType: "application/json; charset=utf-8",
                        url: 'posts.asmx/Login', // the url where we want to POST
                        data: formData,
                        dataType: 'json', // what type of data do we expect back from the server
                        success: function (result) {
                            if (result.d.message == 'Valid') {
                                $('#hf_user_ctr').val(result.d.user_ctr);
                                $('#hf_fullname').val(result.d.fullname);
                                $("#fullname").html(result.d.fullname);
                                $('.displayloggedin').show();
                                $('.displaylogin').hide();
                                $('#dialog_login').dialog("close");
                                /*
                                if ($('#r_keepmeloggedin:checked')) {
                                    alert('make cookie');
                                    document.cookie = "Auction_user_ctr=" + result.d.user_ctr + "; expires=Thu, 18 Dec 2013 12:00:00 UTC";
                                    Cookies.set('Auction_user_ctr', result.d.user_ctr);
                                    Cookies.set('Auction_Fullname', result.d.fullname);
                                } else {

                                }
                                */
                            } else {
                                alert('Invalid email addresss / password combination');
                            }
                        },
                        error: function (xhr, status) {
                            alert("An error occurred: " + status);
                        }
                    });
                };
            });

            $("#formLogin").validate({
                onkeyup: false,
                onclick: false,
                onfocusout: false
            });

        });
    </script>

</head>
<body>
    <form id="formLogin" runat="server">

        <p>
            <input type="email" name="r_emailaddress" id="r_emailaddress" class="form-control" required="required" placeholder="Email address" /></p>
        <p>
            <input type="text" name="r_passcode" id="r_passcode" class="form-control" required="required" placeholder="Password" /></p>
        <p>
            <input type="checkbox" class="xform-control" name="r_keepmeloggedin" id="r_keepmeloggedin" />
            Keep me logged in</p>
                    <input type="button" name="btn_submit" id="btn_submit" class="xform-control" value="Submit" />

        
    </form>
</body>
</html>
