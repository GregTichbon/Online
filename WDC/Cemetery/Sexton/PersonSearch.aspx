<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PersonSearch.aspx.cs" Inherits="Online.Cemetery.Sexton.PersonSearch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   

    <script type="text/javascript">


        $(document).ready(function () {

            $("#pagehelp").colorbox({ href: "search.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });


            $('body').on('click', '#btn_submit', function () {
                $('#results').empty();
                $.ajax({
                    url: "../../functions/data.asmx/CemeterySearch?mode=list&surname=" + $("#tb_surname").val() + "&forenames=" + $("#tb_forenames").val(), success: function (result) {
                        burialrecord = $.parseJSON(result);
                        $('#results').append('<table id="searchtable" class="table table-striped table-responsive"><tbody></tbody></table>');
                        table = $("#searchtable");
                        //table.append('<tr><th>Name</th><th>Date of Birth</th><th>Date of Death</th><th>Date of Burial</th><th>View</th></tr>');
                        table.append('<tr><th>Name</th><th>Date of Birth</th><th>Date of Death</th><th>Date of Burial</th></tr>');
                        for (var i = 0, len = burialrecord.length; i < len; ++i) {
                            //table.append('<tr><td>' + burialrecord[i]['Name'] + '</td><td>' + burialrecord[i]['Date_of_Birth'] + '</td><td>' + burialrecord[i]['Date_of_Death'] + '</td><td>' + burialrecord[i]['Date_of_Burial'] + '</td><td><a class="view" id="' + burialrecord[i]['AccessID'] + '" href="javascript:void(0);">View</a></td></tr>');
                            table.append('<tr><td><a class="view" id="' + burialrecord[i]['AccessID'] + '" href="javascript:void(0);">' + burialrecord[i]['Name'] + '</a></td><td>' + burialrecord[i]['Date_of_Birth'] + '</td><td>' + burialrecord[i]['Date_of_Death'] + '</td><td>' + burialrecord[i]['Date_of_Burial'] + '</td></tr>');
                        }
                        /*
                        for (var i = 0, len = burialrecord.length; i < len; ++i) {
                            var table = $(document.createElement('table'))
                            $('#results').append('<table id="table' + i + '" class="table table-hover table-responsive"></table>');
                            table = $("#table" + i);
                            for (var key in burialrecord[i]) {
                                //alert(key + ', ' + burialrecord[i][key]);
                                buildburialrecords(table, key, burialrecord[i][key]);
                            }
                            table.append('<tr><td class="col-md-4 text-right">Request the inclusion of additional information</td><td><input id="additional' + i + '" type="text" /></td></tr>');
                            table.append('<tr><td class="col-md-4 text-right">Upload files</td><td><input id="file' + i + '" type="file" /></td></tr>');
                        }
                        */
                    }
                });
            });
            $('body').on('click', '.view', function () {
                id = $(this).attr("id");
                if (id.substring(0, 1) == 'S') {
                    window.open("personentry.aspx?id=" + id,"_self");
                } else {
                    window.open("../archive/entry.aspx?id=" + id,"_self");
                }
            });
    
        }); //document ready




        /*
        function buildburialrecords(table, label, value) {
            if (value != '') {
                table.append('<tr><td class="col-md-4 text-right">' + label.replace(/_/g, ' ') + '</td><td>' + value + "</td></tr>");
            }
        }
        */

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--<a id="pagehelp">
        <img id="helpicon" src="http://wdc.whanganui.govt.nz/online/images/question.png" title="Click on me for specific help on this page." /></a>-->
    <h1>Cemetery Search
    </h1>
        <div class="form-group">
        <label class="control-label col-sm-4" for="tb_surname">Surname</label>
        <div class="col-sm-8">
            <input id="tb_surname" name="tb_surname" type="text" class="form-control" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_forenames">First name(s)</label>
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
