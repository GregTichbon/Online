<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PropertyInformationFeedback.aspx.cs" Inherits="Online.General.PropertyInformationFeedback" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Content/bootstrap.min.css")%>" rel="stylesheet" />
    <!--<link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />-->
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css" />
    <!--1.11.4-->

    <link href="<%: ResolveUrl("~/Content/main.css")%>" rel="stylesheet" />


    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Scripts/jquery-2.2.0.min.js")%>"></script>

    <script src="<%: ResolveUrl("~/Scripts/bootstrap.min.js")%>"></script>

    <script type="text/javascript">
        //http://www.ryadel.com/en/using-jquery-ui-bootstrap-togheter-web-page
        // Change JQueryUI plugin names to fix name collision with Bootstrap.
        //$.widget.bridge('uitooltip', $.ui.tooltip);
        //$.widget.bridge('uibutton', $.ui.button);
        //$.fn.bstooltip = $.fn.tooltip;
        //$.fn.bsbutton = $.fn.button;
        $.fn.bsbutton = $.fn.button.noConflict();
        $.fn.bstooltip = $.fn.tooltip.noConflict();
    </script>

    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
    <!--1.11.4-->



    <script src="https://eservices.wanganui.govt.nz/scripts/init.js" type="text/javascript"></script>
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

    <script type="text/javascript">
        $(document).ready(function () {
            $(document).tooltip({    //this is the ui tooltip
                content: function () {
                    return this.getAttribute("title");
                },
                position: {
                    my: "right center",
                    at: "left center"
                }
            });


            $('.inhibitcutcopypaste').bind("cut copy paste", function (e) {
                e.preventDefault();
            });

            //$('[required]').css('border', '1px solid red');
            $('[required]').addClass('required');
        });

    </script>
    <script type="text/javascript">

        $(document).ready(function () {

            $("#form1").validate({
                rules: {
                    clientsideonly_tb_emailconfirm: {
                        equalTo: '#tb_emailaddress'
                    }
                },
                messages: {
                    clientsideonly_tb_emailconfirm: {
                        equalTo: 'This must be the same as the email address above'
                    }
                }
            });
        });
    </script>
</head>
<body>
    <div class="container" style="background-color: #FCF7EA">
        <form runat="server" id="form1" class="form-horizontal" role="form">
            <asp:FileUpload ID="fu_dummy" runat="server" Style="display: none" />
            <!--Forces form to be rendered with enctype="multipart/form-data" -->
            <div>
                <h1>Property Feedback
                </h1>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_reference">Reference number:</label>
                    <div class="col-sm-8">
                        <asp:TextBox ID="tb_reference" name="tb_reference" runat="server" ReadOnly="true"></asp:TextBox>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_property">Property:</label>
                    <div class="col-sm-8">
                        <asp:TextBox ID="tb_property" name="tb_property" runat="server" ReadOnly="true"></asp:TextBox>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_applicant">Name</label>
                    <div class="col-sm-8">
                        <input type="text" id="tb_applicant" name="tb_applicant" class="form-control" maxlength="100" required="required" />
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_emailaddress">Email address</label>
                    <div class="col-sm-8">
                        <input id="tb_emailaddress" name="tb_emailaddress" type="email" class="form-control inhibitcutcopypaste" required="required" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_emailconfirm">Please re-type your email address</label>
                    <div class="col-sm-8">
                        <input id="tb_emailconfirm" name="clientsideonly_tb_emailconfirm" type="email" class="form-control inhibitcutcopypaste" required="required" autocomplete="off" />
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_contactphone">
                        Phone details
            <img src="../Images/questionsmall.png" title="Please provide us with your phone details so that we can contact you if need be." /></label>
                    <div class="col-sm-8">
                        <textarea id="tb_contactphone" name="tb_contactphone" class="form-control" rows="4" maxlength="500" required="required"></textarea>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_detail">
                        Detail of data to be reviewed
            <img src="../Images/questionsmall.png" title="Please provide as much detail as possible to help us find, research, review and correct the information." /></label>
                    <div class="col-sm-8">
                        <textarea id="tb_detail" name="tb_detail" class="form-control" rows="4" maxlength="500" required="required"></textarea>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_detail">
                        Attachments
            <img src="../Images/questionsmall.png" title="Please feel free to upload any attachments, documents, photos etc that will also help in ensuring the Council has correct information." /></label>
                    <div class="col-sm-8">
                        <input id="fu_attachments" name="fu_attachments" type="file" multiple="multiple" />

                    </div>
                </div>

                <div class="form-group">
                    <div class="col-sm-4">
                    </div>
                    <div class="col-sm-8">
                        <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info" Text="Submit" />
                    </div>
                </div>















            </div>
        </form>
    </div>
</body>
</html>
