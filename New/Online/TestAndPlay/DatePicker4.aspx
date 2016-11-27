<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DatePicker4.aspx.cs" Inherits="Online.TestAndPlay.DatePicker4" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="<%: ResolveUrl("~/Scripts/jquery-2.2.0.min.js")%>"></script>



    <script src="//cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.js"></script>

    <!-- 
    <script type="text/javascript" src="/path/to/bootstrap/js/transition.js"></script>
    <script type="text/javascript" src="/path/to/bootstrap/js/collapse.js"></script>
    -->
    <script src="<%: ResolveUrl("~/Scripts/bootstrap.min.js")%>"></script>

    <script type="text/javascript" src="bootstrapdatepicker/bootstrap-datetimepicker.min.js"></script>
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <link href="bootstrapdatepicker/bootstrap-datetimepicker.min.css" rel="stylesheet" />


    <script>
        $(document).ready(function () {
            $('#datetimepicker1').datetimepicker({
                format: 'D MMM YYYY',
                viewMode: 'years',
                //defaultDate: moment().subtract(30, 'years'),
                showClear: true,
                viewDate: false
            });

            $("#dob").change(function () {
                alert(1);
                //calculate_age(new Date($('#tb_dateofbirth').val()));
            });

            $("#datetimepicker1").on("dp.change", function (e) {
                //alert(e.date);
                var years = moment().diff(e.date, 'years');
                //alert(years);
                $("#span_age").text('Age: ' + years + ' years');
                //calculate_age(e.date);
            });
        });



        function calculate_age(birthday) {
            var today = new Date();
            var nextbirthday = new Date(today.getFullYear(), birthday.getMonth(), birthday.getDate());
            if (isNaN(nextbirthday)) {
                $("#span_age").text('');
            } else {
                var age = today.getFullYear() - birthday.getFullYear();
                if (nextbirthday > today) {
                    age = age - 1;
                }
                $("#span_age").text('Age: ' + age + ' years');
            }
        };

    </script>
</head>
<body>
    <form id="form1" runat="server">


    <div class="row">
        <div class='col-sm-6'>
            <div class="form-group">
                <div class='input-group date' id='datetimepicker1'>
                    <input id="dob" type='text' class="form-control" />
                    <span class="input-group-addon">
                        <span class="glyphicon glyphicon-calendar"></span>
                    </span>
                </div>
            </div>
        </div>
<span id="span_age"></span>






    </form>
</body>
</html>
