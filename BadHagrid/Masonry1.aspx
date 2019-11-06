<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Masonry1.aspx.cs" Inherits="BadHagrid.Masonry1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        #container {
            border: 1px solid;
            padding: 5px;
            max-width: 630px;
        }
        img {
            width:100%;
        }

        .item {
            width: 200px;
            height: 100%;
            float: left;
            margin: 5px;
            background-color:blue;
        }

            .item.w2 {
                width: 400px;
            }

            .item.h2 {
                height: 130px;
            }
    </style>
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>
    <script src="https://unpkg.com/imagesloaded@4/imagesloaded.pkgd.min.js"></script>
    <script src="https://unpkg.com/masonry-layout@4/dist/masonry.pkgd.min.js"></script>
    <script>
        $(document).ready(function () {
            var $container = $('#container');

            $container.imagesLoaded(function () {
                $container.masonry({
                    itemSelector: '.box'
                });
            });
            /*


            $('#container').masonry({
                itemSelector: '.item',
                columnWidth: 210
            });
            */
        });  //document.ready
    </script>


</head>
<body>
    <form id="form1" runat="server">
        <div id="container">
            <div class="item">
                <img src="userfiles/image/Gallery/1.jpg" />
            </div>
            <div class="item w2">
                <img src="userfiles/image/Gallery/2.jpg" />
            </div>
            <div class="item">
                <img src="userfiles/image/Gallery/3.jpg" />
            </div>
            <div class="item w2">
                <img src="userfiles/image/Gallery/4.jpg" />
            </div>
            <div class="item h2">
                <img src="userfiles/image/Gallery/5.jpg" />
            </div>
            <div class="item">
                <img src="userfiles/image/Gallery/6.jpg" />
            </div>
            <div class="item h2">
                <img src="userfiles/image/Gallery/7.jpg" />
            </div>
            <div class="item w2 h2">
                <img src="userfiles/image/Gallery/1.jpg" />
            </div>
            <div class="item">
                <img src="userfiles/image/Gallery/2.jpg" />
            </div>
            <div class="item">
                <img src="userfiles/image/Gallery/3.jpg" />
            </div>
            <div class="item h2">
                <img src="userfiles/image/Gallery/4.jpg" />
            </div>
            <div class="item">
                <img src="userfiles/image/Gallery/5.jpg" />
            </div>
            <div class="item">
                <img src="userfiles/image/Gallery/6.jpg" />
            </div>
            <div class="item w2">
                <img src="userfiles/image/Gallery/7.jpg" />
            </div>
            <div class="item h2">
                <img src="userfiles/image/Gallery/1.jpg" />
            </div>
            <div class="item">
                <img src="userfiles/image/Gallery/2.jpg" />
            </div>
            <div class="item h2">
                <img src="userfiles/image/Gallery/3.jpg" />
            </div>
        </div>
    </form>
</body>
</html>
