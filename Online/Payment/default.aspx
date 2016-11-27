<%@ Page Title="Whanganui District Council Payment" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="Online.Payment._default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

#datacom-payment-screen label {
	width: 145px;
	display: inline-block;
	text-align: left;
	margin-right: 8px;
}


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <table>
        <tr>
            <td>Payment Reference</td>
            <td>
                <asp:Label ID="lbl_reference" runat="server"></asp:Label>
            </td>
            <td rowspan="8">
                <a href="http://www.paymentexpress.com/privacypolicy.htm" target="_blank"><img src="https://www.paymentexpress.com/DPS/media/theme/pxlogostackedreg.png" /></a><br />
                <strong>Test cards</strong><br />
                4111111111111111 for Visa<br />
                5431111111111111 for MasterCard<br />
                371111111111114 for Amex<br />
                36000000000008 for Diners.
                <br />
                These can be used with any current expiry<br />
                <br />
                Expired Card (ReCo 54) - 4999999999999996<br />
                Card with Insufficient Funds (ReCo 51) - 5431111111111228<br />
                Timeout (ReCo U9) - 4999999999999202<br />
                <br />
                Using the card number 4999999999999202 will result in a declined transaction and set the retry flag to &quot;1&quot; for interfaces that support it.<br />
                <br />
                4999999999999236 - ReCo 05<br />
                4999999999999269 - ReCo 12<br />
                5431111111111301 - ReCo 30<br />
                5431111111111228 - ReCo 51<br />
                <br />
               <a href="http://www.paymentexpress.com/Technical_Resources/Ecommerce_NonHosted/PxPost"> http://www.paymentexpress.com/Technical_Resources/Ecommerce_NonHosted/PxPost</a>
                <br />
                <a href="http://www.paymentexpress.com/knowledge_base/faq/developer_faq.html">http://www.paymentexpress.com/knowledge_base/faq/developer_faq.html</a>
                <br />
            </td>
        </tr>
        <tr>
            <td>Detail</td>
            <td>
                <asp:Label ID="lbl_detail" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>Card Number</td>
            <td>
                <asp:TextBox ID="tb_cardnumber" runat="server" MaxLength="16"></asp:TextBox>

            </td>
        </tr>
        <tr>
            <td>Card Holder&#39;s Name</td>
            <td>
                <asp:TextBox ID="tb_cardholder" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="tb_cardholder" ErrorMessage="Required"></asp:RequiredFieldValidator>

            </td>
        </tr>
        <tr>
            <td>Card Expiry Date</td>
            <td>
                <asp:DropDownList ID="ddl_expirymonth" runat="server">
                    <asp:ListItem>Month</asp:ListItem>
                    <asp:ListItem Value="01">Jan</asp:ListItem>
                    <asp:ListItem Value="02">Feb</asp:ListItem>
                    <asp:ListItem Value="03">Mar</asp:ListItem>
                    <asp:ListItem Value="04">Apr</asp:ListItem>
                    <asp:ListItem Value="05">May</asp:ListItem>
                    <asp:ListItem Value="06">Jun</asp:ListItem>
                    <asp:ListItem Value="07">Jul</asp:ListItem>
                    <asp:ListItem Value="08">Aug</asp:ListItem>
                    <asp:ListItem Value="09">Sep</asp:ListItem>
                    <asp:ListItem Value="10">Oct</asp:ListItem>
                    <asp:ListItem Value="11">Nov</asp:ListItem>
                    <asp:ListItem Value="12">Dec</asp:ListItem>
                </asp:DropDownList>
                <asp:DropDownList ID="ddl_expiryyear" runat="server">
                    <asp:ListItem>Year</asp:ListItem>
                    <asp:ListItem Value="15">2015</asp:ListItem>
                    <asp:ListItem Value="16">2016</asp:ListItem>
                    <asp:ListItem Value="17">2017</asp:ListItem>
                    <asp:ListItem Value="18">2018</asp:ListItem>
                    <asp:ListItem Value="19">2019</asp:ListItem>
                    <asp:ListItem Value="20">2020</asp:ListItem>
                </asp:DropDownList>
                <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Required"></asp:CustomValidator>
            </td>
        </tr>
        <tr>
            <td>
                <label for="cardSecureId">
                CSC/CVV/CVV2</label></td>
            <td>
                <asp:TextBox ID="tb_secureid" runat="server" MaxLength="3"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="tb_secureid" ErrorMessage="Required"></asp:RequiredFieldValidator>

            </td>
        </tr>
        <tr>
            <td>
                <label id="lbl_AmountWording">
                Amount
                </label>
            </td>
            <td>
                <asp:Label ID="lbl_amount" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:Button ID="btn_pay" runat="server" OnClick="btn_pay_Click" Text="Pay" />
            </td>
        </tr>
    </table>

    <table class="ProgrammeTable">
        <tr>
            <td>Reco</td>
            <td><asp:Label ID="lbl_reco" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td>ResponseText</td>
            <td>
    <asp:Label ID="lbl_responsetext" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td>HelpText</td>
            <td>
    <asp:Label ID="lbl_helptext" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td>Authorised</td>
            <td>
    <asp:Label ID="lbl_authorized" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td>DPSTxRef</td>
            <td>
    <asp:Label ID="lbl_dpstxnref" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td>AuthCode</td>
            <td>
    <asp:Label ID="lbl_authcode" runat="server" Text=""></asp:Label>

            </td>
        </tr>
    </table>

    &nbsp;<br />
    <asp:Label ID="lbl_todo" runat="server"></asp:Label>

    <br />
    <br />
    <br />
    <br />

    <br />
    
</asp:Content>
