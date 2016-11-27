<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TestPost1.aspx.cs" Inherits="Online.CommunityContract.TestPost1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
       <script type="text/javascript">

           $(document).ready(function () {

               $('#test').on('click', function (e) {
                   savefields()
               });

               function savefields() {
                   var arForm = $("#form1")
                       .find("input,textarea,select,hidden")
                       .not("[id^='__']")
                       //.not("[id^='cb_deletefile_additional_']")
                       .serializeArray();


                   var formData = JSON.stringify({ formVars: arForm });
                   //alert(formData);

                   $.ajax({
                       type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                       async: false,
                       contentType: "application/json; charset=utf-8",
                       url: 'posts.asmx/application', // the url where we want to POST
                       data: formData,
                       dataType: 'json', // what type of data do we expect back from the server
                       success: function (result) {
                           //alert(result);
                           $('.form_result').html('Saved');
                           //details = $.parseJSON(result.d);
                           //alert(details.status);
                       },
                       error: function (xhr, status) {
                           alert("An error occurred: " + status);
                       }

                   })
               }

  



        });
        



    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="form_result"> </div>
    <input id="text1" name="test1" type="text" value="xxxxxxxx" />

          <input type="button" id="test" value="Test" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
