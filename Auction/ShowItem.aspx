<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowItem.aspx.cs" Inherits="Auction.ShowItem" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Online Auction</title>

    <link href="_Includes/css/jquery-ui.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://unpkg.com/tachyons@4.10.0/css/tachyons.min.css" />
    <link href="https://fonts.googleapis.com/css?family=Montserrat&display=swap" rel="stylesheet" />

    <link href="_Includes/css/main.css" rel="stylesheet" />

    <style>
        body {
            font-family: 'Montserrat', sans-serif;
        }

        .showitem-slideshow {
            max-height: 400px;
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

        .dollar {
            background: url(images/auction2/dollarsign.png) no-repeat scroll 7px 7px;
            padding-left:30px;
        }
    </style>

    <script type="text/javascript">
        var increment = <% =increment%>;
        var startbid = <% =startbid %>;
        //var minimumbid = <% =startbid %>;

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
            $('body').on('click', '#logout', function () {
                $.ajax({
                    url: "data.asmx/logout"
                });
                $('#hf_user_ctr').removeAttr('value');
                $('#hf_fullname').removeAttr('value');
                $('#passcode').val('');
                $('.displayloggedin').hide();
                $('.displaylogin').show();
                $('#highestbidder').html($('#highestbidder').html().replace(' <b>(YOU!)</b>', ''));
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
                }
                if (thebid < startbid) {
                    bidmessage += '<br />Your bid must be greater than the starting bid of $' + startbid + '.00';
                }
                if ($('#makeautobid').is(':checked')) {
                    if (thebid < Number($("#hf_highestbid").val()) + (2 * increment)) {
                        bidmessage += '<br />Your autobid is too low to be effective.';
                    } else if (thebid == Number($("#hf_autobid").val())) {
                        bidmessage += '<br />You already have this autobid set.';
                    }
                } else {
                    if (thebid <= Number($("#hf_highestbid").val())) {
                        bidmessage += '<br />Your bid needs to be higher than the current highest bid';
                    }
                }

                if (bidmessage != "") {
                    if ($('#makeautobid').is(':checked')) {
                        thebid = Number($("#hf_highestbid").val()) + (2 * increment);
                        
                    } else {
                        thebid = Number($("#hf_highestbid").val()) + increment;
                        if (thebid < startbid) {
                            thebid = startbid;
                        }
                    }
                    $("#bid").val(thebid + '.00');
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
                        },
                        closeText: false
                    });
                } else {
                    thebid = parseFloat($("#bid").val());
                    if ($('#makeautobid').is(':checked')) {
                        if (Number($('#hf_autobid').val()) > 0) {
                            bidmessage = "<br />Please confirm that you would like to <b>change your autobid from " + parseFloat($("#hf_autobid").val()) + ".00 to being upto $" + thebid + ".00</b> on the following item:<br /><br /><b>" + $("#dialog_showitem").dialog("option", "title") + "</b>"
                        } else {
                            bidmessage = "<br />Please confirm that you would like to make an <b>autobid</b> of upto <b>$" + thebid + ".00</b> on the following item:<br /><br /><b>" + $("#dialog_showitem").dialog("option", "title") + "</b>"
                        }
                    }
                    else {
                        if (Number($('#hf_autobid').val()) > 0) {
                            if (thebid < Number($('#hf_autobid').val())) {
                                bidmessage = "<br />Please confirm that you would like to <b>remove your autobid</b> and make a bid of <b>$" + thebid + ".00</b> on the following item:<br /><br /><b>" + $("#dialog_showitem").dialog("option", "title") + "</b>"
                            } else {
                                bidmessage = "<br />Please confirm that you would like to make a bid of <b>$" + thebid + ".00</b> on the following item:<br /><br /><b>" + $("#dialog_showitem").dialog("option", "title") + "</b>"
                            }
                        } else {
                            bidmessage = "<br />Please confirm that you would like to make a bid of <b>$" + thebid + ".00</b> on the following item:<br /><br /><b>" + $("#dialog_showitem").dialog("option", "title") + "</b>"
                        }
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
                                                //not using passcodes
                                            }
                                            else {
                                                //$("#fullnamelabel").html("Logged in as:");
                                                //$("#hf_user_ctr").val(returnedjson.user_ctr);
                                                //$("#fullname").html(returnedjson.fullname);
                                                //$("#hf_fullname").val(returnedjson.fullname);

                                                /*
                                                resultclass.status = status;
                                                resultclass.message = message;
                                                resultclass.user_ctr = user_ctr;
                                                resultclass.fullname = fullname;
                                                resultclass.highestbid = highestbid;
                                                resultclass.highestbidmessage = highestbidmessage;
                                                resultclass.highestbidder_user_ctr = highestbidder_user_ctr;
                                                resultclass.highestbidder_fullname = highestbidder_fullname;
                                                resultclass.nextminimum = nextminimum;
                                                */

                                                //if (returnedjson.status == "Outbid") {
                                                //    $("#hf_highestbid").val(returnedjson.highestbid);
                                                //    $("#highestbid").html(returnedjson.highestbid);
                                                //    $("#highestbidder").html(returnedjson.highestbidder);
                                                //    $("#nextminimum").html(returnedjson.nextminimum);
                                                //    $("#bid").val(returnedjson.nextminimum);
                                                //} else {
                                                    //$('.displayloggedin').show();
                                                //$('.displaylogin').hide();
                                                //$('#passcode').val('');
                                                $("#hf_highestbid").val(returnedjson.highestbid);
                                                $("#hf_autobid").val(returnedjson.autobid);
                                                //alert('need to record autobid');
                                                $("#hf_highestbidder").html(returnedjson.highestbidder_user_ctr);
                                                $("#highestbidmessage").html(returnedjson.highestbidmessage);
                                                $("#highestbidder").html(returnedjson.highestbidder_fullname);
                                                $("#nextminimum").html(returnedjson.nextminimum);
                                                $("#bid").val(returnedjson.nextminimum);
                                                $('#makeautobid').prop("checked", false);

                                                //$("#registerhere").hide();
                                            }
                                        //}
                                        }
                                    });
                                },
                                "No - Please cancel this bid": function () {
                                    $(this).dialog("close");
                                }
                            },
                            closeText: false
                        });
                    });
                }
            }

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
                    },
                    closeText: false
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
                    },
                    closeText: false
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
        <input name="hf_highestbid" id="hf_highestbid" type="hidden" value="<%=hf_highestbid%>" />
        <input name="hf_highestbidder" id="hf_highestbidder" type="hidden" value="<%=hf_highestbidder%>" />
        <input name="hf_user_ctr" id="hf_user_ctr" type="hidden" value="<%=user_ctr%>" />
        <input name="hf_fullname" id="hf_fullname" type="hidden" value="<%=fullname%>" />
        <input name="hf_item_ctr" id="hf_item_ctr" type="hidden" value="<%=item_ctr%>" />
        <input name="hf_autobid" id="hf_autobid" type="hidden" value="<%=autobid%>" />
        <div id="dialog_confirm" title="Bid Confirmation">
            <span id="confirmation-message"></span>
        </div>
        <div id="dialog_response" title="Bid Response">
            <span id="response-message"></span>
        </div>
        <div id="dialog_register" title="Register"></div>
        <div id="dialog_login" title="Login"></div>
        <div class="pa3 mw9 center">
            <div class="cf">
                <div class="fl w-100 pa4">
                    <div class="mb4">
                        <%=itemimages %>
                    </div>
                    <div class="lh-copy f6"><%=shortdescription%></div>
                </div>
            </div>
        </div>

        <div class="fl w-100 pa4">
            <table class="f6 w-100 center mb4" cellspacing="0">
                <tbody class="lh-copy">
                    <tr>
                        <td class="pv3 pr3 bb b--black-20" style="text-align:right">
                            <span style="display: <%=displayloggedin%>" class="displayloggedin">Logged in as: <span id="fullname"><%=fullname %></span></span>
                        </td>
                        <td class="pv3 pr3 bb b--black-20">
                            <input style="display:<%=displayloggedin%>" class="displayloggedin f6 grow no-underline br-pill ph3 pv2 dib white bg-blue pointer" type="button" name="logout" id="logout" value="Log out" />
                            <input style="display:<%=displaylogin%>" class="displaylogin f6 grow no-underline br-pill ph3 pv2 dib white bg-blue pointer" type="button" name="login" id="login" value="Login" />
                            <input style="display:<%=displaylogin%>" class="displaylogin f6 grow no-underline br-pill ph3 pv2 dib white bg-blue pointer" type="button" name="register" id="register" value="Register" />
                        </td>
                    </tr>
                    <tr>
                        <td class="pv3 pr3 bb b--black-20" style="text-align:right">Highest bid: 
                        </td>
                        <td class="pv3 pr3 bb b--black-20"><span id="highestbidmessage"><%=highestbidmessage%></span></td>
                    </tr>
                    <tr>
                        <td class="pv3 pr3 bb b--black-20" style="text-align:right">Highest bidder: 
                        </td>
                        <td class="pv3 pr3 bb b--black-20"><span id="highestbidder"><%=highestbidder%></span></td>
                    </tr>
                    <tr style="display: <%=displayloggedin%>" class="displayloggedin">
                        <td class="pv3 pr3 bb b--black-20" style="text-align:right">Your bid: 
                        </td>
                        <td class="pv3 pr3 bb b--black-20"><input name="bid" type="text" id="bid" class="dollar br2 pa2 input-reset ba bg-transparent measure b--silver numeric" maxlength="8" value="<%=nextminimum%>" />&nbsp;<span id="span_autobid"><input class="pa2" type="checkbox" id="makeautobid" value="Yes" <%=autobidchecked%> />&nbsp;Make this an AutoBid&nbsp;<img src="Images/Auction<%=parameters["Auction_CTR"]%>/questionsmall.png" title="By setting an autobid, bids will be automatically made for you up to the lower of, the bid you have set, the reserve price (where set), or an increment higher than the previous bidder." /></span>
                        </td>
                    </tr>
                    <tr style="display: <%=displayloggedin%>" class="displayloggedin">
                        <td class="pv3 pr3 bb b--black-20"></td>
                        <td class="pv3 pr3 bb b--black-20">
                            <input type="button" name="submit" id="submit" value="Place Your Bid" class="f6 grow no-underline br-pill ph3 pv2 dib white bg-blue pointer" /></td>
                    </tr>
                </tbody>
            </table>
            <p id="show_description"><%=description%></p>
            <div id="processing" style="display: none">
                <img src="_Includes/Images/processing.gif" class="centered" />
            </div>
        </div>
    </form>
</body>
</html>
