<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="Online.PropertyRolls.Search" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">


        $(document).ready(function () {

            $("#pagehelp").colorbox({ href: "search.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });


            $('body').on('click', '#btn_submit', function () {
                $('#results').empty();
                $.ajax({
                    url: "data.asmx/Search?occupiersurname=" + $("#tb_occupiersurname").val() + "&occupierfirstnames=" + $("#tb_occupierfirstnames").val() + "&years=" + $("#dd_years").val() + "&reference=" + $("#dd_reference").val() + "&status=" + $("#dd_status").val(), success: function (result) {
                        record = $.parseJSON(result);
                        $('#results').append('<table id="searchtable" class="table table-striped table-responsive"><tbody></tbody></table>');
                        table = $("#searchtable");
                        table.append('<tr><th>Occupier Name</th><th>Property Address</th><th>Year</th></tr>');
                        for (var i = 0, len = record.length; i < len; ++i) {
                            table.append('<tr><td><a class="view" id="' + record[i]['propertyroll_id'] + '" href="javascript:void(0);">' + record[i]['occupiername'] + '</a></td><td>' + record[i]['propertyaddress'] + '</td><td>' + record[i]['year'] + '</td></tr>');
                        }
                    }
                });
            });
            $('body').on('click', '.view', function () {
                id = $(this).attr("id");
                //$(".view").colorbox({ href: "view.aspx?id=" + id, iframe: true, height: "800", width: "700", overlayClose: true });
                //alert(id);
                window.open("entry.aspx?id=" + id, "PropertyRolls");
            });

            <% =Online.WDCFunctions.WDCFunctions.googleanalyticstracking(false)%>
        }); //document ready


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--<a id="pagehelp">
        <img id="helpicon" src="http://wdc.whanganui.govt.nz/online/images/question.png" title="Click on me for specific help on this page." /></a>-->
    <h1>Property Rolls Search
    </h1>
    <div class="container">
        <div class="panel panel-default">
            <div class="panel-heading">Occupier</div>
            <div class="panel-body">
                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_occupiersurname">Surname</label>
                    <div class="col-sm-8">
                        <input id="tb_occupiersurname" name="tb_occupiersurname" type="text" class="form-control" required />
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_occupierfirstnames">First name</label>
                    <div class="col-sm-8">
                        <input id="tb_occupierfirstnames" name="tb_occupierfirstnames" type="text" class="form-control" required />
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="dd_years">Years</label>
                    <div class="col-sm-8">
                        <select id="dd_years" name="dd_years" class="form-control">
                            <option></option>
                            <%=years%>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="dd_reference">Reference</label>
                    <div class="col-sm-8">
                        <select id="dd_reference" name="dd_reference" class="form-control">
                            <option></option>
                            <%=references%>
                        </select>
                    </div>
                </div>


                <div class="form-group">
                    <label class="control-label col-sm-4" for="dd_status">Status</label>
                    <div class="col-sm-8">
                        <select id="dd_status" name="dd_status" class="form-control">
                            <option></option>
                            <%=Online.WDCFunctions.WDCFunctions.populateselect(statuses, "", "None")%>
                        </select>
                    </div>
                </div>


            </div>
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
