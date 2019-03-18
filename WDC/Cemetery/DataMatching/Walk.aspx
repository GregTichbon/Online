<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Walk.aspx.cs" Inherits="Online.Cemetery.DataMatching.Walk" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">

        var cemetery = -1;
        var area = -1;
        var block = -1;
        var division = -1;


        $(document).ready(function () {

            $("#pagehelp").colorbox({ href: "walkhelp.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });


            $('body').on('click', '#btn_submit', function () {
                $('#results').empty();
                $.ajax({
                    url: "../../functions/data.asmx/CemeterySearch?mode=list&surname=" + $("#tb_surname").val() + "&forenames=" + $("#tb_forenames").val(), success: function (result) {
                        burialrecord = $.parseJSON(result);
                        $('#results').append('<table id="searchtable" class="table table-striped table-responsive"><tbody></tbody></table>');
                        table = $("#searchtable");
                        table.append('<tr><th>Name</th><th>Date of Birth</th><th>Date of Death</th><th>Date of Burial</th><th>Location</th></tr>');
                        for (var i = 0, len = burialrecord.length; i < len; ++i) {
                            table.append('<tr><td><a class="Update" id="' + burialrecord[i]['AccessID'] + '" href="javascript:void(0);">' + burialrecord[i]['Name'] + '</a></td><td>' + burialrecord[i]['Date_of_Birth'] + '</td><td>' + burialrecord[i]['Date_of_Death'] + '</td><td>' + burialrecord[i]['Date_of_Burial'] + '</td><td>' + burialrecord[i]['Location'] + '</td></tr>');
                            //<td><a class="Update" id="' + burialrecord[i]['AccessID'] + '" href="javascript:void(0);">Update</a></td>
                        }
                    }
                });
            });
            $('body').on('click', '.Update', function () {
                id = $(this).attr("id");
                $(".Update").colorbox({href:"WalkUpdate.aspx?id=" + id, iframe:true, height:"800", width:"90%", overlayClose:true});
            });


        }); //document ready



    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <a id="pagehelp">
        <img id="helpicon" src="http://wdc.whanganui.govt.nz/online/images/question.png" title="Click on me for specific help on this page." /></a>
    <h1>Walk
    </h1>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_surname">Surname</label>
        <div class="col-sm-8">
            <input id="tb_surname" name="tb_surname" type="text" class="form-control" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_forenames">First name</label>
        <div class="col-sm-8">
            <input id="tb_forenames" name="tb_forenames" type="text" class="form-control" required />
        </div>
    </div>

    <!-- SUBMIT -->

    <div class="form-group">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
            <input id="btn_submit" type="button" value="Search" class="btn btn-info submit" />
        </div>
    </div>


    <div id="results"></div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
  
</asp:Content>