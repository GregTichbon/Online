<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Test.aspx.cs" Inherits="Auction.Administration.Test" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <div class="container" style="background-color: #FCF7EA">
        <form method="post" action="./items.aspx" id="form1" class="form-horizontal" role="form">
        
            <div id="category_2">
                <hr />
                <div class="items_title">Test</div>
                <div class="items_shortdescription">Test</div>
                <div class="cycle-slideshow item-slideshow canclick" id="viewitem23" data-cycle-timeout="2000" data-cycle-log="false">
                    <img src="images/auction2/items/23/Img_001.png" border="0" />
                </div>
                <div class="items_donated_head">
                    Generously Donated by
                    <a href="javascript:void(0)" class="donor-link donor_name" data-id="23">3</a>
                    <br />
                    <a href="javascript:void(0)" class="donor-link donor_name" data-id="23">Test</a>
                    <hr />
                </div>
                <div id="dialog_showitem">

                </div>



        </form>


    </div>
</body>
</html>
