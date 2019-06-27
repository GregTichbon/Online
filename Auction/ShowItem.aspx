<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowItem.aspx.cs" Inherits="Auction.ShowItem" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
       
        .showitem-slideshow {
            height: 400px;
        }
      
            .showitem-slideshow img {
                width: auto;
                height: 100%;
            }
               /*
        .donor-slideshow {
            height: 100px;
        }

            .donor-slideshow img {
                width: auto;
                height: 100%;
            }
*/
        .stop-scrolling2 {
            height: 100%;
            overflow: hidden;
        }
        .reservenote {
            color: red;
        }

        .centered {
            position: fixed; /* or absolute */
            top: 20%;
            left: 50%;
        }
            
    </style>



    <script type="text/javascript">
        var increment = <% =increment%>;
        var startbid = <% =startbid %>;
        var minimumbid = <% =startbid %>;

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
            /*
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
            */

            $('body').on('click', '#logout', function () {
                $.ajax({
                    url: "data.asmx/logout"
                });
                $('#hf_user_ctr').removeAttr('value');
                $('#hf_fullname').removeAttr('value');
                $('#passcode').val('');
                $('.displayloggedin').hide();
                $('.displaylogin').show();
                //$('#fullnamelabel').html('Returning user?<br />Enter your pass code to bid:');
                //$('#fullname').html('<input name="passcode" type="text" id="passcode"><br />');
                //$('#registerhere').show();
            })

            
                

            $("#submit").click(function () {
                placebid();
            });

            function placebid() {
                //var theautobid = Number($("#autobid").val());
                //if (theautobid > 0) {
                //    $('#autobid').val(theautobid + '.00');
                //}
                var bidmessage = "";
                var thebid = Number($("#bid").val());
                $("#bid").val(thebid + ".00");

                if (thebid % increment != 0) {
                    bidmessage = '<br />Your bid must be to the nearest $' + increment + '.00';
                    $("#bid").val(Number($("#hf_highestbid").val()) + increment + '.00');
                }
                if (thebid < startbid) {
                    bidmessage += '<br />Your bid must be greater than the starting bid of $' + startbid + '.00';
                    $("#bid").val(startbid + '.00');
                }
                if ($('#makeautobid').is(':checked')) {
                    if (thebid < Number($("#hf_highestbid").val()) + (2 * increment)) {
                        bidmessage += '<br />Your autobid is too low to be effective.';
                        $("#bid").val(Number($("#hf_highestbid").val()) + (2 * increment) + '.00');
                    }
                } else {
                    if (thebid <= Number($("#hf_highestbid").val())) {
                        bidmessage += '<br />Your bid needs to be higher than the current highest bid';
                        $("#bid").val(Number($("#hf_highestbid").val()) + increment + '.00');
                    }
                }


                if (bidmessage != "") {
                    $("#response-message").html(bidmessage);
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
                
                /*

                if ($('#makeautobid').is(':checked')) {
                    if (thebid < Number($("#hf_highestbid").val()) + (2 * increment)) {
                        $("#response-message").html("<br />" + 'Your auto bid needs to be higher');
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
                        $("#bid").val(Number($("#hf_highestbid").val()) + (2 * increment) + ".00");
                    } else {


                if (thebid <= Number($("#hf_highestbid").val())) {
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
                    $("#bid").val(Number($("#hf_highestbid").val()) + increment + ".00");

                } else if ($("#bid").val() % increment != 0) {
                    $("#response-message").html("<br />" + 'Your bid must be to the nearest $' + increment + '.00');
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
                    $("#bid").val(Number($("#hf_highestbid").val()) + increment);
//==================================================================================

                } else if (thebid < startbid) {
                    $("#response-message").html("<br />" + 'Your bid must be greater than the starting bid of $' + startbid + ".00");
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
                    $("#bid").val(startbid);
//==================================================================================

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
                } else if (theautobid > 0 && theautobid < thebid + (2 * increment)) {
                    $("#response-message").html("<br />" + 'Your autobid is too low.');
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
                    $("#autobid").val(thebid + (2 * increment) + '.00');
                } else if (theautobid % increment != 0) {
                    $("#response-message").html("<br />" + 'Your autobid must be to the nearest $' + increment + '.00'),
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
                    $("#autobid").val(parseInt((theautobid / increment) + 1) * increment + '.00');

                } else if ($('#makeautobid').is(':checked') && theautobid == '') {
                    $("#response-message").html("<br />" + "Your haven't specified an autobid"),
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
                    */

                } else {
                    thebid = parseFloat($("#bid").val());
                    if ($('#makeautobid').is(':checked')) {
                        bidmessage = "<br />Please confirm that you would like to make a autobid of upto $" + thebid + ".00 on the following item:<br /><br /><b>" + $("#dialog_showitem").dialog("option", "title") + "</b>"
                    }
                    else {
                        bidmessage = "<br />Please confirm that you would like to make a bid of $" + thebid + ".00 on the following item:<br /><br /><b>" + $("#dialog_showitem").dialog("option", "title") + "</b>"
                    }

                    $("#confirmation-message").html(bidmessage);
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
                                    $('#processing').show();
                                    $.ajax({
                                        url: "data.asmx/makebid?user_ctr=" + $("#hf_user_ctr").val() + "&item_ctr=" + $('#hf_item_ctr').val() + "&bid=" + $("#bid").val() + "&fullname=" + $("#hf_fullname").val() + "&passcode=" + $("#passcode").val() + "&increment=" + increment + "&autobid=" + $('#makeautobid').is(':checked'), success: function (returned) {
                                            $('#processing').hide();
                                            returnedjson = $.parseJSON(returned);
                                            $("#response-message").html("<br />" + returnedjson.message);
                                            //$("#response-message").html("<br />" + returnedjson.message);
                                            mywidth = ($(window).width() - 0) * .95;
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
                                                //$("#reservenote").html(returnedjson.reservenote);
                                                $("#highestbidder").html(returnedjson.highestbidder);
                                                $("#nextminimum").html(returnedjson.nextminimum);
                                                $("#bid").val(returnedjson.nextminimum);

                                            } else {
                                                $('.displayloggedin').show();
                                                $('.displaylogin').hide();
                                                $('#passcode').val('');

                                                $("#hf_user_ctr").val(returnedjson.user_ctr);

                                                //$("#fullnamelabel").html("Logged in as:");
                                                $("#fullname").html(returnedjson.fullname);
                                                $("#hf_fullname").val(returnedjson.fullname);
                                                $("#hf_highestbid").val(returnedjson.highestbid);
                                                $("#highestbid").html(returnedjson.highestbid);
                                                //$("#reservenote").html(returnedjson.reservenote);
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
                $('body').addClass('stop-scrolling2');
              
                $('#dialog_register').dialog({
                    modal: true,
                    open: function () {
                        $(this).load('register.aspx');
                    },
                    width: $(window).width() * .90,
                    height: 500,
                    close: function () {
                        $(this).html('');
                        $('body').removeClass('stop-scrolling2');
                    }
                });
              
            });

            $("#login").click(function () {
                $('body').addClass('stop-scrolling2');
              
                $('#dialog_login').dialog({
                    modal: true,
                    open: function () {
                        $(this).load('login.aspx');
                    },
                    width: $(window).width() * .90,
                    height: 500,
                    close: function () {
                        $(this).html('');
                        $('body').removeClass('stop-scrolling2');
                    }
                });
              
            });


            $("input").keypress(function (event) {
                if (event.which == 13) {
                    event.preventDefault();
                    placebid();
                }
            });
            $('.showitem-slideshow').cycle();

            
            $('#makeautobid').change(function () {
                if ($(this).is(':checked')) {
                    $("#bid").val(Number($("#bid").val()) + '.00');
                }
                /*
                    $("#span_autobid").show();  // checked
                } else {
                    $('#autobid').val('');
                    $("#span_autobid").hide();  // unchecked
                    }
                    */
            })
           

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
        <!--
        <div id="dialog_help" title="HELP!" style="display: none">
            <br />
            <p>Welcome to the silent auction bidding page.</p>
            Making a bid is pretty simple!  You need to have a pass code to make a bid.  If you don't have a pass code, then you need to register.  Once you placed a bid, the system will remember you and you can continue to bid on all the items.  Remember to log out when you are finished.<p>If nobody is logged in, then you can either enter your pass code and make your bid or if you are not registered (don't have a pass code) then there is a REGISTER button to click and then enter your details.</p>
            <p>That's all, happy bidding and good luck.</p>
        </div>
        -->


        <div id="dialog_register" title="Register"></div>
        <div id="dialog_login" title="Login"></div>

        <!--<p id="show_title"><%=title %></p>-->
        <p id="show_shortdescription"><%=shortdescription%></p>
        <%=itemimages %>
 


        <input name="hf_highestbid" id="hf_highestbid" type="hidden" value="<%=hf_highestbid%>" />
        <input name="hf_user_ctr" id="hf_user_ctr" type="hidden" value="<%=user_ctr%>" />
        <input name="hf_fullname" id="hf_fullname" type="hidden" value="<%=fullname%>" />
        <input name="hf_item_ctr" id="hf_item_ctr" type="hidden" value="<%=item_ctr%>" />

        <table class="table">

            <!--

            <tr style="display: <%=displayloggedin%>" class="displayloggedin">
                <td>Logged in as: <span id="fullname"><%=fullname %></span>
                </td>
                <td>
                    <input type="button" name="logout" id="logout" value="Log out" /></td>
            </tr>

            <tr style="display: <%=displaylogin%>" class="displaylogin">
                <td></td>
                <td>
                    <input type="button" name="login" id="login" value="Login" />
                    <input type="button" name="register" id="register" value="Register" /></td>
            </tr>

                -->


            <tr>
                <td>
                    <span style="display: <%=displayloggedin%>" class="displayloggedin">Logged in as: <span id="fullname"><%=fullname %></span></span>
                </td>
                <td>
                    <input style="display: <%=displayloggedin%>" class="displayloggedin" type="button" name="logout" id="logout" value="Log out" />
                    <input style="display: <%=displaylogin%>" class="displaylogin" type="button" name="login" id="login" value="Login" />
                    <input style="display: <%=displaylogin%>" class="displaylogin" type="button" name="register" id="register" value="Register" />
                </td>
            </tr>

            <tr>
                <td>Highest bid: 
                </td>
                <td><span id="highestbid"><%=highestbid%></span></td>
            </tr>
            <tr>
                <td>Highest bidder: 
                </td>
                <td><span id="highestbidder"><%=highestbidder%></span></td>
            </tr>
            <!--
            <tr style="display: none">
                <td>Next minimum bid: 
                </td>
                <td><span id="nextminimum"><%=nextminimum%></span></td>
            </tr>
            -->
            <tr style="display: <%=displayloggedin%>" class="displayloggedin">
                <td>Your bid 
                </td>
                <td>$<input name="bid" type="text" id="bid" class="numeric" maxlength="5" value="<%=nextminimum%>" /><input type="checkbox" id="makeautobid" value="Yes" <%=autobidchecked%> />
                    Make this an AutoBid <img src="Images/Auction<%=parameters["Auction_CTR"]%>/questionsmall.png" title="By setting an autobid, bids will be automatically made for you up to the lower of, the bid you have set, the reserve price (where set), or an increment higher than the previous bidder." />
                </td>
            </tr>
            <!--
            <tr style="display: <%=displayloggedin%>" class="displayloggedin">
                <td>
                    <input type="checkbox" id="makeautobid" value="Yes" <%=autobidchecked%> />
                    Make an AutoBid (?)
                </td>
                <td>
                    <span id="span_autobid" style="display: <%=displayautobid%>">$<input name="autobid" type="text" id="autobid" class="numeric" maxlength="5" value="<%=autobidamount %>" /></span>
                </td>
            </tr>
            -->
            <!--
            <tr>
                <td>
                        
                </td>
                <td>
                    <input type="checkbox" id="makeautobid" value="Yes" />
                        Make this an AutoBid (?)
                </td>
            </tr>
                          -->
            <tr style="display: <%=displayloggedin%>" class="displayloggedin">
                <td></td>
                <td>
                    <input type="button" name="submit" id="submit" value="Place Your Bid" /></td>
            </tr>
        </table>
        <p id="show_description"><%=description%></p>
        <div id="processing" style="display: none">
            <img src="_Includes/Images/processing.gif" class="centered" />
        </div>
    </form>
</body>
</html>
