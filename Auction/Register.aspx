<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Auction.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#save').click(function () {
                if ($("#formReg").valid()) {
                    var arForm = [{ "name": "URL", "value": "<%=Request.Url.AbsoluteUri%>" }, { "name": "user_ctr", "value": 0 }, { "name": "fullname", "value": $('#r_fullname').val() }, { "name": "emailaddress", "value": $('#emailaddress').val() }, { "name": "passcode", "value": $('#r_passcode').val() }, { "name": "mobilenumber", "value": $('#mobilenumber').val() }, { "name": "textnotifications", "value": $('#textnotifications').val() }, { "name": "contactpermission", "value": $('#contactpermission').val() }];
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
                    passcode: {
                        minlength: 6,
                        remote: "data.asmx/verifypasscode"
                    },
                    mobilenumber: { required: "#TextNotifications:checked" }
                },
                messages: {
                    passcode: {
                        minlength: "Your pass code must be at least 6 characters long<br />",
                        remote: " Your pass code must not already have been used<br />"
                    },
                    mobilenumber: {
                        required: "You must enter a mobile phone number if you want text notifications"
                    }
                }
            });

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
            /*

			$("#submitbutton").on("click", function () {
				$("#form1").submit();
			});
			$('#submitbutton').css('cursor', 'pointer');
			
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
            <p>This Cancer Society of New Zealand (Canterbury-West Coast Division) silent auction will be conducted electronically with bids being displayed automatically.</p>
            <p>Items will be sold to the highest eligible bidder recorded at the close of bidding. You will be notified on screen if you are the winner and receive a text message confirmation of this.</p>
            <p>Bids will not be accepted after the close of the auction.</p>
            <p>Minimum Bid increments are indicated next to each item.</p>
            <p>No auction item may be redeemed for cash.</p>
            <p>Cancer Society of New Zealand (Canterbury-West Coast Division) shall not be liable for any loss or damage whatsoever suffered (including but not limited to direct or consequential loss) or personal injury suffered or sustained in connection with the auction or auction items except for any liability which cannot be excluded by law.</p>
            <p>By agreeing to these terms and conditions you the bidder accept that as a successful winner of an item you will fully pay for the item including any surcharge or tax and delivery of all the items you win in a timely manner.</p>
            <p>Cancer Society of New Zealand (Canterbury-West Coast Division) will keep a record of the details you provide when you registered to bid on the auction. Unless you advise Cancer Society of New Zealand (Canterbury-West Coast Division) otherwise, your name and contact details will be included in the list of event participants distributed to sponsors of the event and the list of bidders distributed to donors of the auction. If you wish to be removed from these databases, please let Cancer Society of New Zealand (Canterbury-West Coast Division) know in writing by emailing ball@cancercwc.org.nz and we’ll have you removed immediately.</p>
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
                <label class="control-label col-sm-4" for="emailaddress">Email Address</label>
                <div class="col-sm-8">
                    <input type="email" name="emailaddress" id="emailaddress" class="form-control" required="required" />
                </div>
            </div>
        </div>

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
                <label class="control-label col-sm-4" for="mobilenumber">Mobile phone number</label>
                <div class="col-sm-8">
                    <input type="text" name="mobilenumber" id="mobilenumber" class="form-control" />
                </div>
            </div>
        </div>

        <div class="row">
            <div class="form-group">
                <label class="control-label col-sm-4" for="textnotifications">Send a text to my mobile phone number if I have been outbid on an item.</label>
                <div class="col-sm-1">
                    <input name="textnotifications" type="checkbox" id="textnotifications" class="form-control " value="Yes" checked="checked" />
                </div>
            </div>
        </div>

        <div class="row">
            <div class="form-group">
                <label class="control-label col-sm-4" for="contactpermission">I give permission to The Whanganui Womens Refuge to send information to me by email and/or text message from time to time.</label>
                <div class="col-sm-1">
                    <input name="contactpermission" type="checkbox" id="contactpermission" class="form-control" value="Yes" checked="checked" />
                </div>
            </div>
        </div>

        <div class="row">
            <div class="form-group">
                <label class="control-label col-sm-4" for="contactpermission">I have read and accept the terms and conditions
                <br />
                    <span id="viewtermsandconditions">View</span></label>
                <div class="col-sm-1">
                    <input name="termsandconditions" type="checkbox" id="termsandconditions" class="form-control" value="Yes" required="required" />
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
