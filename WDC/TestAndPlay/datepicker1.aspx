<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="datepicker1.aspx.cs" Inherits="Online.TestAndPlay.datepicker1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />


    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
    <script src="<%: ResolveUrl("~/Scripts/additional-methods.min.js")%>"></script>


    <script type="text/javascript">
        $(document).ready(function () {
            //alert('Loaded');


            //$("#mybutton").click(function () { $("#test1").datepicker("show"); });

            $("#myspan").datepicker({

                dateFormat: "d MM yy",
                changeMonth: true,
                changeYear: true,
                onSelect: function (dateStr) {
                    $("#test1").val(dateStr);
                    $('#myspan').hide();
       
                    var today = new Date();
                    var birthday = $(this).datepicker('getDate');
                    age = (
                    (today.getMonth() > birthday.getMonth())
                    ||
                    (today.getMonth() == birthday.getMonth() && today.getDate() >= birthday.getDate())
                    ) ? today.getFullYear() - birthday.getFullYear() : today.getFullYear() - birthday.getFullYear() - 1;

                    $("#myage").text('Age: ' + age + ' years');
                }
            }).toggle();
            $('#mybutton').click(function () {
                $('#myspan').show();
            });




        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">





    <div class="form-group">


        <div class="form-group">
            <label class="control-label col-sm-2" for="tb_dateofbirth">Date of birth</label>
            <div class="col-sm-10">
                <input id="tb_dateofbirth" name="tb_dateofbirth" type="date" class="form-control" />
            </div>
        </div>


        <div class="control-group">
            <label for="date-picker-3" class="control-label col-sm-2">Date of birth</label>
            <div class="controls col-sm-10">
                <div class="input-group">
                    <label for="date-picker-3" class="input-group-addon btn">
                        <span class="glyphicon glyphicon-calendar"></span>

                    </label>
                    <input id="date-picker-3" type="text" class="date-picker form-control" />
                </div>
            </div>
        </div>



        <div class="form-group">
            <label for="test1" class="control-label col-sm-2">Date of birth</label>
            <div class="col-sm-10">
                <div class="input-group">
                    <span id="mybutton" class="input-group-addon btn glyphicon glyphicon-calendar"></span>
                    <input id="test1" type="text" class="date-picker form-control" />
                    <span id="myage" class="input-group-addon"></span>

                </div>
            </div>
        </div>
        <span id="myspan"></span>




    </div>





</asp:Content>
