<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ajaxpost1.aspx.cs" Inherits="Online.TestAndPlay.jaxpost1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/json2/20150503/json2.min.js"></script>


    <script type="text/javascript">
        $(document).ready(function () {
            //alert('loaded');


            $("#form1").submit(function (event) {
     
                alert('submit');

                // Stop form from submitting normally
                event.preventDefault();

                var formData1 = {
                    'name': 'Greg',
                    'email': 'greg@datainn.co.nz'
                };

                
                var arForm = $("#form1").serializeArray()

                // process the form
                $.ajax({
                    type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                    url: '../functions/data.asmx/Test4', // the url where we want to POST
                    //data: JSON.stringify({ formVars: arForm }), // our data object
                    data: formData1,
                    dataType: 'json', // what type of data do we expect back from the server
                    encode: true
                })
                 // using the done promise callback
                 .done(function (data) {

                     // log data to the console so we can see
                     alert(data);

                     // here we will handle errors and validation messages
                     if (!data.success) {

                         // handle errors for name ---------------
                         if (data.errors.name) {
                             alert(data.errors.name);
                         }

                         // handle errors for email ---------------
                         if (data.errors.email) {
                             alert(data.errors.email);
                         }

                     } else {

                         // ALL GOOD! just show the success message!
                         alert(data.message);

                         // usually after form submission, you'll want to redirect
                         // window.location = '/thank-you'; // redirect a user to another page
                         alert('success'); // for now we'll just alert the user

                     }
                 });

                // stop the form from submitting the normal way and refreshing the page
                event.preventDefault();
            });
        });


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<asp:ScriptManager ID="scm" runat="server" EnablePageMethods="true" />
    <input id="Text1" name="Text1" type="text" value="1111111" />
    <input id="Text2" name="Text2" type="text" value="2222222" />
    <input id="Button1" type="submit" value="button" />



</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
