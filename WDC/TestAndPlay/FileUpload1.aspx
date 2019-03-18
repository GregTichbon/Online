<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FileUpload1.aspx.cs" Inherits="Online.TestAndPlay.FileUpload1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
       
        $(document).ready(function () {

            $("#Button1").click(function () {
                var data = new FormData();

                var files = $("#f_UploadImage").get(0).files;

                // Add the uploaded image content to the form data collection
                //alert("Number of files: " + files.length);

                for (i = 0; i < files.length; i++) {
                    //alert("Size of " + files[i].name + " = " + files[i].size);
                    data.append("UploadedFile", files[i]);
                }

                var ajaxRequest = $.ajax({
                    type: "POST",
                    url: "../functions/posts.asmx/Upload2",
                    contentType: false,       //This forces it to return XML!
                    //contentType: "application/json; charset=utf-8",
                    processData: false,
                    data: data,
                    dataType: 'text', // what type of data do we expect back from the server
                    success: function (result) {
                        alert(result);
                        var xml = result,
                            xmlDoc = $.parseXML(result),
                            $xml = $(xmlDoc),
                            $message = $xml.find("message");
                        alert($message.text());


                    },
                    error: function (xhr, status) {
                        alert("An error occurred: " + status);
                    }
                });
            });


            $("#Button2").click(function () {
                var arForm = $("#form1")
                    .find("input,textarea,select,hidden")
                    .not("[id^='__']")
                    .serializeArray();


                var formData = JSON.stringify({ formVars: arForm });

                var ajaxRequest = $.ajax({
                    type: "POST",
                    url: "../functions/posts.asmx/Test",
                    contentType: "application/json; charset=utf-8",
                    data: formData,
                    dataType: 'text', // what type of data do we expect back from the server
                    success: function (result) {
                        alert("Success: " + result);
                        //details = $.parseJSON(result.message);
                        //alert(details);
                    },
                    error: function (xhr, status) {
                        alert("An error occurred: " + status);
                    }
                });
            });


            $("#Button3").click(function () {
                var xml = '<?xml version="1.0" encoding="utf-16" ?><standardResponse xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><status>Saved</status><message>Message</message></standardResponse>',
                    xmlDoc = $.parseXML(xml),
                    $xml = $(xmlDoc),
                    $message = $xml.find("message");
                alert($message.text());
            });

 
        });




    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <input type="file" class="upload" name="f_UploadImage" id="f_UploadImage" multiple="multiple"><br />

    <input id="Button1" type="button" value="Button1" />
        <input id="Button2" type="button" value="Button2" />
            <input id="Button3" type="button" value="Button3" />

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
