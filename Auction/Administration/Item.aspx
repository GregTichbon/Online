<%@ Page Title="" Language="C#" MasterPageFile="~/Auction.Master" AutoEventWireup="true" CodeBehind="Item.aspx.cs" Inherits="Auction.Administration.Item" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src='//cdn.tinymce.com/4/tinymce.min.js'></script>
    <script>
        tinymce.init({
            selector: '#Description',
            plugins: "code paste",
            menubar: "tools edit format view",
            paste_as_text: true
        });

        $(document).ready(function () {

            var donorctr = $('#table_donor tr').length - 1;

            $('#add').click(function () {
                var $tr = $('#table_template tr:first');
                var $clone = $tr.clone();
                donorctr = donorctr + 1;
                $clone = $clone.repeater_changer(donorctr);
                $('#table_donor tr:last').after($clone);

            });
            $('.delete').click(function () {
                $(this).closest('tr').remove();
            });



            var fixHelperModified = function (e, tr) {
                //alert('here');
                var $originals = tr.children();
                var $helper = tr.clone();
                $helper.children().each(function (index) {
                    $(this).width($originals.eq(index).width())
                });
                return $helper;
            },
                updateIndex = function (e, ui) {
                    //$('td.index', ui.item.parent()).each(function (i) {
                    //alert($(this).attr("id"));
                    //$(this).html(i + 1);
                    //});
                };

            $("#table_donor tbody").sortable({
                helper: fixHelperModified,
                stop: updateIndex
            });

            //$('#submit').click(function () {
            //$( window ).unload(function() {
            //	$('[name^="_donor_"]').val(function(i, v) { //index, current value
            //		return v.replace(/,/g,"\b");
            //	});
            //});
            //window.addEventListener("beforeunload", function(event) {
            //	alert("Write something clever here..");
            //});
        });

        function checkform() {
            var msg = ''
            var delim = ''
            var frm = document.form1;

            if (frm.Title.value == '') {
                msg = msg + delim + ' - Title';
                delim = '\n';
            }
            //alert(frm.AuctionType.Index);
            if (frm.AuctionType.Index == 0) {
                msg = msg + delim + ' - Auction Type';
                delim = '\n';
            }
            if (msg != '') {
                alert('You must enter:\n' + msg);
                return (false);
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <input name="id" id="id" type="hidden" value="<%=item_ctr%>" />
    <input name="_all" id="_all" type="hidden" value="All" />
    <table class="table">
        <tr>
            <td>Title</td>
            <td>
                <input type="text" name="Title" id="Title" value="<%=title%>" /></td>
        </tr>
        <tr>
            <td>Description</td>
            <td>
                <textarea name="Description" id="Description"><%=description%></textarea>
                <code style="width: 400px"><%=description%></code>
            </td>
        </tr>


        <tr>
            <td>Type</td>
            <td>
                <select name="AuctionType" id="AuctionType" size="1">
                    <option value="">Please Select</option>
                    <%=General.Functions.Functions.populateselect(auctiontype_values, auctiontype, "None")%>
                </select>
            </td>
        </tr>
        <tr>
            <td>Reserve</td>
            <td>
                <input type="text" name="Reserve" id="Reserve" value="<%=reserve%>" />
            </td>
        </tr>
        <tr>
            <td>Retail Price</td>
            <td>
                <input type="text" name="RetailPrice" id="RetailPrice" value="<%=retailprice%>" /></td>
        </tr>
        <tr>
            <td>Image(s)</td>
            <td>
                <input type="file" multiple="multiple" name="file" /></td>
        </tr>
                <%=images %>

        <tr>
            <td>Sequence</td>
            <td>
                <input type="text" name="seq" id="seq" value="<%=seq%>" /></td>
        </tr>
        <tr>
            <td>Hide</td>
            <td>
                <select name="hide" id="hide" size="1">
                    <option value="">Please Select</option>
                    <%=General.Functions.Functions.populateselect(yesno_values, hide, "None")%>
                </select>
        </tr>
        <tr>
            <td colspan="2">Donors (Drag & Drop to change order)<br />
                <table id="table_donor" class="table">
                    <thead>
                        <tr>
                            <th>Donor</th>
                            <th>Amount</th>
                            <th><a id="add">Add</a></th>
                        </tr>
                    </thead>

                    <%=get_donors(item_ctr) %>
                </table>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>
                <input type="submit" id="submit" name="_Submit" value="Submit" /></td>
        </tr>
    </table>




    <%
/*
folder = Server.MapPath("..\images\items\" & id)
Set fso = Server.CreateObject("Scripting.FileSystemObject")
If fso.FolderExists(folder) = True Then
    response.write "<table><tr>"
    Set fsoFolder = fso.GetFolder(folder)
    For Each fsoFile In fsoFolder.Files
        Response.Write "<td><img src=""../images/items/" & id & "/" & fsoFile.Name & """ height=""160"" border=""0"" alt=""" & fsoFile.Name & """><br />Delete <input name=""_imgdelete_" & fsoFile.Name & """ type=""checkbox"" id=""_imgdelete_" & fsoFile.Name & """ value=""-1""></td>"
    Next
    response.write "</table>"
End If
Set fso=nothing
Set fsoFolder=nothing
*/

    %>


    <table id="table_template" style="display: none">
        <tr>
            <td class="index">
                <input id="_itemdonor_ctr_" name="_itemdonor_ctr_" type="hidden" value="0" />
                <select id="_itemdonor_donor_ctr_" name="_itemdonor_donor_ctr_" size="1">
                    <option value="">Please Select</option>
                    <%
                        int c1 = 0;
                        foreach (string donor_ctr in donor_ctrs)
                        {
                            Response.Write("<option value=\"" + donor_ctr + "\">" + donornames[c1] + "</option>");
                            c1++;

                        }
                    %>
                </select>
            </td>
            <td>
                <input type="text" id="_itemdonor_amount_" name="_itemdonor_amount_" value="0" /></td>
            <td>Delete</td>
        </tr>
    </table>


    <%
        /*
        set rs = nothing	
        db.close	
        set db = nothing
        */
    %>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
