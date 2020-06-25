<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Slideshow1.aspx.cs" Inherits="Auction.TestandPlay.Slideshow1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Test</title>
    <script src="<%: ResolveUrl("~/_Includes/Scripts/jquery-2.2.0.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/_Includes/Scripts/cycle2/jquery.cycle2.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/_Includes/Scripts/cycle2/jquery.cycle2.center.min.js")%>"></script>

    <style>
        .showitem-slideshowX {
            height: 200px;
        }

            .showitem-slideshowX img {
                width: auto;
                height: 100%;
            }
    </style>
    <script>
        $(document).ready(function () {
            //$('.slideshow').cycle();
        });
    </script>


</head>
<body>
    <form id="form1" runat="server">
        <div style="display:none">
            <div class="cycle-slideshow showitem-slideshow" data-title="xxx" data-cycle-timeout="2000" data-cycle-center-horz="true" data-cycle-log="false">
                <img src="../images/auction1/header.png" border="0" />
                <img src="../images/auction1/items/15/Outdoor Furniture Cool Stool.jpg" border="0" />
            </div>
     

        <div class="cycle-slideshow showitem-slideshow" data-title="xxx" data-cycle-timeout="2000" data-cycle-center-horz="true" data-cycle-log="false" style="position: relative;">
            <img src="../images/auction1/header.png" border="0" class="cycle-slide cycle-slide-active" style="position: absolute; top: 0px; left: 0px; z-index: 99; opacity: 1; display: block; visibility: visible; margin-left: 316px;" />
        </div>
               </div>

        <div>
            <!--<img src="../images/auction1/items/15/Outdoor Furniture Cool Stool.jpg" style="max-height:100%;width:auto" />-->
             <img src="../images/auction1/items/15/Outdoor Furniture Cool Stool.jpg" border="0" style="max-height:100%;max-width:100%"  />

        </div>

    </form>
</body>
</html>
