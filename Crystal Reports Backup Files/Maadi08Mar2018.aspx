<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Maadi08Mar2018.aspx.cs" Inherits="DataInnovations.Raffles.Maadi08Mar2018" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-113505480-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-113505480-1');
</script>

    <title>Maadi Cup Raffle Fundraiser February 2018</title>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
    <style>
        body {
                font-family: Arial;
                font-size: 20px;
            }

                .td0a {
            background-color: blue;
        }

        .td1a {
            background-color: red;
        }

                        .td0b {
            background-color: lightblue;
        }

        .td1b {
            background-color: lightpink;
        }

        table.blueTable {
            border: 1px solid #1C6EA4;
            background-color: lightgray;
            text-align: center;
            border-collapse: collapse;
        }

            table.blueTable td, table.blueTable th {
                border: 2px solid #1C6EA4;
                padding: 3px 10px;
                height: 50px;
                width: 9%;
            }

            table.blueTable tbody td {
                font-family: Arial;
                font-size: 20px;
                font-weight: bolder;
            }

      

        input[type="button"] {
            background: #3498db;
            background-image: -webkit-linear-gradient(top, #3498db, #2980b9);
            background-image: -moz-linear-gradient(top, #3498db, #2980b9);
            background-image: -ms-linear-gradient(top, #3498db, #2980b9);
            background-image: -o-linear-gradient(top, #3498db, #2980b9);
            background-image: linear-gradient(to bottom, #3498db, #2980b9);
            -webkit-border-radius: 28;
            -moz-border-radius: 28;
            border-radius: 28px;
            font-family: Arial;
            color: #ffffff;
            font-size: 18px;
            padding: 8px 16px 8px 16px;
            text-decoration: none;
        }

            input[type="button"]:hover {
                background: #3cb0fd;
                background-image: -webkit-linear-gradient(top, #3cb0fd, #3498db);
                background-image: -moz-linear-gradient(top, #3cb0fd, #3498db);
                background-image: -ms-linear-gradient(top, #3cb0fd, #3498db);
                background-image: -o-linear-gradient(top, #3cb0fd, #3498db);
                background-image: linear-gradient(to bottom, #3cb0fd, #3498db);
                text-decoration: none;
            }

        input[type=text], input[type=email], textarea {
            width: 100%;
        }
        .auto-style1 {
            width: 872px;
            text-align: center;
        }
        .auto-style2 {
            width: 251px;
            height: 347px;
        }
        .auto-style3 {
            width: 367px;
            height: 384px;
        }
        .auto-style4 {
            width: 267px;
            height: 332px;
        }

        .processing {
 position: fixed;
  left: 0px;
  top: 0px;
  width: 100%;
  height: 100%;
  z-index: 9999;
  background: url('Images/ajax-loader.gif') 50% 50% no-repeat rgb(249,249,249);

}

    </style>



    <script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="http://datainn.co.nz/javascript/jquery.validate.min.js"></script>


    <script type="text/javascript">


        $(document).ready(function () {

            $("#span_bank").html($("#hf_bank").val());
            06-0996-0956968-00
            $( "#dialog" ).dialog({
                autoOpen: false,
                width: 600,
                appendTo: "#form1" 
            });

            $(".iwantthisticket").click(function () {
                ticket = $(this).prop('id').substring(7);
                $("#hf_ticket").val(ticket);  
  
                $("#hf_update").val("no");  

                var arForm = $("#form1")
                    .find("input,textarea,select,hidden")
                    .not("[id^='__']")
                    .serializeArray();

                var formData = JSON.stringify({ formVars: arForm });

                $.ajaxSetup({
                    beforeSend:function(){
                        // show gif here, eg:
                        $("#processingajax").show();
                    },
                    complete:function(){
                        // hide gif here, eg:
                        $("#processingajax").hide();
                    }
                });

                $.ajax({
                    type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                    async: false,
                    contentType: "application/json; charset=utf-8",
                    url: 'posts.asmx/getticket', // the url where we want to POST
                    data: formData,
                    dataType: 'json', // what type of data do we expect back from the server
                    success: function (result) {
                        details = $.parseJSON(result.d);
                        if(details.status == "Available") {
                            $('.ticket').html(ticket);
                            $( "#dialog" ).dialog("open");
                        } else {
                            $("#td_" + ticket).html("Taken");
                            alert("I'm sorry - this ticket has just been taken.  Try another one.");
                            $('#span_available').html($('#span_available').html() - 1)
                        }  
                    },
                    error: function (xhr, status) {
                        alert("An error occurred: " + status);
                    }
                })
    
/*  
                $.ajax({
                    url: "data.asmx/getticket?raffle=1&ticket=" + ticket + "&update=", success: function (result) {
                        property = $.parseJSON(result);
                        address = property[0];
                        if(address.label == "Available") {
                            $('#td_ticket').html(ticket);
                            $( "#dialog" ).dialog({width: 600});
                        } else {
                            $("#td_" + ticket).html("Taken");
                            alert("I'm sorry - this ticket has just been taken.  Try another one.");
                        }
                    }
                });
*/
            });


            $("#btn_get").click(function () {
                if($('#form1').valid()) { 

                    $( "#dialog" ).dialog('close')
                    ticket = $("#td_ticket").html();
                    $("#hf_update").val("yes");  
                    var arForm = $("#form1")
                        .find("input,textarea,select,hidden")
                        .not("[id^='__']")
                        .serializeArray();

                    var formData = JSON.stringify({ formVars: arForm });
                    $.ajax({
                        type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                        async: false,
                        contentType: "application/json; charset=utf-8",
                        url: 'posts.asmx/getticket', // the url where we want to POST
                        data: formData,
                        dataType: 'json', // what type of data do we expect back from the server
                        success: function (result) {

                            details = $.parseJSON(result.d);
                            if(details.status == "Updated") {
                                $("#td_" + ticket).html("On hold to you");
                                alert("Thanks - this ticket has been put on hold awaiting payment.  Please feel free to take as many tickets as you like.");
                            } else {
                                $("#td_" + ticket).html("Taken");
                                alert("I'm sorry - this ticket has just been taken.  Try another one.");
                            }
                            $('#span_available').html($('#span_available').html() - 1)
                        },
                        error: function (xhr, status) {
                            alert("An error occurred: " + status);
                        }
                    })

/*
                $.ajax({
                    url: "data.asmx/getticket?raffle=1&ticket=" + ticket + "&update=yes", success: function (result) {
                        property = $.parseJSON(result);
                        address = property[0];
                        if(address.label == "Updated") {
                            $("#td_" + ticket).html("YOU'VE GOT IT");
                        } else {
                            $("#td_" + ticket).html("Taken");
                            alert("I'm sorry - this ticket has just been taken.  Try another one.");
                        }
                    }
                });
*/
            }
            }); //btn_get
        }); //document.ready
    </script>
</head>
<body>
    <p>
        The Cullinane and Girls&#39; College Rowers are heading to Maadi and have been fundraising hard.&nbsp; Sausage sizzles, a hangi, marshalling for the off roaders etc and selling raffle tickets.&nbsp; We have a few more raffles to sell to cover costs.</p>
    <p>
        
        We&#39;re leaving on Saturday 17th March and returning on Tuesday 27th March.&nbsp; Most of us will be flying but the Ignition Ute and Boat Trailer and another van will have to make the long trek down by road and ferry.</p>
    <p>
        Obviously there is a high cost to this trip, and we are endevouring to make it as affordable for everyone as possible.&nbsp;&nbsp; We are also doing a number of other fundraisers of which this raffle is just one.&nbsp;</p>
    <p>
        <strong>This Raffle</strong></p>
    <p>
        There are 50 tickets on each card.&nbsp; The cost is <strong>$20.00</strong> but ... that means your number is entered into <strong>10 weekly draws (ie: $2.00 per week)</strong> for a meat pack worth <strong>$50.00 from Chef&#39;s Choice</strong>.&nbsp; You have overall a 20% chance of winning!</p>
    <p>
        If you&#39;d like to support the rowers, please grab one of the tickets below.&nbsp; You can either pay the money into the friends of Union bank account or otherwise let us know how you can get it to us.&nbsp; Click on the buttons below and you&#39;ll be provided with the bank account and asked for your details.&nbsp; It couldn&#39;t be easier.&nbsp; 
        Your ticket will be placed &quot;on hold&quot; to you until payment is sussed.</p>
    <p>
        Thanks for your support.</p>
    <p>
        &nbsp;</p>
    <p style="text-align: center">
        <img alt="" class="auto-style2" src="Images/Cullinane%20Logo.jpg" /><img alt="" class="auto-style3" src="Images/Whanganui%20Girls%20College%20logo.jpg" /><img alt="" class="auto-style4" src="Images/UBC.png" /><br />
        <img alt="" class="auto-style1" src="Images/ChefsChoice%20Logo.PNG" /></p>
&nbsp;<form id="form1" runat="server">
    <!--<div style="width:20%; float:left">-->
        <input type="hidden" id="hf_ticket" name="hf_ticket" />
        <input type="hidden" id="hf_update" name="hf_update" />
        <input type="hidden" id="hf_bank" name="hf_bank" value="38-9018-0421031-00" />
    <!--
        <p>There are <span id="span_available1"><%: available1 %></span> tickets currently available on this card.</p>

        <table id="tbl1" class="blueTable">
            <tbody>
                
                <asp:Literal ID="LitRows1" runat="server"></asp:Literal>
            </tbody>
        </table>
    -->
    <p>The RED card has all been sold now.  THANKS.  The WHITE card has a few more to go.</p>

        <p>There are <span id="span_available2"><%: available2 %></span> tickets currently available on this card.</p>
    <table id="tbl2" class="blueTable">
            <tbody>
                <!--
                <tr>
                    <td>Ticket Number</td>
                    <td>Status</td>
                </tr>
                -->
                <asp:Literal ID="LitRows2" runat="server"></asp:Literal>
            </tbody>
        </table>
        <!--
            </div>
 <div style="width:80%; float:left">
     Greg
     </div>
        -->
  
    </form>



        <div id="dialog" title="Please enter your details">
            <table class="blueTable" style="width: 100%">
                <tr>
                    <td style="text-align: right">Ticket Number:</td>
                    <td id="td_ticket" class="ticket"></td>
                </tr>
                <tr>
                    <td style="text-align: right">Your name:</td>
                    <td style="text-align: left">
                        <input type="text" id="tb_name" name="tb_name" required="required" /></td>
                </tr>
                <tr>
                    <td style="text-align: right">Email Address:</td>
                    <td>
                        <input type="email" id="tb_emailaddress" name="tb_emailaddress" required="required" /></td>
                </tr>
                <tr>
                    <td style="text-align: right">Mobile Number:</td>
                    <td>
                        <input type="text" id="tb_mobile" name="tb_mobile" /></td>
                </tr>
                <tr>
                    <td style="text-align: right">How will you get the money to Greg?
                        <br /><span style="font-size:small">Bank A/c No: <span id="span_bank"></span><br />Please use <b>"Maadi <span class="ticket"></span></b>" as your reference.</span></td>
                    <td>
                        <textarea id="tb_payment" name="tb_payment" required="required"></textarea></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input id="btn_get" type="button" value="Get this ticket" /></td>
                </tr>
            </table>
        </div>

    
</body>
</html>
