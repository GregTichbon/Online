<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="datepicker2.aspx.cs" Inherits="Online.TestAndPlay.datepicker21" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('#tb_dateofbirth').datepick({
                dateFormat: 'd M yyyy',
                defaultDate: '-30y',
                showOnFocus: false,
                showTrigger: '#btn_dateofbirth',
                onSelect: function (dates) {
                    calculate_age(new Date(dates));
                }
            });


            $("#tb_dateofbirth").change(function () {
                calculate_age(new Date($('#tb_dateofbirth').val()));
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
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">



    <div class="form-group">
        <label for="tb_dateofbirth" class="control-label col-sm-4">Date of birth</label>
        <div class="col-sm-8">
            <div class="input-group">
                <div style="display: none;">
                    <span id="btn_dateofbirth" class="input-group-addon btn glyphicon glyphicon-calendar"></span>
                </div>
                <input id="tb_dateofbirth" name="tb_dateofbirth" placeholder="eg: 23 Jun 1985" type="date" class="form-control" value="xxxxx" title="Your date of birth will help us better to locate you on our council records, but is not required." />
                <span id="span_age" class="input-group-addon"></span>
            </div>
        </div>
    </div>





</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
