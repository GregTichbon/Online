<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="View.aspx.cs" Inherits="Online.Cemetery.View" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Whanganui District Council - Cemetery Details</title>
    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Content/bootstrap.min.css")%>" rel="stylesheet" />

    <style>
        .view_label {
            text-align: right;
            font-weight: bold;
        }
    </style>

    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Scripts/jquery-2.2.0.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Scripts/bootstrap.min.js")%>"></script>


    <script type="text/javascript">
        $(document).ready(function () {
            $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
                var target = $(e.target).attr("href") // activated tab
                //alert(target);
                if (target == '#div_map') {
                    $('#div_map').show();
                } else {
                    $('#div_map').hide();
                }
            });
                        <% =Online.WDCFunctions.WDCFunctions.googleanalyticstracking(false)%>
        });  //document.ready
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="jumbotron" style="background-color: white">
            <h2>
                <img src="<%: ResolveUrl("~/images/wdclogo.png") %>" />
                Online Services </h2>
        </div>
        <h4>Cemetery View</h4>

        <ul class="nav nav-tabs">
            <li class="active"><a data-toggle="tab" href="#div_information">Information</a></li>
            <asp:Literal ID="lit_tabs" runat="server"></asp:Literal>
        </ul>
        <div class="tab-content">
            <div id="div_information" class="tab-pane fade in active">
                <table class="table table-condensed table-striped table-responsive">
                    <tbody>
                        <asp:Literal ID="lit_table" runat="server"></asp:Literal>
                    </tbody>
                </table>
            </div>
            <div id="div_map" class="fade">
                <div style="text-align: center">
                    <asp:Literal ID="lit_map" runat="server"></asp:Literal>
                </div>
            </div>
            <!--
            <div id="div_test" class="tab-pane fade">
                <div style="text-align: center">
                    <iframe style="width: 100%; height: 400px" src="http://maps.whanganui.govt.nz/IntraMaps/MapControls/EasiMaps/index.html?mapkey=10072&project=WhanganuiMapControls&module=WDCCemeteries&layer=~Cemetery%20Plots&search=false&slider=false"></iframe>
                </div>
            </div>
            -->
            <div id="div_images" class="tab-pane fade">
                <asp:Literal ID="lit_images" runat="server"></asp:Literal>
            </div>
            <div id="div_inscription" class="tab-pane fade">
                <asp:Literal ID="lit_inscription" runat="server"></asp:Literal>
            </div>
            <div id="div_notes" class="tab-pane fade">
            </div>
            <div id="div_feedback" class="tab-pane fade">

                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_feedback">Feedback:</label>
                    <div class="col-sm-8">
                        <textarea id="tb_feedback" name="tb_feedback" maxlength="500" class="form-control"></textarea>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="fu_feedback_files">Please upload files</label><div class="col-sm-8">
                        <input id="fu_feedback_files" name="fu_feedback_files" type="file" multiple="multiple" />
                    </div>
                </div>




                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_feedback_name">Your name:</label>
                    <div class="col-sm-8">
                        <input id="tb_feedback_name" name="tb_feedback_name" type="text" class="form-control" />
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_feedback_relationship">Relationship to the deceased:</label>
                    <div class="col-sm-8">
                        <input id="tb_feedback_relationship" name="tb_feedback_relationship" type="text" class="form-control" />
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_feedback_email">Email address:</label><div class="col-sm-8">
                        <input id="tb_feedback_email" name="tb_feedback_email" maxlength="100" type="email" class="form-control" required />
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-4">
                    </div>
                    <div class="col-sm-8">
                        <input type="button" class="btn btn-info" value="Submit" />

                    </div>
                </div>

            </div>

        </div>


        <asp:Literal ID="lit_debug" runat="server"></asp:Literal>


    </form>
</body>
</html>
