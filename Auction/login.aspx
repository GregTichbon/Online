<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="Auction.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Auction log in</title>

    <link href="_Includes/css/main.css" rel="stylesheet" />
    <script type="text/javascript">
        $(document).ready(function () {
            $('#btn_login').click(function () {
                if ($("#formLogin").valid()) {
                    var arForm = [{ "name": "URL", "value": "<%=Request.Url.AbsoluteUri%>" }, { "name": "emailaddress", "value": $('#l_emailaddress').val() }, { "name": "passcode", "value": $('#l_passcode').val() }, { "name": "keepmeloggedin", "value": $('#l_keepmeloggedin').is(":checked") }];
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
                                if (result.d.user_ctr == $('#hf_highestbidder').val()) {
                                    //alert(result.d.user_ctr);
                                    //alert($('#hf_highestbidder').val());
                                    $('#highestbidder').html($('#highestbidder').html() + " <b>(YOU!)</b>"); 
                                }
                                /*
                                if ($('#l_keepmeloggedin:checked')) {
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
            <input type="email" name="l_emailaddress" id="l_emailaddress" class="form-control br2 pa2 input-reset ba bg-transparent measure b--silver w-100" required="required" placeholder="Email address" /></p>
        <p>
            <input type="password" name="l_passcode" id="l_passcode" class="form-control br2 pa2 input-reset ba bg-transparent measure b--silver w-100" required="required" placeholder="Password" /></p>
        <p>
            <input type="checkbox" class="xform-control" name="l_keepmeloggedin" id="l_keepmeloggedin" />
            Keep me logged in</p>
                    <input type="button" name="btn_login" id="btn_login" class="xform-control f6 grow no-underline br-pill ph3 pv2 dib white bg-blue pointer" value="Submit" />

        
    </form>
</body>
</html>
