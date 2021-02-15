<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Answer.aspx.cs" Inherits="TOHW.PhotoHunt11Jun18.Answer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        body, input {
            font-size: 20px;
            font-size: 4vw;
        }
    </style>
</head>
<script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>
<script type="text/javascript">

    $(document).ready(function () {

        $("#form1").submit(function (event) {
            //parent.jQuery.colorbox.close();
        });

        $('#btn_close').click(function () {
            parent.jQuery.colorbox.close();
        })

        $('#btn_upload').click(function () {
            $('#span_upload').show();
            $('#span_message').text('Your image has been recorded.  You may click "Close".');
            $('#btn_upload').hide();
        })

        $('body').on('click', '#use', function () {
            //image = data_uri; //.replace('data:image/png;base64,', '');
            image = $("#image")[0].src;
            $.ajax({
                type: "POST",
                //async: false,
                url: "posts.asmx/SaveAnswer",
                data: '{"imageData": "' + image + '", "groupcode": "' + <%=groupcode%> + '", "photo_ctr": "' + <%=photo_ctr%> + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    $('#action').hide();
                    $('#close').show();
                    //d = new Date();
                    //$(thisversion).attr("src", "images/" + result.d.id + ".jpg?" + d.getTime());
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("Status: " + textStatus); alert("Error: " + errorThrown);
                }
            });
        });


    }); //document.ready

</script>
<body>
    <form id="form1" runat="server">
        <div id="close" style="display:none">
            <!--<input id="btn_close" type="button" value="Successfully saved - Close" />-->
            Successfully saved.
        </div>

        <div id="action"<%=showupload %>>
            Either; "Take photo", when you're happy with it "Use" it, OR "Choose File" and then "Submit" it.
            <div style="width: 100%; display: table;">
                <div style="display: table-row">
                    <div id="my_camera" style="display: table-cell;"></div>
                    <div id="results" style="text-align: right; display: table-cell;"></div>
                </div>
            </div>

            <script src="../Dependencies/WebCam/webcam.js"></script>
            <script>
                Webcam.set({
                    width: 320,
                    height: 240,
                    image_format: 'jpeg',
                    jpeg_quality: 90
                });
                Webcam.attach('#my_camera');
            </script>
            <input type="button" value="Take Photo" onclick="take_snapshot()" />
            <script>
                function take_snapshot() {
                    Webcam.snap(function (data_uri) {
                        //console.log(data_uri);
                        document.getElementById('results').innerHTML = '<img id="image" src="' + data_uri + '"/><br /><input id="use" type="button" value="Use" />';
                    });
                }
            </script>

            <hr />
            <asp:FileUpload ID="fu_answer" runat="server" />
            <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info" Text="Submit" />

            <div id="span_upload" <%= showupload %>></div>
           
        </div>
         <asp:Literal ID="Lit_Response" runat="server"></asp:Literal>
    </form>
</body>
</html>
