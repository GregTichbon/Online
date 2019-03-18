<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Odata1.aspx.cs" Inherits="Online.TestAndPlay.Odata1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {   
            $('#btn_get').click(function () {

                $.ajax({
                    url: "http://www.odata.charities.govt.nz/Organisations?$filter=CharityRegistrationNumber eq 'CC49050'",
                    contentType: 'application/xml; charset=utf-8',
                    type: 'GET',
                    dataType: 'XMLP',
                    error: function (xhr, status) {
                        alert(status);
                    },
                    success: function (result) {
                        console.log(result);
                        //TODO: Display the result
                    }
                });

                /*
                $.getJSON(url, function (results) {
                    $('#list').text("");
                    $.each(results.d, function (i, item) {
                        $('#list').append("<li>" + item.name + "<br/><br/></li>");
                    });
                });
                */
            });


        })
        </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <input id="btn_get" type="button" value="Get" />
    <ul id="list"></ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
