<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ToolTip1.aspx.cs" Inherits="Online.TestAndPlay.ToolTip1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>



    <!-- Style Sheets -->
    <% if (1 == 2)
        { %>
    <link href="<%: ResolveUrl("~/Content/bootstrap.min.css")%>" rel="stylesheet" />
    <% } %>

    <!--<link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />-->
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css" />
    <!--1.11.4-->

    <% if (1 == 2)
        { %>
    <link href="<%: ResolveUrl("~/Scripts/colorbox/colorbox.css")%>" rel="stylesheet" />
    <link href="<%: ResolveUrl("~/Scripts/bootstrap-datetimepicker/bootstrap-datetimepicker.min.css")%>" rel="stylesheet" />
    <link href="<%: ResolveUrl("~/Content/main.css")%>" rel="stylesheet" />
    <% } %>
    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Scripts/jquery-2.2.0.min.js")%>"></script>

    <!--<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>-->
    <% if (1 == 2)
        { %>
    <script src="<%: ResolveUrl("~/Scripts/bootstrap.min.js")%>"></script>
    <% } %>
    <% if (1 == 2)
        { %>
    <script type="text/javascript">

        //To use BS
        //http://www.ryadel.com/en/using-jquery-ui-bootstrap-togheter-web-page
        //If doing the 2 lines below they need to be executed after the JQueryUI and before the Bootstrap js file references
        //$.widget.bridge('uitooltip', $.ui.tooltip);
        //$.widget.bridge('uibutton', $.ui.button);


        //To use UI
        //If doing the 2 lines below bootstrap must be done before UI
        $.fn.bsbutton = $.fn.button.noConflict();
        $.fn.bstooltip = $.fn.tooltip.noConflict();
    </script>
    <% } %>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
    <!--<script src="<%: ResolveUrl("~/Scripts/bootstrap.min.js")%>"></script>-->
    <!--1.11.4-->



    <% if (1 == 2)
        { %>
    <script src="https://eservices.wanganui.govt.nz/scripts/init.js" type="text/javascript"></script>
    <script src="<%: ResolveUrl("~/Scripts/colorbox/jquery.colorbox-min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Scripts/jquery.validate.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Scripts/additional-methods.js")%>"></script>
    <!--additional-methods.min.js-->

    <script src="//cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.js"></script>
    <script src="<%: ResolveUrl("~/Scripts/bootstrap-datetimepicker/bootstrap-datetimepicker.min.js")%>"></script>

    <script type="text/javascript" src="//cdn.jsdelivr.net/jquery.dirtyforms/2.0.0/jquery.dirtyforms.min.js"></script>
    <script type="text/javascript" src="<%: ResolveUrl("~/Scripts/Autosize/autosize.min.js")%>"></script>
    <script type="text/javascript" src="<%: ResolveUrl("~/Scripts/MaxLength/MaxLength.js")%>"></script>
    <script type="text/javascript" src="<%: ResolveUrl("~/Scripts/Numeric/numeric.js")%>"></script>

    <script src="<%: ResolveUrl("~/Scripts/wdc.js")%>"></script>

    <% } %>

    <!--<script src="https://unpkg.com/tippy.js@2.5.0/dist/tippy.all.min.js"></script>-->
    <script src="../Scripts/Browser-Device-Feature-Detection.js/checkit.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
          
            //$(document).tooltip({    //this is the ui tooltip
            //$("#href_rid").tooltip({ 
            $("[title]").tooltip({
                content: function () {
                    return this.getAttribute("title");
                },
                position: {
                    my: "right center",
                    at: "left center"
                },
                open: function (event, ui) {
                    if (navigator.userAgent.match(/Android|iPhone|iPad|iPod/i)) {
                        setTimeout(function () {
                            $(ui.tooltip).hide();
                        }, 3000);
                    }
                }

            });
          
            /*
            $(document).tooltip("destroy");
            tippy('[title]', {
                size: 'large'
            });
            */

            //alert(navigator.userAgent);
            //alert(checkit.Mobile.iOS());
           
            //$('.tooltip').tooltipster();


            $('.inhibitcutcopypaste').bind("cut copy paste", function (e) {
                e.preventDefault();
            });

            //$('[required]').css('border', '1px solid red');
            $('[required]').addClass('required');

            $("#href_rid").click(function () {
                $("#href_rid").tooltip("close");
                //$(".ui-tooltip-content").parents('div').remove();
                window.open("../rid/rid.aspx?id=2710", "_blank");
                //return false;
            });
        });

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <div>
    <% if (1 == 2)
        { %>
            <div class="col-sm-6 text-center">
                <a id="href_ridx" class="btn btn-info" href="javascript:void(0);" title="The RID (Rating Information Database) gives information on valuations, rating factors, and charges that are levied against this property.">View RID<br />
                    (Rating Information Database)</a>
            </div>
            <div class="col-sm-6 text-center">
                <a id="href_feedback" class="btn btn-info" href="javascript:void(0);" title="Council appreciates your feedback so as to ensure we hold and able to provide full and accurate information.<br />We will get back to you as soon as we can.">Does something not look right?<br />
                    Let us know</a>
            </div>
            <%} %>
            <a id="href_rid" href="javascript:void(0);" title="The RID (Rating Information Database) gives information on valuations,<br />rating factors, and charges that are levied against this property.">View RID<br />
                    (Rating Information Database)</a>
        </div>
    </form>


</body>
</html>
