<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SPA1.aspx.cs" Inherits="Online.TestAndPlay.SPA1" %>


<!DOCTYPE html>
<html id="realBack" class="realback" lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Japan Four
    </title>

    <script src="<%: ResolveUrl("~/Scripts/jquery-2.2.0.min.js")%>"></script>

    <script type="text/javascript">
        $(document).ready(function () {

            function loadTwirl(toPage) {
                //alert($("#showBox").get(0).innerHTML);
                $("#showBox").get(0).innerHTML = '<center><img src="http://oriley.org/jpn4/Images/twirl.gif" /></center>';
                //$("html, body").animate({ scrollTop: 16 }, 0);
                loadBox.location.href = toPage;
            }
        });
    </script>
</head>

<body>





    <script>
        function fillGameBox() {
            var boxContent = $("#loadBox").contents().find("#sendBox").html();
            //var fillShowBox = boxContent.children[1].innerHTML;
            $("#showBox").html(boxContent);
            $("#loadBox").contents().find("#sendBox").html("");
        }

    </script>

    <div id="showBox" style="width: 400px">

        <div id="sendBox">

            <a href="#" onclick="javascript: loadTwirl('datepicker1.aspx');">
                <img id="pic2" src="http://www.oriley.org/Images/japaneseToEnglish.png" style="margin-bottom: 12px; border: 0px" />
            </a>
            <a href="#" onclick="javascript: loadTwirl('http://www.oriley.org/Home/gameBox6?user=090243225');">
                <img id="pic1" src="http://www.oriley.org/Images/englishToJapanese.png" style="margin-bottom: 12px; border: 0px" />
            </a>
            <a href="#" onclick="javascript: loadTwirl('http://www.oriley.org/Home/gameBox4?user=090243225');">
                <img id="pic3" src="http://www.oriley.org/Images/pickLists.png" style="margin-bottom: 12px; border: 0px" />
            </a>
            <a href="#" onclick="javascript: loadTwirl('http://www.oriley.org/Home/gameBox2?user=090243225');">
                <img id="pic4" src="http://www.oriley.org/Images/editLists.png" style="border: 0px" />
            </a>

        </div>
    </div>

    <iframe id="loadBox" name="loadBox" onload="fillGameBox()" src="http://oriley.org/Home/gameBox1?user=103090243225" style="display: none"></iframe>

    <iframe id="emptyBox" name="emptyBox" style="display: none"></iframe>


</body>
</html>

