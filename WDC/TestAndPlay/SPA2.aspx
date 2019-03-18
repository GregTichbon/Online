<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SPA2.aspx.cs" Inherits="Online.TestAndPlay.SPA2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <style>
        #app {
            background: #abc;
            display: none;
        }

        #icons {
            float: left;
            width: 42px;
            display: block;
        }

        .icon {
            background: #ccc;
            cursor: pointer;
            max-width: 40px;
            height: 40px;
            text-align: center;
            border: 1px solid black;
        }

        #panel1 {
            display: block;
        }

        #panel2, #panel3, #panel4 {
            display: none;
        }
    </style>

    <script src="<%: ResolveUrl("~/Scripts/jquery-2.2.0.min.js")%>"></script>

    <script type="text/javascript">
        $(document).ready(function () {

            $('#bg').hide();
            $('#app').show()

            function keypress(e) {
                //alert(e.keyCode);
                if (e.keyCode != 32) return
                $('#bg').hide();
                $('#app').show()
            }

            function navbtn(e) {
                var elem = $('#panel1');
                switch ($(e.target).attr('id')) {
                    case "icon2": elem = $('#panel2'); break;
                    case "icon3": elem = $('#panel3'); break;
                    case "icon4": elem = $('#panel4'); break;
                }
                $('#panel1,#panel2,#panel3,#panel4').hide();
                elem.show()
            }

            //init
            $(function () {  //docready

                $('body').keypress(keypress);
                $('.icon').click(navbtn)
                $('#panel1 button').click(function (e) {
                    $('#panel1').hide(); $('#panel2').show();
                });
                $('#panel1 textarea').change(function (e) {
                    $('#panel2 span').html($(e.target).val())
                })
            })
        });
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <div id="bg">p r e s s &nbsp;&nbsp; s p a c e b a r   </div> 


        <div id="app">
            <div id="icons">
                <div id="icon1" class="icon">A</div>
                <div id="icon2" class="icon">B</div>
                <div id="icon3" class="icon">C</div>
                <div id="icon4" class="icon">D</div>
            </div>
            <div id="panel1">
                <textarea name="" id="" cols="30" rows="10" placeholder="enter some text and push next"></textarea>
                <button id="next1">next</button>
            </div>
            <div id="panel2">
                you entered
        "<span></span>"
            </div>
            <div id="panel3">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dolor vel nisi magni sed iure sapiente esse placeat debitis aperiam a quasi unde eaque facere mollitia ex aspernatur quia quas perferendis.</div>
            <div id="panel4">about this app.
                <br>
                blah blah
                <br>
                copyleft me </div>
        </div>
    </form>
</body>
</html>
