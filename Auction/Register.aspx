<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Auction.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#save').click(function () {
                
                if ($("#formReg").valid()) {
                    var arForm = [{ "name": "URL", "value": "<%=Request.Url.AbsoluteUri%>" }, { "name": "user_ctr", "value": 0 }, { "name": "fullname", "value": $('#r_fullname').val() }, { "name": "emailaddress", "value": $('#r_emailaddress').val() }, { "name": "passcode", "value": $('#r_passcode').val() }, { "name": "mobilenumber", "value": $('#r_mobilenumber').val() }, { "name": "textnotifications", "value": $('#r_textnotifications').val() }, { "name": "contactpermission", "value": $('#r_contactpermission').val() }];
                    var formData = JSON.stringify({ formVars: arForm });
                    $.ajax({
                        type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                        contentType: "application/json; charset=utf-8",
                        url: 'posts.asmx/Update_User', // the url where we want to POST
                        data: formData,
                        dataType: 'json', // what type of data do we expect back from the server
                        success: function (result) {
                            details = $.parseJSON(result.d);
                            $('#hf_user_ctr').val(details.message);
                            $('#hf_fullname').val($('#r_fullname').val());
                            $("#fullname").html($('#r_fullname').val());
                            $('#displayloggedin').show();
                            $('.displaylogin').hide();
                            $('#dialog_register').dialog("close");
                        },
                        error: function (xhr, status) {
                            alert("An error occurred: " + status);
                        }
                    });
                };
            });

            
            $("#formReg").validate({
                rules: {
                    r_passcode: {
                        minlength: 6,
                        //remote: "data.asmx/verifypasscode?id=" + $('#r_emailaddress').val()
                        passcode: true;

                    },
                    r_mobilenumber: { required: "#r_textnotifications:checked" }
                },
                messages: {
                    r_passcode: {
                        minlength: "Your pass code must be at least 6 characters long<br />",
                        //remote: " Your pass code must not already have been used<br />"
                    },
                    r_mobilenumber: {
                        required: "You must enter a mobile phone number if you want text notifications"
                    }
                }
            });
           

          

        
            $.validator.addMethod('passcode', function (value, element) {
                alert($('#r_emailaddress').val());
                alert(value);

                if (1 == 2) {
                    return true;
                } else {
                    //do ajax
                    return false;
                }
            }, "Invalid User ID / Passcode combination");
          

            $('#viewtermsandconditions').click(function () {
                $("#dialog_termsandconditions").dialog({
                    resizable: false,
                    height: 500,
                    width: 500,
                    modal: true,
                    buttons: {
                        "Continue": function () {
                            $(this).dialog("close");
                        }
                    }
                });
            });
          

			$("#submitbutton").on("click", function () {
				$("#form1").submit();
			});
			$('#submitbutton').css('cursor', 'pointer');
			/*
			$("input").keypress(function(event) {
				if (event.which == 13) {
					event.preventDefault();
					$("#form1").submit();
				}
			});
            */
        })

    </script>
</head>
<body>
    <form id="formReg" runat="server">

        <div id="dialog_termsandconditions" title="Terms and Conditions" style="display: none">
            <%= TermsAndConditions %>
                </div>

        <div class="row">
            <div class="form-group">
                <label class="control-label col-sm-4" for="r_fullname">Full name</label>
                <div class="col-sm-8">
                    <input type="text" name="r_fullname" id="r_fullname" class="form-control" required="required" />
                </div>
            </div>
        </div>

        <div class="row">
            <div class="form-group">
                <label class="control-label col-sm-4" for="r_emailaddress">Email Address</label>
                <div class="col-sm-8">
                    <input type="email" name="r_emailaddress" id="r_emailaddress" class="form-control" required="required" />
                </div>
            </div>
        </div>
        <!--
                <div class="row">
            <div class="form-group">
                <label class="control-label col-sm-4" for="r_userid">User ID</label>
                <div class="col-sm-8">
                    <input type="text" name="r_userid" id="r_userid" class="form-control" required="required" />
                </div>
            </div>
        </div>

            -->

        <div class="row">
            <div class="form-group">
                <label class="control-label col-sm-4" for="r_passcode">Pass code</label>
                <div class="col-sm-8">
                    <input type="text" name="r_passcode" id="r_passcode" class="form-control" required="required" /><span style="font-style: italic; font-size: 18px;">You will need to remember this to make bids.</span>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="form-group">
                <label class="control-label col-sm-4" for="r_mobilenumber">Mobile phone number</label>
                <div class="col-sm-8">
                    <input type="text" name="r_mobilenumber" id="r_mobilenumber" class="form-control" />
                </div>
            </div>
        </div>

        <div class="row">
            <div class="form-group">
                <label class="control-label col-sm-4" for="r_textnotifications">Send a text to my mobile phone number if I have been outbid on an item.</label>
                <div class="col-sm-1">
                    <input name="r_textnotifications" type="checkbox" id="r_textnotifications" class="form-control " value="Yes" checked="checked" />
                </div>
            </div>
        </div>

        <div class="row">
            <div class="form-group">
                <label class="control-label col-sm-4" for="r_contactpermission">I give permission to The Whanganui Womens Refuge to send information to me by email and/or text message from time to time.</label>
                <div class="col-sm-1">
                    <input name="r_contactpermission" type="checkbox" id="r_contactpermission" class="form-control" value="Yes" checked="checked" />
                </div>
            </div>
        </div>

        <div class="row">
            <div class="form-group">
                <label class="control-label col-sm-4" for="r_viewtermsandconditions">I have read and accept the terms and conditions
                <br />
                    <span id="viewtermsandconditions">View</span></label>
                <div class="col-sm-1">
                    <input name="r_viewtermsandconditions" type="checkbox" id="r_viewtermsandconditions" class="form-control" value="Yes" required="required" />
                </div>
            </div>
        </div>


        <div class="form-group">
            <div class="col-sm-4">
            </div>
            <div class="col-sm-8">
                <input type="button" name="save" id="save" value="Submit" />

            </div>
        </div>
    </form>


</body>
</html>
