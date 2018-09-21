<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LTR.aspx.cs" Inherits="DataInnovations.UBC.LTR" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap.min.css")%>" rel="stylesheet" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />

    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>

    <script type="text/javascript">
        // Change JQueryUI plugin names to fix name collision with Bootstrap.
        $.widget.bridge('uitooltip', $.ui.tooltip);
        $.widget.bridge('uibutton', $.ui.button);
    </script>

    <script src="<%: ResolveUrl("~/Dependencies/bootstrap.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Dependencies/jquery.validate.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Dependencies/additional-methods.js")%>"></script>
    <!--additional-methods.min.js-->


    <script type="text/javascript">
        $(document).ready(function () {
            $(document).uitooltip({
                position: {
                    my: "right center",
                    at: "left center"
                }
            });

            $("#form1").validate();

            $(".numeric").keydown(function (event) {
                if (event.shiftKey == true) {
                    event.preventDefault();
                }

                if ((event.keyCode >= 48 && event.keyCode <= 57) ||
                    (event.keyCode >= 96 && event.keyCode <= 105) ||
                    event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 37 ||
                    event.keyCode == 39 || event.keyCode == 46 || (event.keyCode == 190 && 1 == 2)) {
                } else {
                    event.preventDefault();
                }

                if ($(this).val().indexOf('.') !== -1 && event.keyCode == 190)
                    event.preventDefault();
                //if a decimal has been added, disable the "."-button

            });




            $('.inhibitcutcopypaste').bind("cut copy paste", function (e) {
                e.preventDefault();
            });

            //$('[required]').css('border', '1px solid red');
            $('[required]').addClass('required');
        });

    </script>
</head>
<body>
    <div class="container" style="background-color: #FCF7EA">
        <form id="form1" runat="server" class="form-horizontal" role="form">
            <input id="hf_guid" name="hf_guid" type="hidden" value="<%:hf_guid%>" />


            <h1>UBC Learn to Row Weekend
            </h1>
            <h3>Check out the brochures <a href="http://office.datainn.co.nz/ubc/ltr.pdf">here</a></h3>
            <h3>Phone: 0800 002 541 for more information.</h3>

            <div class="form-group">
                <div class="control-label col-sm-4">
                    <h2>Student</h2>
                </div>
            </div>


            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_firstname">First name</label>
                <div class="col-sm-8">
                    <input id="tb_firstname" name="tb_firstname" type="text" class="form-control" value="<%:tb_firstname%>" maxlength="20" required />
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_lastname">Last name</label>
                <div class="col-sm-8">
                    <input id="tb_lastname" name="tb_lastname" type="text" class="form-control" value="<%:tb_lastname%>" maxlength="20" required />
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_emailaddress">Email address</label>
                <div class="col-sm-8">
                    <input id="tb_email" name="tb_email" type="email" class="form-control" value="<%:tb_email%>" maxlength="100" />
                </div>
            </div>
            <!--
            <div class="form-group" id="div_emailconfirm">
                <label class="control-label col-sm-4" for="tb_emailconfirm">Please re-type your email address</label>
                <div class="col-sm-8">
                    <input id="tb_emailconfirm" name="tb_emailconfirm" type="email" class="form-control inhibitcutcopypaste required" autocomplete="off" />
                </div>
            </div>
            -->
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_mobile">Mobile phone</label>
                <div class="col-sm-8">
                    <input id="tb_mobile" name="tb_mobile" type="text" class="form-control" value="<%:tb_mobile%>" maxlength="15" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_landline">Land line</label>
                <div class="col-sm-8">
                    <input id="tb_landline" name="tb_landline" type="text" class="form-control" value="<%:tb_landline%>" maxlength="15" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_school">School</label>
                <div class="col-sm-8">
                    <input id="tb_school" name="tb_school" type="text" readonly="readonly" class="form-control" value="<%:tb_school%>" required maxlength="30" />
                </div>
            </div>


            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_schoolyear">School year</label>
                <div class="col-sm-8">
                    <input id="tb_schoolyear" name="tb_schoolyear" type="text" class="form-control numeric" value="<%:tb_schoolyear%>" required maxlength="2" />
                </div>
            </div>


            <div class="form-group">
                <div class="control-label col-sm-4">
                    <h2>Parent / Caregiver</h2>
                </div>
            </div>


            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_caregivername">Name</label>
                <div class="col-sm-8">
                    <input id="tb_caregivername" name="tb_caregivername" type="text" class="form-control" value="<%:tb_caregivername%>" required maxlength="50" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_caregiveremail">Email address</label>
                <div class="col-sm-8">
                    <input id="tb_caregiveremail" name="tb_caregiveremail" type="email" class="form-control" value="<%:tb_caregiveremail%>" maxlength="30" />
                </div>
            </div>


            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_caregivermobile">Mobile phone</label>
                <div class="col-sm-8">
                    <input id="tb_caregivermobile" name="tb_caregivermobile" type="text" class="form-control" value="<%:tb_caregivermobile%>" maxlength="15" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_caregiverlandline">Land line</label>
                <div class="col-sm-8">
                    <input id="tb_caregiverlandline" name="tb_caregiverlandline" type="text" class="form-control" value="<%:tb_caregiverlandline%>" maxlength="15" />
                </div>
            </div>

              <div class="form-group">
        <label class="control-label col-sm-4" for="dd_coming">Coming</label>
        <div class="col-sm-8">
            <select id="dd_coming" name="dd_coming" class="form-control" required>
                <option></option>
                 <%
                     foreach (string option in coming)
                     {
                         string selected = "";
                         if (option == dd_coming)
                         {
                             selected = " selected";
                         }
                         Response.Write("<option" + selected + ">" + option + "</option>");
                     }

                     %>
            </select>
        </div>
    </div>


            <div class="form-group">
                <div class="col-sm-4">
                </div>
                <div class="col-sm-8">
                    <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info" Text="Submit" />
                </div>
            </div>

        </form>
    </div>
</body>
</html>
