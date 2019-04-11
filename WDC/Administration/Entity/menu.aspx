<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="menu.aspx.cs" Inherits="Online.Administration.Entity.menu" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">

        var system = "WDC";
        var autocomplete_source = "../../functions/data.asmx/EntitySearch?mode=name&system=";

        $(document).ready(function () {


            $('#cb_nonwdc').change(function () {
                if ($('#cb_nonwdc').prop("checked")) {
                    system = ""
                } else {
                    system = "WDC"
                }
                $("#tb_name").autocomplete('option', 'source', autocomplete_source + system);

            });

            $("#tb_name").autocomplete({
                source: "../../functions/data.asmx/EntitySearch?mode=name&system=" + system,
                minLength: 3,
                select: function (event, ui) {
                    event.preventDefault();
                    entity = ui.item;
                    if (entity) {
                        window.location = "entitywdc.aspx?reference=" + entity.reference;
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

            $('#btn_create').click(function () {
                window.location.href = "EntityWDC.aspx?create=1";
            });

        }); //document.ready
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Entity Maintenance 
    </h1>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_name">
            Search -
            Enter the name:
            
            <img src="../../Images/questionsmall.png" title="Start typing the surname and/or forename(s)"><br />Include non-WDC Entities: <input type="checkbox" id="cb_nonwdc" value="1"/></label>
        <div class="col-sm-8">
            <input type="text" id="tb_name" class="form-control" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4"></label>
            
        <div class="col-sm-8">
            <button type="button" class="btn btn-info" id="btn_create">Create</button>
        </div>
    </div>

        <div class="form-group">
        <label class="control-label col-sm-4"></label>
            
        <div class="col-sm-8">
            <button type="button" class="btn btn-info" id="btn_mydetails">My Details</button>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>