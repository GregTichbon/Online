<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DatePicker3.aspx.cs" Inherits="Online.TestAndPlay.DatePicker3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


    <script>
        $(document).ready(function () {
            $('#datetimepicker1').datetimepicker({
                format: 'D MMM YYYY',
                viewMode: 'years',
                //defaultDate: moment().subtract(30, 'years'),
                showClear: true,
                viewDate: false
            });
        });

    </script>



</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <a id="pagehelp">
        <img id="helpicon" src="http://wdc.whanganui.govt.nz/online/images/question.png" title="Click on me for specific help on this page." /></a>
    <h1>Mobile Shop Licence Application
    </h1>

    <div class="form-group">
        <label for="tb_dateofbirth" class="control-label col-sm-4">Date of birth</label>
        <div class="col-sm-8">
            <div class="input-group">

                <div class='input-group date' id='datetimepicker1'>
                    <input id="tb_dateofbirth" name="tb_dateofbirth" placeholder="eg: 23 Jun 1985" type="date" class="form-control" value="" title="Your date of birth will help us better to locate you on our council records, but is not required." />
                    <span class="input-group-addon">
                        <span class="glyphicon glyphicon-calendar"></span>
                    </span>
                </div>

                <!--            
                <div class="form-group">
                    <div class='input-group date' id='datetimepicker1'>
                        <input type='text' class="form-control" />
                        <span class="input-group-addon">
                            <span class="glyphicon glyphicon-calendar"></span>
                        </span>
                    </div>
                </div>
                -->



                <span id="span_age" class="input-group-addon"></span>
            </div>
        </div>
    </div>



</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
