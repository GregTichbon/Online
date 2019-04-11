<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EntitySearch.aspx.cs" Inherits="Online.Administration.EntitySearch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $("#tb_name").autocomplete({
                source: "../functions/data.asmx/EntitySearch?mode=name",
                minLength: 3,
                select: function (event, ui) {
                    event.preventDefault();
                    entity = ui.item;
                    if (entity) {
                        window.location = "../entity/entity.aspx?reference=" + entity.reference;
                        //$("#tb_name").val(entity.label);
                    } else {
                        alert('Not found');
                    }
                },
                open: function (event, ui) {
                    if (navigator.userAgent.match(/iPad/)) {
                        // alert(1);
                        $('.autocomplete').off('menufocus hover mouseover');
                    }
                },

            })
            .autocomplete("instance")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "<br />" + item.residentialaddress + "</a>")
                    .appendTo(ul);
            };
        }); //document.ready
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Entity Search 
    </h1>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_namer">
            Enter the name:
            <img src="../Images/questionsmall.png" title="Start typing the surname and/or forename(s)"></label>
        <div class="col-sm-8">
            <input type="text" id="tb_name" class="form-control" />
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
