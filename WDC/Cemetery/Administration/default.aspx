<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="Online.Cemetery.Administration._default" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   

    <script type="text/javascript">


        $(document).ready(function () {

            $("#pagehelp").colorbox({ href: "default.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });


            $('body').on('click', '#btn_submit', function () {
                $('#results').empty();
                $.ajax({
                    url: "../data.aspx?mode=Search&surname=" + $("#tb_surname").val() + "&forenames=" + $("#tb_forenames").val(), success: function (result) {
                        $('#results').html(result);
                    }
                });
            });
            $('body').on('click', '.name', function () {

                id = $(this).attr("id").substring(3);
                type = id.substring(0, 1);
                if (type == 'G') {
                    window.open("archive/entry.aspx?id=" + id);
                } else {
                    window.open("sexton/entry.aspx?id=" + id);

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
