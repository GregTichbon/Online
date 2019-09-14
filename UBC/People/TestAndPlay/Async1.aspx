<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Async1.aspx.cs" Inherits="UBC.People.TestAndPlay.Async1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
    <script>

        $(document).ready(function () {
            $('#btn_submit').click(function (e) {
                e.preventDefault();
                //$("#tbl_results > tbody").empty();
                /*
                $('#dialog_sending').dialog({
                    modal: true,
                    width: ($(window).width() - 0) * .95,  //75 x 2 is the width of the question mark top right
                    height: 600, //auto
                    position: { my: "center", at: "100", of: window }
                });
                */
               
               // setTimeout(function () {
                    var i;
                    for (i = 0; i < 2; i++) {
                        //test1();
                        /*
                        $.ajax({
                            type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                            contentType: "application/json; charset=utf-8",
                            url: "posts.asmx/test",
                            async: false,
                            //data: formData,
                            dataType: 'json', // what type of data do we expect back from the server
                            success: function (data) {
                                //$('#tbl_results tbody').prepend("<tr><td>" + data.d.status + '</td></tr>');
                                $('#test').prepend(data.d.status);
                            },
                            error: function (XMLHttpRequest, textStatus, error) {
                                alert("AJAX error: " + textStatus + "; " + error);
                            }
                        });
                        */
                        $('#test').prepend(i);
                        alert(1);
                    }
                    //$('#tbl_results tbody').prepend('<tr><td>Complete</td>');
                    $('#test').prepend('Complete');
                //}, 100);
               /*
                setTimeout(function () {
                    $('#test').prepend('1');
                }, 2000);
                setTimeout(function () {
                    $('#test').prepend('2');
                }, 2000);
                 setTimeout(function () {
                    $('#test').prepend('3');
                }, 2000);
                */
            });



        }); //document ready

        function test1() {
            setTimeout(function () {
                $.ajax({
                    type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                    contentType: "application/json; charset=utf-8",
                    url: "posts.asmx/test",
                    async: false,
                    //data: formData,
                    dataType: 'json', // what type of data do we expect back from the server
                    success: function (data) {
                        $('#tbl_results tbody').prepend("<tr><td>" + data.d.status + '</td></tr>');
                    },
                    error: function (XMLHttpRequest, textStatus, error) {
                        alert("AJAX error: " + textStatus + "; " + error);
                    }
                });
            }, 3000);

        }


    </script>
</head>
<body>
    <form id="form1" runat="server">
        <input type="button" id="btn_submit" class="btn btn-info" value="Send" />
        <div id="dialog_sending" title="Sending ..." style="display: none">
        </div>
        <div id="test">
            
            <table id="tbl_results" class="table table-hover">
                <thead>
                    <tr>
                        <th>Result</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
    </form>
</body>
</html>
