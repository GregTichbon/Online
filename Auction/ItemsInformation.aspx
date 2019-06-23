<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ItemsInformation.aspx.cs" Inherits="Auction.ItemsInformation" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
     
        Welcome to <%= auction %> online auction.
        <br />
        <br />
        There are <%= numberofitems %> awesome items up for grabs.
        <br />
        <br />
        Bidding is simple, browse through the items and if there is something that interests you click on the link to get more information and to make your bid.<br />
        <br />
        We have categorised the items so that you can easily find those things that might be of particular interest. Click on any of the buttons at the top of the page to show just those items.<br />
        <br />
        If you haven&#39;t already registered, click on the &quot;Register&quot; link and enter your name, email address, and a password of your choosing. By providing your mobile number we can easily communicate with you if you are the lucky winner. You will be notified by email if you have a bid which has been surpassed by another bid. You can also opt to receive these notifications by text. 
        <br />
        <br />
        Be sure to read the terms and conditions. 
        <br />
        <br />
        If you have registered and are not already logged in, click on the &quot;Login&quot; button and enter your email address and password and optionally choose the &quot;Keep me logged in&quot; option. 
        <br />
        <br />
        Then you can make your bid. 
        <br />
        <br />
        Some items have set starting prices and a set amount which bids must increase by. This will be indicated by the amount shown in &quot;Your bid&quot;. This is the minimum bid that you can make. 
        <br />
        <br />
        There are some reserves set. A message will show when the current bid is less than the reserve. 
        <br />
        <br />
        There is also a facility to set an &quot;Auto Bid&quot; so that bids are made 
        automatically if you should be out-bid. These will increase by the set amount that bids must increase by. </form>
</body>
</html>
