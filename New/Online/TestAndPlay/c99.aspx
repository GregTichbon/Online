<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="c99.aspx.cs" Inherits="Online.TestAndPlay.c99" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">


        $(document).ready(function () {



            $(".prioruse_autocomplete").autocomplete({
                source: function (request, response) {
                    $.getJSON('/functions/data.asmx/PriorUse', {
                        fieldname: $('#' + this.element[0].id).data('prioruse'),    //'cemeteries|estate|minister',
                        'term': request.term
                    }, response);
                },
                minLength: 3,
                select: function (event, ui) {
                    event.preventDefault();
                    myitem = ui.item;
                    alert(myitem.label.length);
                    $("#" + this.id).val(ui.item ?
                        myitem.label.replace(/,/g, "\r\n") : "Nothing selected, input was " + this.value);
                }
            })


            $(".xxxprioruse_autocomplete").autocomplete({
                source: function (request, response) {
                    //alert('source');
                    //alert(request.term);
                    $.ajax({
                        URL: 'functions/data.asmx/PriorUse',
                        dataType: 'json',
                        data: {
                            fieldname: 'cemeteries|estate|minister',
                            term: request.term
                        },
                        success: function (data) {
                            alert('success');
                            response(data);
                        }
                    });
                },
                minLength: 3,
                select: function (event, ui) {
                    event.preventDefault();
                    address = ui.item;
                    $("#" + this.id).val(ui.item ?
                        address.label.replace(/,/g, "\r\n") : "Nothing selected, input was " + this.value);
                }
            })



            $(".xxxprioruse_autocomplete").autocomplete({
                source: "../functions/data.asmx/PriorUse?fieldname=cemeteries|estate|minister" + $(this).attr("id"),
                minLength: 3,
                select: function (event, ui) {
                    event.preventDefault();
                    address = ui.item;
                    alert(this.id);
                    $('#' + this.id).val(ui.item ?
                        address.label.replace(/,/g, "\r\n") : "Nothing selected, input was " + this.value);
                }
            })

        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_minister">Minister</label>
        <div class="col-sm-8">
            <input id="tb_minister" name="tb_minister" type="text" class="form-control prioruse_autocomplete" data-prioruse="cemeteries|estate|minister" required />
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
