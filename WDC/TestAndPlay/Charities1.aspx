<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Charities1.aspx.cs" Inherits="Online.TestAndPlay.Charities1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">

        $(document).ready(function () {

            $('#btn_submit').click(function () {
               /*
                $.ajax({
                    dataType: 'json', // what type of data do we expect back from the server
                    url: "http://www.odata.charities.govt.nz/Organisations?$filter=CharityRegistrationNumber%20eq%20%27CC11221%27&$format=json", success: function (result) {
                        alert('here');
                        //filestable = $.parseJSON(result.message)
                        //alert(filestable);
                    }
                });
              */
                /*
                $.getJSON("http://www.w3schools.com/jquery/demo_ajax_json.js", function (result) {
                    alert('here');
                    $.each(result, function (i, field) {
                        $("div").append(field + " ");
                    });
                });
                */

                $.ajax({
                    type: "GET",
                    url: "http://www.w3schools.com/jquery/demo_ajax_json.js",
                    dataType: "jsonp",
                    success: function (data) {
                        alert('here');
                    }
                });

            });
        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form-group">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
            <input type="button" id="btn_submit" class="btn btn-info submit" value="Save" />
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
