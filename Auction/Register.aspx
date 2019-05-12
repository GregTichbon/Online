<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Auction.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
      <!--<script src="<%: ResolveUrl("~/_Includes/Scripts/jquery-2.2.0.min.js")%>"></script>-->


    <script type="text/javascript">
        $(document).ready(function () {
            alert(1);
            $("#form1").validate({
                rules: {
                    password: {
                        minlength: 6,
                        remote: "validatepassword.asp"
                    },
					mobilenumber:{required:"#TextNotifications:checked"}
                },
                messages: {
                    password: {
						minlength: "Your pass code must be at least 6 characters long<br />",
						remote: " Your pass code must not already have been used<br />"
					},
					mobilenumber: {
						required: "You must enter a mobile phone number if you want text notifications"
					}
                }
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
    <form id="form1" runat="server">
        <div class="row">
            <div class="form-group">
                <label class="control-label col-sm-4" for="fullname">Full name</label>
                <div class="col-sm-8">
                    <input type="text" name="fullname" id="fullname" class="form-control" required />
                </div>
            </div>
        </div>

        <div class="row">
            <div class="form-group">
                <label class="control-label col-sm-4" for="emailaddress">Email Address</label>
                <div class="col-sm-8">
                    <input type="email" name="emailaddress" id="emailaddress" class="form-control" required />
                </div>
            </div>
        </div>

        <div class="row">
            <div class="form-group">
                <label class="control-label col-sm-4" for="password">Pass code</label>
                <div class="col-sm-8">
                    <input type="text" name="password" id="password" class="form-control" required /><span style="font-style: italic; font-size: 18px;">You will need to remember this to make bids.</span>
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
                <label class="control-label col-sm-4" for="TextNotifications">Send a text to my mobile phone number if I have been outbid on an item.</label>
                <div class="col-sm-1">
                    <br />
                    <input name="TextNotifications" type="checkbox" id="TextNotifications" class="form-control " value="-1" checked />
                </div>
            </div>
        </div>

        <div class="row">
            <div class="form-group">
                <label class="control-label col-sm-4" for="ContactPermission">I give permission to The Whanganui Womens Refuge to send information to me by email and/or text message from time to time.</label>
                <div class="col-sm-1">
                    <br />
                    <br />
                    <input name="ContactPermission" type="checkbox" id="ContactPermission" class="form-control" value="-1" checked />
                </div>
            </div>
        </div>


        <div class="form-group">
            <div class="col-sm-4">
            </div>
            <div class="col-sm-8">
                <input type="submit" name="_Submit" value="Submit" />
            </div>
        </div>
    </form>
</body>
</html>
