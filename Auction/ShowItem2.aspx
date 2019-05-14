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
                    url: "data.asmx/logout"
                });
                $('#hf_user_ctr').removeAttr('value');
                $('#hf_fullname').removeAttr('value');
                $('#passcode').val('');
                $('#displayloggedin').hide();
                $('.displaylogin').show();
                //$('#fullnamelabel').html('Returning user?<br />Enter your pass code to bid:');
                //$('#fullname').html('<input name="passcode" type="text" id="passcode"><br />');
                //$('#registerhere').show();
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
                } else if ($('#hf_user_ctr').val() == '' && $('#passcode').val() == '') {
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
                    $("#confirmation-message").html("<br />Please confirm that you would like to make a bid of $" + $("#bid").val() + ".00 on the following item:<br /><br /><b>" + $('#title').html() + "</b>");
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
                                        url: "data.asmx/makebid?user_ctr=" + $("#hf_user_ctr").val() + "&item_ctr=" + $('#hf_item_ctr').val() + "&bid=" + $("#bid").val() + "&fullname=" + $("#hf_fullname").val() + "&passcode=" + $("#passcode").val(), success: function (returned) {
                                            returnedjson = $.parseJSON(returned);
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
                                            if (returnedjson.status == "Invalid pass code") {
                                            } else if (returnedjson.status == "Outbid") {
                                                //$("#fullnamelabel").html("Logged in as:");
                                                $("#fullname").html(returnedjson.fullname);

                                                $("#hf_user_ctr").val(returnedjson.user_ctr);
                                                $("#hf_fullname").val(returnedjson.fullname);

                                                $("#hf_highestbid").val(returnedjson.highestbid);
                                                $("#highestbid").html(returnedjson.highestbid);
                                                $("#highestbidder").html(returnedjson.highestbidder);
                                                $("#nextminimum").html(returnedjson.nextminimum);
                                                $("#bid").val(returnedjson.nextminimum);

                                            } else {
                                                $('#displayloggedin').show();
                                                $('.displaylogin').hide();
                                                $('#passcode').val('');

                                                $("#hf_user_ctr").val(returnedjson.user_ctr);

                                                //$("#fullnamelabel").html("Logged in as:");
                                                $("#fullname").html(returnedjson.fullname);
                                                $("#hf_fullname").val(returnedjson.fullname);
                                                $("#hf_highestbid").val(returnedjson.highestbid);
                                                $("#highestbid").html(returnedjson.highestbid);
                                                $("#highestbidder").html(returnedjson.highestbidder);
                                                $("#nextminimum").html(returnedjson.nextminimum);
                                                $("#bid").val(returnedjson.nextminimum);
                                                $("#registerhere").hide();
                                            }
                                            /*
                                            member("status") = status
                                            member("message") = message
                                            member("fullname") = fullname
                                            member("highestbid") = highestbid
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

            // $('body').on('click', '#register', function () {
            $("#register").click(function () {
                $('body').addClass('stop-scrolling');
              
                $('#dialog_register').dialog({
                    modal: true,
                    open: function () {
                        $(this).load('register.aspx');
                    },
                    width: $(window).width() * .75,
                    height: 500,
                    close: function () {
                        $('body').removeClass('stop-scrolling');
                    }
                });
              
            });


            $("input").keypress(function (event) {
                if (event.which == 13) {
                    event.preventDefault();
                    placebid();
                }
            });
            $('.slideshow').cycle();


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


        <div id="dialog_register" title="Register">
           
        </div>

        <h3><%=title %></h3>
        <p><%=description%></p>
        <%=itemimages %>

        <input name="hf_highestbid" id="hf_highestbid" type="hidden" value="<%=hf_highestbid%>" />
        <input name="hf_user_ctr" id="hf_user_ctr" type="hidden" value="<%=user_ctr%>" />
        <input name="hf_fullname" id="hf_fullname" type="hidden" value="<%=fullname%>" />
        <input name="hf_item_ctr" id="hf_item_ctr" type="hidden" value="<%=item_ctr%>" />

        <table class="table">
            <tr style="display: <%=displayloggedin%>" id="displayloggedin">
                <td>Logged in as: <span id="fullname"><%=fullname %></span>
                </td>
                <td>
                    <input type="button" name="logout" id="logout" value="Log out" /></td>
            </tr>

            <tr style="display: <%=displaylogin%>" class="displaylogin">
                <td>Returning user?<br />
                    Enter your pass code to bid:
                </td>
                <td>
                    <input name="passcode" type="text" id="passcode" /></td>
            </tr>

            <tr style="display: <%=displaylogin%>" class="displaylogin">
                <td>
                    <div>Don't have a pass code?</div>
                </td>
                <td>
                    <input type="button" name="register" id="register" value="Register here" /></td>
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
                <td>$<input name="bid" type="text" id="bid" class="numeric" maxlength="5" value="<%=nextminimum%>" />
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
