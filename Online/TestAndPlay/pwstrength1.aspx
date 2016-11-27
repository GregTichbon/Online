<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="pwstrength1.aspx.cs" Inherits="Online.TestAndPlay.pwstrength1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
 <!-- Style Sheets -->
    <link href="../Content/bootstrap.min.css" rel="stylesheet" /><link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />
    <link href="../Content/main.css" rel="stylesheet" />


<!-- Javascript -->
    <script src="/Scripts/jquery-2.2.0.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>

 

    <script src="/Scripts/bootstrap.min.js"></script>
    <script src="https://eservices.wanganui.govt.nz/scripts/init.js" type="text/javascript"></script>
    <script src="/Scripts/jquery.validate.min.js"></script>
    <script src="/Scripts/additional-methods.js"></script>  <!--additional-methods.min.js-->

 
       <script src="/Scripts/wdc.js"></script>

 

    
    <script src="/Scripts/pwstrength-bootstrap.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {


            var $log = $('#log');


            "use strict";
            var options = {};
            options.ui = {
                container: "#pwd-container",
                showVerdictsInsideProgressBar: true,
                viewports: {
                    progress: ".pwstrength_viewport_progress"
                },
                progressBarExtraCssClasses: "progress-bar-striped active"
            };
            options.common = {
                debug: true,
                onKeyUp: function (evt, data) {
                    $log.append('<li>Score: ' + data.score + '</li>');
                }
            };
            var xx = $('#tb_password').pwstrength(options);






        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div class="form-group" id="pwd-container">
        <label class="control-label col-sm-4" for="tb_password">Password</label>
        <div class="col-sm-3">
            <input id="tb_password" name="tb_password" type="password" class="form-control" required />

        </div>
        <div class="col-sm-3" style="padding-top: 10px;">
            <div class="pwstrength_viewport_progress"></div>
        </div>
    </div>
        <ul id="log"></ul>
    </form>
</body>
</html>
