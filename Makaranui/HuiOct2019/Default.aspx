<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Makaranui.HuiOct2019.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  <style>
        body {
            background-image: url("../images/makaranui1.jpg");
            height: 100%;
            background-position: center;
            background-repeat: no-repeat;
            color:white;
            font-size:x-large;
            text-align:center;
            
        }

        #box {
            margin:0 auto;
            width:60%;
            /*setting alpha = 0.3*/ 
                background: rgba(72, 65, 65, 0.3); 
                padding: 10px; 
                text-align:justify;  
}

        a {
            color:yellow;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <div id="box">  
    <p>Nau mai, hoki mai, whakapiri mai ngā uri ō Tamakana, Tukaiora rātou ko Maringi.</p>
<p>Makaranui Marae is calling members of Tamakana, Tukaiora &amp; Maringi hapū to a wānanga that aims to reconnect people to their whakapapa, awa, whenua and mātauranga.</p>
<p>The wānanga will be held at Labour Weekend at Makaranui Marae on Raetihi-Ohakune Road, from Friday October 25 to Monday October 28, and will include a day-long bus trip to sites of significance.</p>
<ul>
<li>The event begins Friday at 4pm.</li>
<li>Saturday will be devoted to whakapapa, with special day programmes for rangatahi and tamariki.</li>
<li>On Sunday, significant sites will be visited, and in the evening there will be an aspirations session.</li>
<li>ThThe wānanga will end on Monday.</li>
</ul>
<p><strong>Hui Tshirts</strong></p>
<p>We are designing a hui tshirt, especially for the weekend.&nbsp; Only $15 each.&nbsp; You can order and pre-pay yours when you register.</p>
<p><strong>Costs</strong></p>
<ul>
<li>$50 per whanau (approx. 2 adults, 3 children). Koha is appreciated for extra people, to assist with costs.li>
<li>Registration is payable to: Kotahitanga Tribal Committee&nbsp; 38-9014-0036435-00</li>
<li>ReReference: your name, so we can match the payment to the registration</li>
</ul>
<p><strong>Register</strong></p>
<p>Click  <a href="Register.aspx">here</a> to register yourself and your whanau.</p>
<p>For more information, text Sheryl Connell on 021 969127.</p>
          </div>
</asp:Content>
