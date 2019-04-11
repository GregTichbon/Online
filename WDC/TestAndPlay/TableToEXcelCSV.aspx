<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TableToEXcelCSV.aspx.cs" Inherits="Online.TestAndPlay.TableToEXcelCSV" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <script>
        $(document).ready(function () {
            $('#btn_Save').click(function () {
                //var image = canvas.cropper('getCroppedCanvas').toDataURL("image/jpg");
                //image = image.replace('data:image/png;base64,', '');
                var table = "<table><tr><td>x</td></tr></table>";
                $.ajax({
                    type: "POST",
                    url: "../functions/posts.asmx/TabletoExcelCSV",
                    data: '{"tablestring": "' + table + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (result) {
                        //alert(result);
                        details = $.parseJSON(result.d);
                        alert(details.status);
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert("Status: " + textStatus); alert("Error: " + errorThrown);
                    }
                });
            });
        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <input type="button" id="btn_Save" value="Save" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
