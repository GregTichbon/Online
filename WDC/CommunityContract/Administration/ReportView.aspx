<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReportView.aspx.cs" Inherits="Online.CommunityContract.Administration.ReportView" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        .inject {
            color: red;
            font-size: large;
        }
    </style>

    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Content/bootstrap.min.css")%>" rel="stylesheet" />
    <!--<link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />-->
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css" />
    <!--1.11.4-->

    <!--<link href="<%: ResolveUrl("~/Scripts/colorbox/colorbox.css")%>" rel="stylesheet" />-->
    <!--<link href="<%: ResolveUrl("~/Scripts/bootstrap-datetimepicker/bootstrap-datetimepicker.min.css")%>" rel="stylesheet" />-->
    <link href="Content/main.css" rel="stylesheet" />


    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Scripts/jquery-2.2.0.min.js")%>"></script>

    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
    <script src="<%: ResolveUrl("~/Scripts/bootstrap.min.js")%>"></script> 

    <script type="text/javascript">

        //to use BS
        //http://www.ryadel.com/en/using-jquery-ui-bootstrap-togheter-web-page
        //If doing the 2 lines below they need to be executed after the JQueryUI and before the Bootstrap js file references
        //$.widget.bridge('uitooltip', $.ui.tooltip);
        //$.widget.bridge('uibutton', $.ui.button);


        //To use UI
        //If doing the 2 lines below bootstrap must be done before UI
        $.fn.bsbutton = $.fn.button.noConflict();
        $.fn.bstooltip = $.fn.tooltip.noConflict();
    </script>

    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
    <!--<script src="<%: ResolveUrl("~/Scripts/bootstrap.min.js")%>"></script>-->
    <!--1.11.4-->



    <!--<script src="https://eservices.wanganui.govt.nz/scripts/init.js" type="text/javascript"></script>-->
    <!--<script src="<%: ResolveUrl("~/Scripts/colorbox/jquery.colorbox-min.js")%>"></script>-->
    <!--<script src="<%: ResolveUrl("~/Scripts/jquery.validate.min.js")%>"></script>-->
    <!--<script src="<%: ResolveUrl("~/Scripts/additional-methods.js")%>"></script>-->
    <!--additional-methods.min.js-->

    <!--<script src="//cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.js"></script>-->
    <!--<script src="<%: ResolveUrl("~/Scripts/bootstrap-datetimepicker/bootstrap-datetimepicker.min.js")%>"></script>-->

    <!--
        <script type="text/javascript" src="//cdn.jsdelivr.net/jquery.dirtyforms/2.0.0/jquery.dirtyforms.min.js"></script>
    <script type="text/javascript" src="<%: ResolveUrl("~/Scripts/Autosize/autosize.min.js")%>"></script>
    <script type="text/javascript" src="<%: ResolveUrl("~/Scripts/MaxLength/MaxLength.js")%>"></script>
    <script type="text/javascript" src="<%: ResolveUrl("~/Scripts/Numeric/numeric.js")%>"></script>
        -->

    <script src="<%: ResolveUrl("~/Scripts/wdc.js")%>"></script>

    <script type="text/javascript">

        $(document).ready(function () {
            $(".inject").bstooltip();

            var inject_id;

            $(".inject").click(function () {
                alert('Can not currently show a dialog box in a colorbox');
                inject_id = $(this).attr("id");
                $("#dialog-text").html($(this).data("shortprompt"));
                $("#inject_response").val($(this).data('value'));
                $("#dialog-inject").dialog("open");
            });
            $("#dialog-inject").dialog({
                autoOpen: false,
                resizable: false,
                height: "auto",
                width: 400,
                modal: true,
                buttons: {
                    "Update": function () {
                        if ($('#item_' + inject_id).val() != $('#inject_response').val()) {
                            $('#' + inject_id).text($('#inject_response').val())
                            $('#item_' + inject_id).val($('#inject_response').val());
                            $('#text_' + inject_id).text($('#inject_response').val());
                            var inject_id_parts = inject_id.split('_');
                            key = inject_id_parts[1];
                            $('#line_response_' + key).val($('#response_' + key).text());
                            $('#form1').addClass('mydirty');
                        }
                        $(this).dialog("close");
                    },
                    Cancel: function () {
                        $(this).dialog("close");
                    }
                }
            });



        }); //document.ready






    </script>
</head>
<body>
    <form id="form1" runat="server">
  <div class="form-group">
        <label class="control-label col-sm-4" for="tb_projectname">Project name:</label>
        <div class="col-sm-8">
            <input type="text" id="tb_projectname" name="tb_projectname" value="<%:tb_projectname %>" style="width: 100%" readonly="readonly" />
        </div>
    </div>



    <%=html %>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_highlights">Highlights</label><div class="col-sm-8">
            <textarea id="tb_highlights" name="tb_highlights" class="form-control" required><%:tb_highlights %></textarea>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_issues">Issues</label><div class="col-sm-8">
            <textarea id="tb_issues" name="tb_issues" class="form-control" required><%:tb_issues %></textarea>
        </div>
    </div>


    <div class="form-group">
        <label class="control-label col-sm-4" for="fu_files">Please upload any supporting documentation if you wish.</label><div class="col-sm-8">
           
            <input id="fu_files" name="fu_files" type="file" multiple="multiple" />
     
            <asp:Label ID="lbl_files" runat="server" Text=""></asp:Label>
        </div>
    </div>


    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_finalised">Finalise this report:</label>
        <div class="col-sm-8">
            <select id="dd_finalised" name="dd_finalised" class="form-control" required>
                <option></option>
                <%
                    foreach (string dd_value in yesno_values)
                    {
                        if (dd_value == dd_finalised)
                        {
                            selected = " selected";
                        }
                        else
                        {
                            selected = "";
                        }
                        Response.Write("<option" + selected + ">" + dd_value + "</option>");
                    }
                %>
            </select>
        </div>
    </div>
    </form>
</body>
</html>
