<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UBC2019AWinner.aspx.cs" Inherits="DataInnovations.Raffles.UBC2019AWinner" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">


    <title>Union Boat Club Rowing Fundraiser - Winner</title>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
    <style>
        body {
            font-family: Arial;
            font-size: 18px;
        }

        #tableselection td {
            font-size: 16px;
            padding: 5px;
        }

        #tabledetails td {
            padding: 10px;
        }


        #btn_submit {
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
            font-size: 24px;
            padding: 6px 12px 6px 12px;
            text-decoration: none;
        }

            #btn_submit:hover {
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
            background-color: #FFFF66;
        }

        .auto-style2 {
            background-color: #99FF66;
        }

        .auto-style3 {
            background-color: #FFCBB3;
        }

        .auto-style4 {
            background-color: #FFCBB3;
            font-weight: bold;
        }

        .auto-style5 {
            background-color: #99FF66;
            font-weight: bold;
        }

        .auto-style6 {
            background-color: #FFFF66;
            font-weight: bold;
        }
    </style>



    <script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <script src="http://datainn.co.nz/javascript/jquery.validate.min.js"></script>


    <script type="text/javascript">


        $(document).ready(function () {

            var selections = "<% = winnerresponse %>";
            var selection = selections.split(',');

            for (var f1 = 0; f1 < selection.length; f1++) {
                $('input:checkbox[value="' + selection[f1] + '"]').prop('checked', true);
                //alert(selection[f1]);
            }



            $("#form1").validate({ // initialize the plugin
                rules: {
                    'selection': {
                        required: true,
                        maxlength: 2
                    }
                },
                messages: {
                    'selection': {
                        required: "You must select 1 or 2 options",
                        maxlength: "You must select 1 or {0} options"
                    }
                },
                errorPlacement: function (error, element) {
                    if (element.attr("name") == "selection") {
                        error.appendTo("#selecterror");
                    } else {
                        error.insertAfter(element);
                    }
                }
            });
            /*
            $('input:checkbox').click(function () {
                if ($('input:checkbox').filter(':checked').length > 2) {
                    $(this).prop('checked', false);
                    alert('Sorry, you can only choose 1 or 2 options.');
                };
            });
            */







        }); //document.ready
    </script>
</head>
<body style="background-color: peru">
    <form id="form1" runat="server">
        <input type="hidden" name="hf_guid" value="<%=guid %>" />
        <div style="width: 770px; margin: 0 auto; padding: 20px; background-color: aquamarine">
            <p style="text-align: center">
                <img alt="" style="width: 654px" src="Images/ChefsChoice%20Logo.PNG" />
            </p>
            <p style="text-align: left">
                Hi <%= greeting %>
            </p>
            <p style="text-align: left">
                Thanks for supporting our recent rowing trips The North Island School Champs and Maadi Cup by taking a raffle ticket.  You are a WINNER!!!!!&nbsp;&nbsp; Now it&#39;s time to claim your prize.
            </p>
            <p style="text-align: left">
                Please select from 1 or 2 of the meat selections below and we&#39;ll get it ordered and then arrange a time and place for you to pick it up.&nbsp; Normally from the Union Boat Club rooms at 1C Taupo Quay between 5:00 and 5:30pm.
            </p>
            <p style="text-align: left">
                Please feel free to contact greg on 0272495088 if you have any questions.
            </p>
            <p style="text-align: left">
                Thanks once again.&nbsp; Enjoy the great meat from the selection below from Chef&#39;s Choice.
            </p>
            <hr />
            <table id="tableselection" style="width: 100%; border-collapse: collapse;">
                <tr>
                    <td colspan="2" style="width: 33%; text-align: center;" class="auto-style6">Beef</td>
                    <td colspan="2" style="width: 34%; text-align: center;" class="auto-style5">Lamb</td>
                    <td colspan="2" style="width: 33%; text-align: center;" class="auto-style4">Pork</td>
                </tr>
                <tr>
                    <td class="auto-style1">
                        <input name="selection" type="checkbox" value="Sirloin Steak" /></td>
                    <td class="auto-style1">Sirloin Steak</td>
                    <td class="auto-style2">
                        <input name="selection" type="checkbox" value="Lamb Leg" /></td>
                    <td class="auto-style2">Lamb Leg</td>
                    <td class="auto-style3">
                        <input name="selection" type="checkbox" value="Pork Loin Chops" /></td>
                    <td class="auto-style3">Pork Loin Chops</td>
                </tr>
                <tr>
                    <td class="auto-style1">
                        <input name="selection" type="checkbox" value="Rump Steak" /></td>
                    <td class="auto-style1">Rump Steak</td>
                    <td class="auto-style2">
                        <input name="selection" type="checkbox" value="Lamb Rump (4per pack)" /></td>
                    <td class="auto-style2">Lamb Rump (4per pack)</td>
                    <td class="auto-style3">
                        <input name="selection" type="checkbox" value="Pork Boneless Shoulder" /></td>
                    <td class="auto-style3">Pork Boneless Shoulder</td>
                </tr>
                <tr>
                    <td class="auto-style1">
                        <input name="selection" type="checkbox" value="Eye Fillet Steak" /></td>
                    <td class="auto-style1">Eye Fillet Steak</td>
                    <td class="auto-style2">
                        <input name="selection" type="checkbox" value=" Lamb Rack" /></td>
                    <td class="auto-style2">Lamb Rack</td>
                    <td class="auto-style3">
                        <input name="selection" type="checkbox" value="Pork Boneless Leg" /></td>
                    <td class="auto-style3">Pork Boneless Leg</td>
                </tr>
                <tr>
                    <td class="auto-style1">
                        <input name="selection" type="checkbox" value="Scotch Fillet Steak" /></td>
                    <td class="auto-style1">Scotch Fillet Steak</td>
                    <td class="auto-style2">
                        <input name="selection" type="checkbox" value="Boneless Lamb Shoulder 1/2" /></td>
                    <td class="auto-style2">Boneless Lamb Shoulder &frac12;</td>
                    <td class="auto-style3">
                        <input name="selection" type="checkbox" value="Pork Stir-fry" /></td>
                    <td class="auto-style3">Pork Stir-fry</td>
                </tr>
                <tr>
                    <td class="auto-style1">
                        <input name="selection" type="checkbox" value="Stir-fry" /></td>
                    <td class="auto-style1">Stir-fry</td>
                    <td class="auto-style2">
                        <input name="selection" type="checkbox" value="Diced Lamb" /></td>
                    <td class="auto-style2">Diced Lamb</td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="auto-style1">
                        <input name="selection" type="checkbox" value="Beef Schnitzel" /></td>
                    <td class="auto-style1">Beef Schnitzel</td>
                    <td class="auto-style2">
                        <input name="selection" type="checkbox" value="Lamb Stir-fry" /></td>
                    <td class="auto-style2">Lamb Stir-fry</td>
                    <td>&nbsp;</td>
                    <td></td>
                </tr>
                <tr>
                    <td class="auto-style1">
                        <input name="selection" type="checkbox" value="Premium Mince" /></td>
                    <td class="auto-style1">Premium Mince</td>
                    <td class="auto-style2">
                        <input name="selection" type="checkbox" value="Lamb Loin Chops" /></td>
                    <td class="auto-style2">Lamb Loin Chops</td>
                    <td>&nbsp;</td>
                    <td></td>
                </tr>
                <tr>
                    <td class="auto-style1">
                        <input name="selection" type="checkbox" value="Diced Beef" /></td>
                    <td class="auto-style1">Diced Beef</td>
                    <td class="auto-style2">
                        <input name="selection" type="checkbox" value="Lamb Shoulder Chops" /></td>
                    <td class="auto-style2">Lamb Shoulder Chops</td>
                    <td>&nbsp;</td>
                    <td></td>
                </tr>
                <tr>
                    <td class="auto-style1">
                        <input name="selection" type="checkbox" value="Corned Silverside" /></td>
                    <td class="auto-style1">Corned Silverside</td>
                    <td class="auto-style2">
                        <input name="selection" type="checkbox" value="Lamb Shanks" /></td>
                    <td class="auto-style2">Lamb Shanks</td>
                    <td>&nbsp;</td>
                    <td></td>
                </tr>
                <tr>
                    <td class="auto-style1">
                        <input name="selection" type="checkbox" value="Whole Sirloin" /></td>
                    <td class="auto-style1">Whole Sirloin</td>
                    <td></td>
                    <td></td>
                    <td>&nbsp;</td>
                    <td></td>
                </tr>
                <tr>
                    <td class="auto-style1">
                        <input name="selection" type="checkbox" value="Whole Scotch" /></td>
                    <td class="auto-style1">Whole Scotch</td>
                    <td>&nbsp;</td>
                    <td></td>
                    <td>&nbsp;</td>
                    <td></td>
                </tr>

            </table>
            <p id="selecterror" style="width: 100%; text-align: center"></p>

            <hr />
            <table id="tabledetails" style="width: 100%;">
                <tr>
                    <td style="text-align: right; width: 30%">Ticket Number:</td>
                    <td><%= ticketnumber %></td>
                </tr>
                <tr>
                    <td style="text-align: right">Your name:</td>
                    <td style="text-align: left">
                        <input type="text" id="tb_name" name="tb_name" required="required" value="<%= name %>" /></td>
                </tr>
                <tr>
                    <td style="text-align: right">Email Address:</td>
                    <td style="text-align: left">
                        <input type="email" id="tb_emailaddress" name="tb_emailaddress" autocomplete="on" value="<%= email %>" /></td>
                </tr>
                <tr>
                    <td style="text-align: right">Mobile Number:</td>
                    <td style="text-align: left">
                        <input type="tel" id="tb_mobile" name="tb_mobile" required="required" autocomplete="on" value="<%= mobile %>" /></td>
                </tr>

                <tr>
                    <td style="text-align: right">Comments:</td>
                    <td style="text-align: left">
                        <textarea id="tb_comments" name="tb_comments"><%= winnernote %></textarea></td>
                </tr>

            </table>

            <p style="text-align: center">
                <asp:Button ID="btn_submit" runat="server" Text="Place your selection" OnClick="btn_submit_Click" />
            </p>

            <hr />

            <br />
            <img src="Images/3logos.jpg" style="width: 770px;" />
        </div>
    </form>
</body>
</html>
