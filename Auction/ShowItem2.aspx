<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowItem2.aspx.cs" Inherits="Auction.ShowItem2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        .item-slideshow {
            height: 400px;
        }

            .item-slideshow img {
                width: auto;
                height: 100%;
            }

        .donor-slideshow {
            height: 100px;
        }

            .donor-slideshow img {
                width: auto;
                height: 100%;
            }

            .numeric {
                direction: rtl;
            }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            $(".numeric").keydown(function (event) {
                if (event.shiftKey == true) {
                    event.preventDefault();
                }
                if ((event.keyCode >= 48 && event.keyCode <= 57) ||
                    (event.keyCode >= 96 && event.keyCode <= 105) ||
                    event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 37 ||
                    event.keyCode == 39 || event.keyCode == 46 || (event.keyCode == 190 && 1 == 2)) {
                } else {
                    event.preventDefault();
                }

                if ($(this).val().indexOf('.') !== -1 && event.keyCode == 190)
                    event.preventDefault();
                //if a decimal has been added, disable the "."-button

            });
            $("#help").click(function () {
                mywidth = $(window).width() * .95;
                if (mywidth > 500) {
                    mywidth = 500;
                }
                $("#dialog_help").dialog({
                    resizable: false,
                    height: 340,
                    width: mywidth,
                    modal: true,
                    buttons: {
                        "Continue": function () {
                            $(this).dialog("close");
                        }
                    }
                });
            });

            $('body').on('click', '#logout', function () {
                $.ajax({
                    url: "logout.asp?noredirect=true"
                });
                $('#hf_userid').removeAttr('value');
                $('#hf_username').removeAttr('value');
                $('#usernamelabel').html('Returning user?<br />Enter your pass code to bid:');
                $('#username').html('<input name="passcode" type="text" id="passcode"><br />');
                $('#registerhere').show();
            })

            $('body').on('click', '#register', function () {
                parent.jQuery.colorbox.close();
                parent.window.location.replace("register.asp?item=" + $("#hf_itemid").val());
            })

            $("#submit").click(function () {
                placebid();
            });

            function placebid() {
                if (Number($("#bid").val()) <= Number($("#hf_highestbid").val())) {
                    $("#response-message").html("<br />" + 'Your bid needs to be higher than the current highest bid');
                    mywidth = $(window).width() * .95;
                    if (mywidth > 500) {
                        mywidth = 500;
                    }
                    $("#dialog_response").dialog({
                        resizable: false,
                        height: 340,
                        width: mywidth,
                        modal: true,
                        buttons: {
                            "Continue": function () {
                                $(this).dialog("close");
                            }
                        }
                    });
                    $("#bid").val(Number($("#hf_highestbid").val()) + 10);

                    //alert('Your bid needs to be higher than the current highest bid');
                } else if ($("#bid").val() % 10 != 0) {
                    $("#response-message").html("<br />" + 'Your bid should be to the nearest $10.00');
                    mywidth = $(window).width() * .95;
                    if (mywidth > 500) {
                        mywidth = 500;
                    }
                    $("#dialog_response").dialog({
                        resizable: false,
                        height: 340,
                        width: mywidth,
                        modal: true,
                        buttons: {
                            "Continue": function () {
                                $(this).dialog("close");
                            }
                        }
                    });
                    $("#bid").val(Number($("#hf_highestbid").val()) + 10);
                    //alert('Your bid should be to the nearest $10.00');
                } else if ($('#passcode').length > 0 && $('#passcode').val() == '') {
                    $("#response-message").html("<br />" + 'You need to enter your pass code');
                    mywidth = $(window).width() * .95;
                    if (mywidth > 500) {
                        mywidth = 500;
                    }
                    $("#dialog_response").dialog({
                        resizable: false,
                        height: 340,
                        width: mywidth,
                        modal: true,
                        buttons: {
                            "Continue": function () {
                                $(this).dialog("close");
                            }
                        }
                    });
                } else {
                    $("#confirmation-message").html("<br />Please confirm that you would like to make a bid of $" + $("#bid").val() + ".00 on the following item:<br /><br /><b>" + $('#hf_title').val() + "</b>");
                    $(function () {
                        mywidth = $(window).width() * .95;
                        if (mywidth > 500) {
                            mywidth = 500;
                        }
                        $("#dialog_confirm").dialog({
                            resizable: false,
                            height: 340,
                            width: mywidth,
                            modal: true,
                            buttons: {
                                "Yes - Please place this bid": function () {
                                    $(this).dialog("close");
                                    $.ajax({
                                        url: "data.asmx/makebid?user_ctr=" + $("#hf_user_ctr").val() + "&item_ctr=" + $('#hf_item_ctr').val() + "&bid=" + $("#bid").val() + "&username=" + $("#hf_username").val() + "&passcode=" + $("#passcode").val(), success: function (returned) {
                                            //alert(result);
                                            returnedjson = $.parseJSON(returned);
                                            //alert(returnedjson);
                                            $("#response-message").html("<br />" + returnedjson.message);
                                            mywidth = $(window).width() * .95;
                                            if (mywidth > 500) {
                                                mywidth = 500;
                                            }
                                            $("#dialog_response").dialog({
                                                resizable: false,
                                                height: 340,
                                                width: mywidth,
                                                modal: true,
                                                buttons: {
                                                    "Continue": function () {
                                                        $(this).dialog("close");
                                                    }
                                                }
                                            });
                                            //alert(returnedjson.message);
                                            if (returnedjson.status == "Invalid pass code") {

                                            } else if (returnedjson.status == "Outbid") {
                                                $("#usernamelabel").html("Logged in as:");
                                                $("#username").html(returnedjson.fullname + '&nbsp;&nbsp;<input type="button" name="logout" id="logout" value="Log out">');

                                                $("#hf_userid").val(returnedjson.hf_userid);
                                                $("#hf_username").val(returnedjson.fullname);

                                                $("#hf_highestbid").val(returnedjson.hf_highestbid);
                                                $("#highestbid").html(returnedjson.highestbid);
                                                $("#highestbidder").html(returnedjson.highestbidder);
                                                $("#nextminimum").html(returnedjson.nextminimum);
                                                $("#bid").val(returnedjson.bid);

                                            } else {
                                                $("#usernamelabel").html("Logged in as:");
                                                $("#username").html(returnedjson.fullname + '&nbsp;&nbsp;<input type="button" name="logout" id="logout" value="Log out">');

                                                $("#hf_userid").val(returnedjson.hf_userid);
                                                $("#hf_username").val(returnedjson.fullname);

                                                $("#hf_highestbid").val(returnedjson.hf_highestbid);
                                                $("#highestbid").html(returnedjson.highestbid);
                                                $("#highestbidder").html(returnedjson.highestbidder);
                                                $("#nextminimum").html(returnedjson.nextminimum);
                                                $("#bid").val(returnedjson.bid);
                                                $("#registerhere").hide();
                                            }
                                            /*
                                            member("status") = status
                                            member("message") = message
                                            member("fullname") = fullname
                                            member("hf_highestbid") = highestbid
                                            member("highestbid") = "$" & highestbid & ".00"
                                            member("highestbidder") = highestbidder
                                            member("nextminimum") = nextminimum
                                            member("bid") = nextbid
                                            */
                                        }
                                    });
                                },
                                "No - Please cancel this bid": function () {
                                    $(this).dialog("close");
                                }
                            }
                        });
                    });
                }
            }

            $("input").keypress(function (event) {
                if (event.which == 13) {
                    event.preventDefault();
                    placebid();
                }
            });


        });
    </script>


</head>
<body>
    <form id="form1" runat="server">
        <div id="dialog_confirm" title="Bid Confirmation">
            <span id="confirmation-message"></span>
        </div>
        <div id="dialog_response" title="Bid Response">
            <span id="response-message"></span>
        </div>
        <div id="dialog_help" title="HELP!" style="display: none">
            <br />
            <p>Welcome to the silent auction bidding page.</p>
            Making a bid is pretty simple!  You need to have a pass code to make a bid.  If you don't have a pass code, then you need to register.  Once you placed a bid, the system will remember you and you can continue to bid on all the items.  Remember to log out when you are finished.<p>If nobody is logged in, then you can either enter your pass code and make your bid or if you are not registered (don't have a pass code) then there is a REGISTER button to click and then enter your details.</p>
            <p>That's all, happy bidding and good luck.</p>
        </div>

        <h3><%=title %></h3>
        <p><%=description%></p>
        <%=itemimages %>

        <input name="hf_highestbid" id="hf_highestbid" type="hidden" value="<%=hf_highestbid%>" />
        <input name="hf_user_ctr" id="hf_user_ctr" type="hidden" value="<%=user_ctr%>" />
        <input name="hf_username" id="hf_username" type="hidden" value="<%=username%>" />
        <input name="hf_item_ctr" id="hf_item_ctr" type="hidden" value="<%=item_ctr%>" />

        <table class="table">
            <tr style="display: <%=displayloggedin%>" id="displayloggedin">
                <td>Logged in as:
                </td>
                <td>
                    <input type="button" name="logout" id="logout" value="Log out" /></td>
            </tr>

            <tr style="display: <%=displaylogin%>" id="displaylogin">
                <td>Returning user?<br />
                    Enter your pass code to bid:
                </td>
                <td>
                    <input name="passcode" type="text" id="passcode" /></td>
            </tr>

            <tr style="display: <%=displaylogin%>" id="displaylogin">
                <td>
                    <div>Don't have a pass code?</div>
                </td>
                <td>
                    <input type="button" name="logout" id="register" value="Register here" /></td>
            </tr>
            <tr>
                <td>
                    <div>Highest bid:</div>
                </td>
                <td><span id="highestbid"><%=highestbid%></span></td>
            </tr>
            <tr>
                <td>
                    <div>Highest bidder:</div>
                </td>
                <td><span id="highestbidder"><%=highestbidder%></span></td>
            </tr>
            <tr style="display: none">
                <td>
                    <div>Next minimum bid:</div>
                </td>
                <td><span id="nextminimum"><%=nextminimum%></span></td>
            </tr>
            <tr>
                <td>
                    <div>Your bid </div>
                </td>
                <td>$<input name="bid" type="text" id="bid" class="numeric" maxlength="5" />
                    <!-- value="<%=yourbid%>">.00-->
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <input type="button" name="submit" id="submit" value="Place Your Bid" /></td>
            </tr>
        </table>
    </form>
</body>
</html>
