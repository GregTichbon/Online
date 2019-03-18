<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GetLocation.aspx.cs" Inherits="Online.TestAndPlay.GetLocation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
    
    </style>
    <script type="text/javascript">
        var locations_maxline = 0;
        var location_userepeatname = "repeat_locations_";

        $(document).ready(function () {

            validator = $("#form1").validate({
                ignore: []
            });

 

            locations_maxline = $("#table_location tr").length;

            $('body').on('click', '.action_location', function () {
                //$(".action_location").click(function () {   //The line above means dynamically created html will automatically have events attached :-)
                var action = $(this).text();
                var item_count = parseInt($('#clientsideonly_hf_location').val());
                if (action == "Delete") {
                    line = $(this).attr("data-line");
                    $('#table_location tr[data-line="' + line + '"]').remove();
                    $('#clientsideonly_hf_location').val(item_count - 1);
                } else {
                    if (action == 'Add') {
                        line = 0;
                        qs = "";
                        $('#clientsideonly_hf_location').val(item_count + 1);
                    } else {
                        //Edit
                        line = $(this).attr("data-line");
                        qs = "&p=" + $("input[id$='" + location_userepeatname + "hf_locationcoords_" + line + "']").val() + "&location=" + $("input[id$='" + location_userepeatname + "tb_location_" + line + "']").val();
                    }
                    $.colorbox({ href: "../mapping/GetLocation.aspx?line=" + line + qs, iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });
                }
                $("#form1").validate().element("#clientsideonly_hf_location");
            });

        });

        function passlocation(line, location, coords) {
            $.colorbox.close();
            if (line == 0) {
                locations_maxline = locations_maxline + 1;
                input = '<input readonly="readonly" style="width:80%" type="text" id="' + location_userepeatname + 'tb_location_' + locations_maxline + '" name="' + location_userepeatname + 'tb_location_' + locations_maxline + '" class="form_control col-sm-8" value="' + location + '" />';
                input = input + '<input id="' + location_userepeatname + 'hf_locationcoords_' + locations_maxline + '" name="' + location_userepeatname + 'hf_locationcoords_' + locations_maxline + '" type="hidden" value="' + coords + '" />';
                input = input + '&nbsp;<a class="action_location" data-line="' + locations_maxline + '">Edit</a>&nbsp;<a class="action_location" data-line="' + locations_maxline + '">Delete</a>';
                $('#table_location tr:last').after('<tr data-line="' + locations_maxline + '"><td>' + input + '</td></tr>');
            } else {
                $("input[id$='" + location_userepeatname + "tb_location_" + line + "']").val(location);
                $("input[id$='" + location_userepeatname + "hf_locationcoords_" + line + "']").val(coords);
            }
        }

    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="form-group">
        <label class="control-label col-sm-4" for="xxxxx">
            Specific
            Location(s)
            <br />
            <a class="action_location">Add</a>
        </label>
        <div class="col-sm-8">
            <input id="clientsideonly_hf_location" name="clientsideonly_hf_location" type="hidden" value="0" />
            <table id="table_location" style="width: 100%;">
                <tr style="display:none">
                    <td></td>
                </tr>
            </table>
        </div>
    </div>

  
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
