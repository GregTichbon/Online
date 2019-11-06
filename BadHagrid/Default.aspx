<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BadHagrid.Default" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Bad Hagrid</title>

    <!-- Style Sheets -->
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />

    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
    <script src="<%: ResolveUrl("~/Dependencies/jquery.validate.min.js")%>"></script>
    <script type="text/javascript" src="<%: ResolveUrl("~/dependencies/downcount/jquery.downCount.js")%>"></script>


    <style type="text/css">
        @import url(http://fonts.googleapis.com/css?family=Open+Sans:300,400);
       
        .input {
            width: 100%;
            padding: 10px;
            margin-top: 10px;
            margin-bottom: 10px;
            box-sizing: border-box;
        }

        #signup {
            padding: 10px;

        }

        #submit {
            padding: 10px;
            width: 100%;
            margin-top:10px;
        }

        body {
            background: #363f48;
            color: white;
            font: normal 20px 'Open Sans', sans-serif;
            margin-top: 20px;
            background-image: url(BadHagrid.svg);
            background-repeat: repeat;
        }

        ul.countdown {
            list-style: none;
            margin: 75px 0;
            padding: 0;
            display: block;
            text-align: center;
        }

            ul.countdown li {
                display: inline-block;
            }

                ul.countdown li span {
                    font-size: 50px;
                    font-weight: 300;
                    line-height: 50px;
                }

                ul.countdown li.seperator {
                    font-size: 50px;
                    line-height: 45px;
                    vertical-align: top;
                }

                ul.countdown li p {
                    color: #a7abb1;
                    font-size: 14px;
                }

        .signup {
            text-align: center;
            font-size: xx-large;
        }

        #keen {
            padding: 10px;
            font-size: 20px;
        }

        label.error {
            display:block;
            color: #a94442;
            font-size:medium;
            text-align:left;
            margin-top:-10px;
        }
    </style>
    <script>
        $(document).ready(function () {

            if ("<%:response%>" != "") {
                $('#dialog_result').html('<%:response%>');
                $('#dialog_result').dialog({
                    modal: true,
                    width: 400,
                    title: "Sign up",
                    closeText: false
                });
            }

       
            $('.countdown').downCount({
                date: '11/04/2019 12:00:00',
                offset: +13
            }, function () {
                window.open("http://badhagrid.com/new.aspx","_self" );
                
            })
        

            $("#form1").validate({
                rules: {
                    emailaddress: {
                        required: '#mobilenumber:blank'
                    },
                    mobilenumber: {
                        required: '#emailaddress:blank'
                    }
                },
                messages: {
                    emailaddress: {
                        required: "Either an email address"
                    },
                    mobilenumber: {
                        required: "or a mobile phone number are required"
                    },
                    name: {
                        required: "A name is required"
                    }
                }
            });


            $("#keen").click(function () {
                $('#dialog_signup').dialog({
                    modal: true,
                    width: 400,
                    title: "Sign up",
                    closeText: false,
                    open: function () {
                        $(this).parent().appendTo($('#form1'));
                    }
                });
            });

            $('#submit').click(function () {
                if ($("#form1").valid()) {
                    $('#dialog_signup').dialog('close');
                    var arForm = [{ "name": "name", "value": $('#name').val() }, { "name": "emailaddress", "value": $('#emailaddress').val() }, { "name": "mobilenumber", "value": $('#mobilenumber').val() }];
                    var formData = JSON.stringify({ formVars: arForm });
                    $.ajax({
                        type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                        contentType: "application/json; charset=utf-8",
                        url: 'posts.asmx/Update_BadHagrid', // the url where we want to POST
                        data: formData,
                        dataType: 'json', // what type of data do we expect back from the server
                        success: function (result) {
                            $('#dialog_result').html('Thanks, we\'ve sent a link to you to confirm it, please simply click on the link and we will notify you as "stuff" happens.');
                            $('#dialog_result').dialog({
                                modal: true,
                                width: 400,
                                title: "Sign up",
                                closeText: false
                            });
                        },
                        error: function (xhr, status) {
                            $('#dialog_result').html('Sorry, an error of some sort happened.  Would you please try again');
                            $('#dialog_result').dialog({
                                modal: true,
                                width: 400,
                                title: "Sign up",
                                closeText: false
                            });
                            
                        }
                    });
                };
            });



        });  //document.ready
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <ul class="countdown">
            <li>
                <span class="days">00</span>
                <p class="days_ref">days</p>
            </li>
            <li class="seperator">.</li>
            <li>
                <span class="hours">00</span>
                <p class="hours_ref">hours</p>
            </li>
            <li class="seperator">:</li>
            <li>
                <span class="minutes">00</span>
                <p class="minutes_ref">minutes</p>
            </li>
            <li class="seperator">:</li>
            <li>
                <span class="seconds">00</span>
                <p class="seconds_ref">seconds</p>
            </li>
        </ul>

    

        <div id="signup" class="signup">
            Give us your details and we&#39;ll keep you notified<br />
            <button id="keen" type="button">I'm keen</button>
        </div>

        <div id="dialog_signup" style="display: none; text-align: center">
            <input class="input" type="text" id="name" name="name" placeholder="Name" required />
            <input class="input" type="email" id="emailaddress" name="emailaddress" placeholder="Email Address" />
            <input class="input" type="tel" id="mobilenumber" name="mobilenumber" placeholder="Mobile Phone Number" />
            <input id="submit" type="button" value="Submit" />
        </div>

        <div id="dialog_result" style="display: none" class="signup">
            
        </div>



    </form>
</body>
</html>



