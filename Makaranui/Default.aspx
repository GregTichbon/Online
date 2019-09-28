<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Makaranui.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            background-image: url("images/makaranui1.jpg");
            height: 100%;
            background-position: center;
            background-repeat: no-repeat;
            color: white;
            font-size: xx-large;
            text-align: center;
        }

        #box {
            margin: 0 auto;
            width: 60%;
            /*setting alpha = 0.3*/
            background: rgba(72, 65, 65, 0.3);
            padding: 10px;
            text-align: justify;
        }

        a {
            color: yellow;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="box">
        <p>
            Welcome to the Makaranui Web site.
        </p>
        <p>
            This site has been put together very quickly to provide information and a way to register for the Labour Weekend hui.
        </p>
        <p>
            It will be made pretty at some stage.
        </p>
        <p>
            <a href="HuiOct2019">Register for the Labour Weekend hui</a>
        </p>
    </div>

</asp:Content>
