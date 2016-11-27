<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AJAXGetPost1.aspx.cs" Inherits="Online.TestAndPlay.AJAXGetPost1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>




    <script type="text/javascript">
        $(document).ready(function () {
            //alert('loaded');


            $("#form1").submit(function (event) {

                //alert('submit');

                // Stop form from submitting normally
                event.preventDefault();

                var formData;
                /*
                formData = {
                    'name': 'Greg',
                    'email': 'greg@datainn.co.nz'
                };
                formData = {
                    'passdata': 'Greg'
                };

                formData = JSON.stringify($("#form1").serializeArray());
                */
                var arForm = $("#form1").serializeArray();
                formData = JSON.stringify({ formVars: arForm })

                //alert(formData);

                // process the form
                $.ajax({
                    type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                    contentType: "application/json; charset=utf-8",
                    //url: 'functions/datatest.asmx/TestMethodGet', // the url where we want to POST
                    url: '../functions/data.asmx/TestMethodGet', // the url where we want to POST
                    data: {}, //formData,
                    dataType: 'json', // what type of data do we expect back from the server
                    success: function (result) {
                        alert(result.d);
                        details = $.parseJSON(result.d);
                        alert(details.id);
                    },
                    error: function (xhr, status) {
                        alert("An error occurred: " + status);
                    }
                })


            });
        });


    </script>
</head>
<body>
    <form id="form1" runat="server">
    <input id="Text1" name="Text1" type="text" value="1111111" />
    <input id="Text2" name="Text2" type="text" value="2222222" />
    <input id="Button1" type="submit" value="button" />
    </form>
</body>
</html>
