<%@ Page Title="" Language="C#" MasterPageFile="~/TOHW.Master" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="TOHW.Pickups.login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        #centred {
            position: fixed;
            width: 30%; /* Set your desired with */
            z-index: 2; /* Make sure its above other items. */
            top: 50%;
            left: 50%;
            margin-top: -10%; /* Changes with height. */
            margin-left: -15%; /* Your width divided by 2. */
            /* You will not need the below, its only for styling   purposes. */
            padding: 10px;
            border: 2px solid #555555;
            background-color: #ccc;
            border-radius: 5px;
            text-align: center;
        }

        td, input {
            font-size: 32px;
        }
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>

    <script type="text/javascript">
    $(document).ready(function () {
        $('.tb_name').val(document.cookie);
        $('.submit').click(function() {
           document.cookie = $('.tb_name').val();
        });
    });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="centred">
        <table>
            <tr>
                <td style="text-align: right">Name: </td>
                <td>
                    <asp:TextBox ID="tb_name" class="tb_name" runat="server" Style="width:100%"></asp:TextBox></td>
            </tr>
            <tr>
                <td style="text-align: right">Password: </td>
                <td>
                    <asp:TextBox ID="tb_password" runat="server" TextMode="Password" Style="width:100%"></asp:TextBox></td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <asp:Button ID="Button1" class="submit" runat="server" Text="Submit" OnClick="btn_submit_Click" Style="width:100%" /></td>
            </tr>
        </table>


    </div>

</asp:Content>
