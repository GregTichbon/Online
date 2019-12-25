<%@ Page Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="Check.aspx.cs" Inherits="UBC.People.Check" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap.min.css")%>" rel="stylesheet" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap-datetimepicker.min.css")%>" rel="stylesheet" />

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
    <script src="<%: ResolveUrl("~/Dependencies/moment.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Dependencies/bootstrap-datetimepicker.min.js")%>"></script>
    <!--additional-methods.min.js-->


    <script type="text/javascript">
        $(document).ready(function () {
            $(document).uitooltip({
                position: {
                    my: "right center",
                    at: "left center"
                }
            });


            $("#form1").validate({
                rules: {
                    tb_birthdate: {
                        pattern: /(([0-9])|([0-2][0-9])|([3][0-1])) (Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) \d{4}/
                    }
                },
                messages: {
                    tb_birthdate: {
                        pattern: "Must be in the format of day month year, eg: 23 Jun 1985"
                    }
                }
            });

            $('#div_birthdate').datetimepicker({
                format: 'D MMM YYYY',
                extraFormats: ['D MMM YY', 'D MMM YYYY', 'DD/MM/YY', 'DD/MM/YYYY', 'DD.MM.YY', 'DD.MM.YYYY', 'DD MM YY', 'DD MM YYYY'],
                //daysOfWeekDisabled: [0, 6],
                showClear: true,
                viewDate: false,
                useCurrent: false,
                sideBySide: true,
                viewMode: 'years'
                //,maxDate: moment().add(-1, 'year')
            });

            $("#div_birthdate").on("dp.change", function (e) {
                calculateage(e.date);
            });

            var e = moment($("#div_birthdate").find("input").val());
            calculateage(e);

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



            //$('[required]').css('border', '1px solid red');
            $('[required]').addClass('required');
        });

        function calculateage(e) {
            if (moment().diff(e, 'seconds') < 0) {
                e.date = moment(e).subtract(100, 'years');
                $("#tb_birthdate").val(moment(e).format('D MMM YYYY'));
            }
            var years = moment().diff(e, 'years');
            thisyear = moment().year();
            var jan1 = moment([thisyear, 0, 1]);
            $("#span_age").text('Age: ' + years + ' years, ' + jan1.diff(e, 'years') + ' years at 1 Jan ' + thisyear);
        }

    </script>
    <style type="text/css">
               
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container" style="background-color: #FCF7EA">
        <input id="hf_guid" name="hf_guid" type="hidden" value="<%:hf_guid%>" />
        <h1>Union Boat Club - Person Check
        </h1>
        <div class="row">
            <div class="col-md-8">
                <div class="row form-group">
                    <label class="control-label col-md-6" for="tb_firstname">First name</label>
                    <div class="col-md-6">
                        <input id="tb_firstname" name="tb_firstname" type="text" class="form-control" value="<%:tb_firstname%>" maxlength="20" required />
                    </div>

                </div>
                <div class="row form-group">
                    <label class="control-label col-md-6" for="tb_knownas">Known as</label>
                    <div class="col-md-6">
                        <input id="tb_knownas" name="tb_knownas" type="text" class="form-control" value="<%:tb_knownas%>" maxlength="20" />
                    </div>
                </div>
                <div class="row form-group">
                    <label class="control-label col-md-6" for="tb_lastname">Last name</label>
                    <div class="col-md-6">
                        <input id="tb_lastname" name="tb_lastname" type="text" class="form-control" value="<%:tb_lastname%>" maxlength="20" />
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <img alt="" src="Images/<%: hf_person_id %>.jpg" style="width: 200px" /><br />
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="dd_gender">Gender</label>
            <div class="col-sm-8">
                <select id="dd_gender" name="dd_gender" class="form-control" required>
                    <%= Generic.Functions.populateselect(gender, dd_gender,"None") %>
                </select>
            </div>
        </div>

        <div class="form-group">
            <label for="tb_birthdate" class="control-label col-sm-4">
                Date of birth
            </label>
            <div class="col-sm-8">
                <div class="input-group date" id="div_birthdate">
                    <input id="tb_birthdate" name="tb_birthdate" placeholder="eg: 23 Jun 1985" type="text" class="form-control" value="<%: tb_birthdate %>" />

                    <span class="input-group-addon">
                        <span class="glyphicon glyphicon-calendar"></span>
                    </span>

                    <span id="span_age" class="input-group-addon"></span>
                </div>
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_medical">Medical</label>
            <div class="col-sm-8">
                <textarea id="tb_medical" name="tb_medical" class="form-control"><%: tb_medical %></textarea>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_dietry">Dietry requirements</label>
            <div class="col-sm-8">
                <textarea id="tb_dietry" name="tb_dietry" class="form-control"><%: tb_dietry %></textarea>
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="dd_school">School</label>
            <div class="col-sm-8">
                <select id="dd_school" name="dd_school" class="form-control">
                    <%= Generic.Functions.populateselect(school, dd_school,"") %>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_schoolyear">School year</label>
            <div class="col-sm-8">
                <input id="tb_schoolyear" name="tb_schoolyear" type="text" class="form-control numeric" value="<%:tb_schoolyear%>" maxlength="2" />
            </div>
        </div>
        <!--
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_facebook">Facebook</label>
                        <div class="col-sm-7">
                            <input id="tb_facebook" name="tb_facebook" type="text" class="form-control" value="<%:tb_facebook%>" maxlength="150" /></div><div class="col-sm-1"><a class="btn btn-info" role="button" href="<%: tb_facebook %>" target="UBC_Facebook">Go</a>
                        </div>
                    </div>
                    
          -->

        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_emailaddress">Email address</label>
            <div class="col-sm-8">
                <input id="tb_emailaddress" name="tb_emailaddress" type="text" class="form-control numeric" value="<%:tb_emailaddress%>" maxlength="2" />
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_mobilephone">Mobile phone</label>
            <div class="col-sm-8">
                <input id="tb_mobilephone" name="tb_mobilephone" type="text" class="form-control numeric" value="<%:tb_mobilephone%>" maxlength="2" />
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_residentialaddress">Residential address</label>
            <div class="col-sm-8">
                <textarea id="tb_residentialaddress" name="tb_residentialaddress" class="form-control" rows="6"><%: tb_residentialaddress %></textarea>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_postaladdress">Postal address</label>
            <div class="col-sm-8">
                <textarea id="tb_postaladdress" name="tb_postaladdress" class="form-control" rows="6"><%: tb_postaladdress %></textarea>
            </div>
        </div>

        <!------------------------------------------------------------------------------------------------------>

        <div class="form-group">
            <div class="col-sm-4">
            </div>
            <div class="col-sm-8">
                <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info" Text="Submit" />
            </div>
        </div>
    </div>

</asp:Content>
