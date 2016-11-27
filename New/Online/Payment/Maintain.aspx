<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Maintain.aspx.cs" Inherits="Online.Payment.Maintain" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $("#pagehelp").colorbox({ href: "MaintainHelp.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });

            $('body').on('click', '.action_invoice', function () {
                $.ajax({
                    url: "../services/data.asmx/InvoiceDetails?year=" + $("#tb_invoiceyear").val() + "&number=" + $("#tb_invoicenumber").val(), success: function (result) {
                        //invoicedetails = $.parseJSON(result);



                        $('#invoicedetails').html('<table id="chargestable" class="table table-hover table-responsive"></table>');
                        charges = $.parseJSON(result);
                        for (var i = 0, len = charges.length; i < len; ++i) {
                            $("#chargestable").append('<tr id="chargestable' + i + '"></tr>');
                            row = $("#chargestable" + i);
                            for (var key in charges[i]) {
                                //alert(key);
                                buildtds(row, key, charges[i][key]);
                            }
                        }
                    }
                });
            });

            function buildtds(row, label, value) {
                //if (value != '') {
                    row.append('<td>' + value + "</td>");
                //}
            }

        });

  


    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <a id="pagehelp">
        <img id="helpicon" src="http://wdc.whanganui.govt.nz/online/images/question.png" title="Click on me for specific help on this page." /></a>


    <table class="table table-hover table-responsive ">

        <tr>
            <td class="col-md-4 text-right">Module</td>
            <td>
                <asp:TextBox ID="tb_moduledescription" runat="server" ReadOnly="true"></asp:TextBox>
                <asp:HiddenField ID="hf_tablename" runat="server" />
                <asp:HiddenField ID="hf_ctr" runat="server" />
                <asp:HiddenField ID="hf_entity" runat="server" />
                <asp:HiddenField ID="hf_mode" runat="server" />
            </td>
        </tr>

        <tr>
            <td class="col-md-4 text-right">Application reference number</td>
            <td>
                <asp:TextBox ID="tb_reference" runat="server" ReadOnly="true"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="col-md-4 text-right">Detail</td>
            <td>
                <asp:TextBox ID="tb_detail" runat="server" ReadOnly="true"></asp:TextBox>
            </td>
        </tr>
        <asp:Panel ID="PanelMode1" runat="server">
            <tr>
                <td class="col-md-4 text-right">Additional detail</td>
                <td>
                    <asp:TextBox ID="tb_additionaldetail" runat="server"></asp:TextBox>
                </td>
            </tr>

            <tr>
                <td class="col-md-4 text-right">Amount</td>
                <td>
                    <asp:TextBox ID="tb_amount" runat="server"></asp:TextBox>
                </td>
            </tr>
        </asp:Panel>
        <asp:Panel ID="PanelMode2" runat="server">
            <tr>
                <td class="col-md-4 text-right">Invoice Year / Number</td>

                    <td>
                        <input type="text" id="tb_invoiceyear" name="tb_invoiceyear" value="" /> / <input type="text" id="tb_invoicenumber" name="tb_invoicenumber" value="" />
                       
                        <a class="action_invoice">Show</a>
                        <span id="invoicedetails"></span>
                </td>
            </tr>
          
        </asp:Panel>
        <tr>

            <td>&nbsp;</td>
            <td>
                <asp:Button ID="btn_submit" runat="server" Text="Submit" OnClick="btn_submit_Click" />
            </td>
        </tr>
    </table>


</asp:Content>
