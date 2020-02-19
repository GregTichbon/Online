<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Maadi01Feb2018.aspx.cs" Inherits="DataInnovations.Raffles.Maadi01Feb2018" %>

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
            height: 337px;
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
    </style>



    <script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="http://datainn.co.nz/javascript/jquery.validate.min.js"></script>


    <script type="text/javascript">


        $(document).ready(function () {
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
        Hi, I&#39;ve been asked to sell some raffle tickets.</p>
    <p>
        Cullinane and Girls&#39; Colleges as part of the Union Boat Club (<a href="http://unionboatclub.co.nz" target="_blank">unionboatclub.co.nz</a>) are taking a group of students to the Maadi Cup rowing regatta at Lake Ruataniwha in Twizel (<a href="http://www.maadi.co.nz" target="_blank">www.maadi.co.nz</a>).</p>
    <p>
        Neo is now a keen rower, into his second year and is going.&nbsp; In the Cambridge Town Cup last weekend he made 2 A finals; The Under 16 single sculls and the Under 18 coxed quad sculls (<a href="https://www.rowit.co.nz/results/kric2018r2?pid=32711" target="_blank">Results</a>)&nbsp; He&#39;s loving it and working really hard.</p>
    <p>
        We&#39;re leaving on Saturday 17th March and returning on Tuesday 27th March.&nbsp; Most of us will be flying but the Ignition Ute and Boat Trailer and another van will have to make the long trek down by road and ferry.</p>
    <p>
        Obviously there is a high cost to this trip, and we are endevouring to make it as affordable for everyone as possible.&nbsp;&nbsp; We are also doing a number of fundraisers of which this raffle is just one.&nbsp; We are also planning a hangi on&nbsp; Wednesday 21st February and some car washes and sausage sizzles.</p>
    <p>
        This Raffle</p>
    <p>
        There are 50 tickets.&nbsp; The cost is $20.00 but ... that means your number is entered into 10 weekly draws (ie: $2.00 per week) for a meat pack worth $50.00 from Chef&#39;s Choice.&nbsp; You have overall a 20% chance of winning!</p>
    <p>
        If you&#39;d like to support the rowers, please grab one of the tickets below.&nbsp; You can either pay the money into my bank account or otherwise let me know how you can get it to me.&nbsp; Click on the buttons below and you&#39;ll be provided with my bank account and asked for your details.&nbsp; It couldn&#39;t be easier.&nbsp; 
        I&#39;ll place your ticket &quot;on hold&quot; to you until payment is sussed.</p>
    <p>
        Thanks for your support.&nbsp;</p>
    <p>
        &nbsp;</p>
    <p>
        -Greg</p>
    <p style="text-align: center">
        <img alt="" class="auto-style2" src="Images/Cullinane%20Logo.jpg" /><img alt="" class="auto-style3" src="Images/Whanganui%20Girls%20College%20logo.jpg" /><img alt="" class="auto-style4" src="Images/UBC.png" /><br />
        <img alt="" class="auto-style1" src="Images/ChefsChoice%20Logo.PNG" /></p>
&nbsp;<form id="form1" runat="server">
    <!--<div style="width:20%; float:left">-->
        <input type="hidden" id="hf_ticket" name="hf_ticket" />
        <input type="hidden" id="hf_update" name="hf_update" />
        <p>There are <span id="span_available"><%: available %></span> tickets currently available.</p>

        <table id="tbl" class="blueTable">
            <tbody>
                <!--
                <tr>
                    <td>Ticket Number</td>
                    <td>Status</td>
                </tr>
                -->
                <asp:Literal ID="LitRows" runat="server"></asp:Literal>
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
                    <td style="text-align: right">How will you get the money to Greg?<br /><span style="font-size:small">Bank A/c No: 06-0996-0956968-00 please use <b>"Maadi 1/<span class="ticket"></span></b>" as your reference.</span></td>
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
