<%@ Page Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="UBC.People.Register" %>

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



    <script type="text/javascript">
        $(document).ready(function () {
            $(document).uitooltip({
                position: {
                    my: "right center",
                    at: "left center"
                },
                content: function () {
                    return $(this).prop('title');
                }
            });

            $('#qm_membershiptype').prop('title', '<table><tr><td>Full</td><td>$400.00*</td></tr><tr><td>Club Recreation</td><td>$300.00</td></tr><tr><td>Novice</td><td>$300.00*</td></tr><tr><td>Coxswain</td><td>$0.00*</td></tr><tr><td>* Rowing NZ Competition License Fee</td><td>$96.00</td></tr></table>');

            if ($('#dd_school').val() != "") {
                $("#div_schoolyear").show();
            }

            $('#qm_boatinstorage').prop('title', 'If you have a boat and wish to store it at the club, please contact <a href="mailto:secretary@unionboatclub.co.nz">secretary@unionboatclub.co.nz</a>');

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

            $('#btn_addphone').click(function () {
                tr = $('#tbl_phone>tbody>tr:first').clone();
                $('#tbl_phone>tbody').append(tr);
                $(tr).show();
            })

            $('#btn_addparent').click(function () {
                tr = $('#tbl_parent>tbody>tr:first').clone();
                $('#tbl_parent>tbody').append(tr);
                $(tr).show();
                tr = $('#tbl_parent>tbody>tr:nth-child(2)').clone();
                $('#tbl_parent>tbody').append(tr);
                $(tr).show();
            })

            $('body').on('click', '.btn_parent_add_phone', function () {
                alert('to do');
                tr = $('#tbl_parent_phone>tbody>tr:first').clone();
                $('#tbl_parent_phone>tbody').append(tr);
                $(tr).show();
            });

            $('body').on('click', '.btn_parent_remove_phone', function () {
                if (confirm('Are you sure you want to remove this phone?')) {
                    tr = $(this).closest('tr');
                    $(tr).remove();
                }
            });

            $('body').on('click', '.btn_parent_add_email', function () {
                alert('to do');
                tr = $('#tbl_parent_email>tbody>tr:first').clone();
                $('#tbl_parent_email>tbody').append(tr);
                $(tr).show();
            });

            $('body').on('click', '.btn_parent_remove_email', function () {
                if (confirm('Are you sure you want to remove this email address?')) {
                    tr = $(this).closest('tr');
                    $(tr).remove();
                }
            });

            $('body').on('click', '.btn_phone_remove', function () {
                if (confirm('Are you sure you want to remove this phone?')) {
                    $(this).closest('tr').remove();
                }
            });

            $('body').on('click', '.btn_parent_remove', function () {
                if (confirm('Are you sure you want to remove this person?')) {
                    tr = $(this).closest('tr');
                    nexttr = $(tr).next('tr');
                    $(nexttr).remove();
                    $(tr).remove();
                }
            });


            $('#dd_invoicetype').change(function () {
                switch ($(this).val()) {
                    case "Email":
                        $('#div_invoiceaddress').show();
                        $('#span_invoiceaddress').text('Email address');
                        break;
                    case "Text":
                        $('#div_invoiceaddress').show();
                        $('#span_invoiceaddress').text('Mobile phone number');
                        break;
                    case "Mail":
                        $('#div_invoiceaddress').show();
                        $('#span_invoiceaddress').text('Postal address');
                        break;
                    case "Hand deliver":
                        $('#div_invoiceaddress').hide();
                        break;
                    default:
                    // code block
                }

            })

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

            $('#dd_school').change(function () {
                school = $(this).val();
                //alert('*' + school + '*');
                if (school != "") {
                    $("#div_schoolyear").show();
                } else {
                    $("#div_schoolyear").hide();
                    $("#dd_schoolyear").prop('selectedIndex', 0);
                }
            });

            $('#tb_birthdate').change(function () {

            });


            //$('[required]').css('border', '1px solid red');
            //$('[required]').addClass('required');
        });

        function calculateage(e) {
            if (moment().diff(e, 'seconds') < 0) {
                e.date = moment(e).subtract(100, 'years');
                $("#tb_birthdate").val(moment(e).format('D MMM YYYY'));
            }
            var years = moment().diff(e, 'years');
            thisyear = moment().year();
            var jan1 = moment([thisyear, 1, 1]);
            $("#span_age").text('Age: ' + years + ' years, ' + jan1.diff(e, 'years') + ' years at 1 Jan ' + thisyear);
            if (years < 18) {
                $('#div_parent').show();
            } else {
                $('#div_parent').hide();
                $('#tb_parentcaregiver1').val('');
                $('#tb_parentcaregiver1mobilephone').val('');
                $('#tb_parentcaregiver1emailaddress').val('');
                $('#tb_parentcaregiver2').val('');
                $('#tb_parentcaregiver2mobilephone').val('');
                $('#tb_parentcaregiver2emailaddress').val('');

            }
        }

    </script>
    <style type="text/css">
               
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <input id="hf_guid" name="hf_guid" type="hidden" value="<%:hf_guid%>" />

    <div class="container" style="background-color: #B1C9E6">
        <p></p>
        <table style="width: 100%">
            <tr>
                <td style="width: 350px">
                    <img src="http://private.unionboatclub.co.nz/dependencies/images/Logo-Page-Head.png" style="width: 100%" /></td>
                <td style="text-align: center">
                    <h1>Registration / Renewal</h1>
                    <h2>1 Sep 2019 - 30 Aug 2020</h2>
                </td>
            </tr>
        </table>
        <p></p>
        <hr />
        <p></p>
        <div class="panel panel-danger">
            <div class="panel-body">
                Please fill in the form below. Union Boat Club will use the information collected below to:
        <ul>
            <li>Register you as a member of Union Boat Club.</li>
            <li>Register you with Rowing New Zealand. (required if you are competing at any NZ regattas)</li>
            <li>Keep you informed on upcoming events, regatta and news updates.</li>
        </ul>
                Note: Registration Forms will need to be completed on an annual basis. All information will be kept confidential and not passed onto any third party.
            </div>
        </div>
        <div class="panel panel-danger">
            <div class="panel-heading">Rower</div>
            <div class="panel-body">

                <!------------------------------------------------------>
                <div class="form-group">
                    <label class="control-label col-sm-5" for="tb_firstname">First name</label>
                    <div class="col-sm-7">
                        <input id="tb_firstname" name="tb_firstname" type="text" class="form-control" value="<%:tb_firstname%>" maxlength="20" required />
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-5" for="tb_lastname">Last name</label>
                    <div class="col-sm-7">
                        <input id="tb_lastname" name="tb_lastname" type="text" class="form-control" value="<%:tb_lastname%>" maxlength="30" />
                    </div>
                </div>


                <div class="form-group">
                    <label class="control-label col-sm-5" for="dd_gender">Gender</label>
                    <div class="col-sm-7">
                        <select id="dd_gender" name="dd_gender" class="form-control" required>
                            <option></option>
                            <%= Generic.Functions.populateselect(gender, dd_gender,"None") %>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label for="tb_birthdate" class="control-label col-sm-5">
                        Date of birth
                    </label>
                    <div class="col-sm-7">
                        <div class="input-group date" id="div_birthdate">
                            <input id="tb_birthdate" name="tb_birthdate" placeholder="eg: 23 Jun 1985" type="text" class="form-control" value="<%: tb_birthdate %>" required />

                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-calendar"></span>
                            </span>

                            <span id="span_age" class="input-group-addon"></span>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-5" for="dd_school">School (if applicable)</label>
                    <div class="col-sm-7">
                        <select id="dd_school" name="dd_school" class="form-control">
                            <%= Generic.Functions.populateselect(school, dd_school,"") %>
                        </select>
                    </div>
                </div>
                <div id="div_schoolyear" class="form-group" style="display: none">
                    <label class="control-label col-sm-5" for="dd_schoolyear">School year</label>
                    <div class="col-sm-7">
                        <select id="dd_schoolyear" name="dd_schoolyear" class="form-control" required>
                            <%= Generic.Functions.populateselect(schoolyear, dd_schoolyear,"") %>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-5" for="tb_medical">
                        <img src="../Dependencies/images/questionsmall.png" data-toggle="tooltip" data-html="true" title="Please provide any information that maybe useful, such as asthma, seizures, etc" />
                        Medical needs</label>
                    <div class="col-sm-7">
                        <textarea id="tb_medical" name="tb_medical" class="form-control" maxlength="500"><%: tb_medical %></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-5" for="tb_dietary">
                        <img src="../Dependencies/images/questionsmall.png" data-toggle="tooltip" data-html="true" title="This information is useful for catering at regattas and other catered events." />
                        Special Dietary requirements</label>
                    <div class="col-sm-7">
                        <textarea id="tb_dietary" name="tb_dietary" class="form-control" maxlength="500"><%: tb_dietary %></textarea>
                    </div>
                </div>


                <div class="form-group">
                    <label class="control-label col-sm-5" for="tb_emailaddress">Email address</label>
                    <div class="col-sm-7">
                        <input id="tb_emailaddress" name="tb_emailaddress" type="email" class="form-control" maxlength="100" required value="<%:tb_emailaddress%>" />
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-5" for="tb_homephone">Phone</label>
                    <div class="col-sm-7">
                        <table id="tbl_phone" class="table table-condensed table-striped table-bordered">
                            <thead>
                                <tr>
                                    <th>Number</th>
                                    <th>Type</th>
                                    <th>Note</th>
                                    <th style="width: 10px">
                                        <input type="button" id="btn_addphone" class="btn btn-info btn-sm" value="Add" /></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr style="display: none">
                                    <td>
                                        <input type="text" class="form-control" name="phone_number_" /></td>
                                    <td>
                                        <select class="form-control" name="phone_type_">
                                            <option></option>
                                            <option>Home</option>
                                            <option>Work</option>
                                            <option>Mobile</option>
                                            <option>Other</option>
                                        </select>
                                    </td>
                                    <td>
                                        <input type="text" class="form-control" name="phone_note_" /></td>
                                    <td>
                                        <input type="button" value="Remove" class="btn_phone_remove btn btn-info btn-sm" /></td>
                                </tr>
                                <tr>
                                    <td>x</td>
                                    <td>x</td>
                                    <td>x</td>
                                    <td>
                                        <input type="button" value="Remove" class="btn_phone_remove btn btn-info btn-sm" /></td>
                                </tr>
                                <tr>
                                    <td>x</td>
                                    <td>x</td>
                                    <td>x</td>
                                    <td>
                                        <input type="button" value="Remove" class="btn_phone_remove btn btn-info btn-sm" /></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div style="display: none">

                    <div class="form-group">
                        <label class="control-label col-sm-5" for="tb_homephone">Home phone</label>
                        <div class="col-sm-7">
                            <input id="tb_homephone" name="tb_homephone" type="text" class="form-control numeric" value="<%:tb_homephone%>" maxlength="20" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-sm-5" for="tb_mobilephone">Mobile phone</label>
                        <div class="col-sm-7">
                            <input id="tb_mobilephone" name="tb_mobilephone" type="text" class="form-control numeric" value="<%:tb_mobilephone%>" maxlength="20" />
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-5" for="tb_residentialaddress">Home address</label>
                    <div class="col-sm-7">
                        <textarea id="tb_residentialaddress" name="tb_residentialaddress" class="form-control" rows="6" maxlength="500" required><%: tb_residentialaddress %></textarea>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-5" for="dd_school">
                        <img src="../Dependencies/images/questionsmall.png" data-toggle="tooltip" data-html="true" title="Rowers should be comfortable swimming in open water and able to swim 50m in light clothes unassisted. If you are unsure or not confident with your swimming ability please let us know. Your safety is most important to us." />
                        Swimming ability</label>
                    <div class="col-sm-7">

                        <select id="dd_swimmer" name="dd_swimmer" class="form-control" required>
                            <%= Generic.Functions.populateselect(swimmer, dd_swimmer,"") %>
                        </select>

                    </div>
                </div>
                <!------------------------------------------------------>

            </div>
        </div>


        <div class="panel panel-danger" id="div_parent" style="display: nonex">
            <div class="panel-heading">Parent/Caregivers</div>
            <div class="panel-body">
                <table id="tbl_parent" class="table table-condensed table-striped table-bordered">
                    <thead>
                        <tr>
                            <th>First & last names</th>
                            <th>Relationship</th>
                            <th>Email address</th>
                            <th>Note</th>
                            <th style="width: 10px">
                                <input type="button" id="btn_addparent" class="btn btn-info btn-sm" value="Add Person" /></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr style="display: none">
                            <td>
                                <input type="text" class="form-control" name="parent_name_" /></td>
                            <td>
                                <select class="form-control" name="parent_relationship_">
                                    <option></option>
                                    <option>Mother</option>
                                    <option>Father</option>
                                    <option>Caregiver</option>
                                    <option>Other</option>
                                </select>
                            </td>
                            <td>
                                <input type="text" class="form-control" name="parent_email_" /></td>
                            <td>
                                <input type="text" class="form-control" name="parent_note_" /></td>
                            <td>
                                <input type="button" value="Remove Person" class="btn_parent_remove btn btn-info btn-sm" /></td>
                        </tr>
                        <!--
                        <tr style="display: none">
                            <td colspan="5">
                                <input type="button" value="Edit" class="btn_parent_phone_edit btn btn-info btn-sm" />
                                Phone Details: xxxxxx</td>
                        </tr>   -->
                        <tr style="display: none">
                            <td colspan="5">
                                <table id="tbl_parent_phone" class="table table-condensed table-bordered">
                                    <thead>
                                        <tr>
                                            <th>Number</th>
                                            <th>Type</th>
                                            <th>Note</th>
                                            <th style="width: 10px">
                                                <input type="button" class="btn_parent_add_phone btn btn-info btn-sm" value="Add Phone" /></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr style="display: none">
                                            <td>
                                                <input type="text" class="form-control" name="phone_number_" /></td>
                                            <td>
                                                <select class="form-control" name="parent_phone_type_">
                                                    <option></option>
                                                    <option>Home</option>
                                                    <option>Work</option>
                                                    <option>Mobile</option>
                                                    <option>Other</option>
                                                </select>
                                            </td>
                                            <td>
                                                <input type="text" class="form-control" name="parent_phone_note_" /></td>
                                            <td>
                                                <input type="button" value="Remove Phone" class="btn_parent_remove_phone btn btn-info btn-sm" /></td>
                                        </tr>

                                    </tbody>
                                </table>
                            </td>
                        </tr>

                        <tr style="display: none">
                            <td colspan="5">
                                <table id="tbl_parent_email" class="table table-condensed table-bordered">
                                    <thead>
                                        <tr>
                                            <th>Email Address</th>
                                            <th>Note</th>
                                            <th style="width: 10px">
                                                <input type="button" class="btn_parent_add_email btn btn-info btn-sm" value="Add Address" /></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr style="display: none">
                                            <td>
                                                <input type="text" class="form-control" name="email_address_" /></td>
                                            <td>
                                                <input type="text" class="form-control" name="parent_email_note_" /></td>
                                            <td>
                                                <input type="button" value="Remove email" class="btn_parent_remove_email btn btn-info btn-sm" /></td>
                                        </tr>

                                    </tbody>
                                </table>
                            </td>
                        </tr>


                    </tbody>
                </table>


                <div style="display: none">
                    <div class="form-group">
                        <label class="control-label col-sm-5" for="tb_parentcaregiver1">Name (1)</label>
                        <div class="col-sm-7">
                            <input id="tb_parentcaregiver1" name="tb_parentcaregiver1" type="text" class="form-control" value="<%:tb_parentcaregiver1%>" maxlength="100" required />
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-sm-5" for="tb_parentcaregiver1mobilephone">Mobile phone (1)</label>
                        <div class="col-sm-7">
                            <input id="tb_parentcaregiver1mobilephone" name="tb_parentcaregiver1mobilephone" type="text" class="form-control numeric" value="<%:tb_parentcaregiver1mobilephone%>" required maxlength="20" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-sm-5" for="tb_parentcaregiver1emailaddress">Email address (1)</label>
                        <div class="col-sm-7">
                            <input id="tb_parentcaregiver1emailaddress" name="tb_parentcaregiver1emailaddress" type="email" class="form-control" maxlength="100" required value="<%:tb_parentcaregiver1emailaddress%>" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-sm-5" for="tb_parentcaregiver">Name (2)</label>
                        <div class="col-sm-7">
                            <input id="tb_parentcaregiver2" name="tb_parentcaregiver2" type="text" class="form-control" value="<%:tb_parentcaregiver2%>" maxlength="100" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-sm-5" for="tb_parentcaregiver2mobilephone">Mobile phone (2)</label>
                        <div class="col-sm-7">
                            <input id="tb_parentcaregiver2mobilephone" name="tb_parentcaregiver2mobilephone" type="text" class="form-control numeric" value="<%:tb_parentcaregiver2mobilephone%>" maxlength="20" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-5" for="tb_parentcaregiver2emailaddress">Email address (2)</label>
                        <div class="col-sm-7">
                            <input id="tb_parentcaregiver2emailaddress" name="tb_parentcaregiver2emailaddress" type="email" class="form-control" maxlength="100" value="<%:tb_parentcaregiver2emailaddress%>" />
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <div class="panel panel-danger">
            <div class="panel-heading">Financial</div>
            <div class="panel-body">
                <div class="form-group">
                    <label class="control-label col-sm-5" for="tb_invoicerecipient">
                        Who should we address invoices/statements etc to?</label>
                    <div class="col-sm-7">
                        <input id="tb_invoicerecipient" name="tb_invoicerecipient" type="text" class="form-control" value="<%:tb_previousclub%>" maxlength="100" />
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-5" for="dd_invoicetype">
                        How should we send invoices/statements?</label>
                    <div class="col-sm-7">
                        <select name="dd_invoicetype" id="dd_invoicetype" class="form-control" required>
                            <option></option>
                            <option value="Email">Email</option>
                            <option value="Text">Text</option>
                            <option value="Mail">Mail</option>
                            <option value="Hand deliver">Hand deliver</option>
                        </select>
                    </div>
                </div>

                <div class="form-group" id="div_invoiceaddress">
                    <label class="control-label col-sm-5" for="tb_invoiceaddress">
                        <span id="span_invoiceaddress">Address</span></label>
                    <div class="col-sm-7">
                        <textarea id="tb_invoiceaddress" name="tb_invoiceaddress" class="form-control" maxlength="100"><%:tb_previousclub%></textarea>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-5" for="tb_invoicenote">
                        Note</label>
                    <div class="col-sm-7">
                        <textarea id="tb_invoicenote" name="tb_invoicenote" class="form-control" maxlength="100"><%:tb_previousclub%></textarea>
                    </div>
                </div>

            </div>
        </div>


        <div class="panel panel-danger">
            <div class="panel-heading">Membership</div>
            <div class="panel-body">




                <div class="form-group">
                    <label class="control-label col-sm-5" for="dd_membershiptype">
                        <img id="qm_membershiptype" src="../Dependencies/images/questionsmall.png" data-toggle="tooltip" data-html="true" title="" />
                        Membership type</label>
                    <div class="col-sm-7">
                        <select name="dd_invoicetype" id="dd_membershiptype" class="form-control" required>
                            <option></option>
                            <option value="Full Email">Full Membership</option>
                            <option value="Club Recreation Membership">Club Recreation Membership</option>
                            <option value="Novice Membership">Novice Membership</option>
                            <option value="Coxswain Membership">Coxswain Membership</option>
                            <option value="Life Membership">Life Membership</option>
                            <option value="Honorary Membership">Honorary Membership</option>
                            <!--<option value="Non-Rower/Supporter">Non-Rower/Supporter</option>-->
                            <option value="Gym Membership Only">Gym Membership Only</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-5" for="dd_familydiscount">
                        <img src="../Dependencies/images/questionsmall.png" data-toggle="tooltip" data-html="true" title="The club offers discounts to families with multiple members." />
                        Do you have other immediate family who are members of Union Boat Club?</label>
                    <div class="col-sm-7">
                        <select id="dd_familydiscount" name="dd_familydiscount" class="form-control" required>
                            <option></option>
                            <option>No</option>
                            <option>Yes</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-5" for="tb_previousclub">
                        <img src="../Dependencies/images/questionsmall.png" data-toggle="tooltip" data-html="true" title="If you are joining Union Boat Club from another club, you may need to provide a Clearance/Transfer from your previous club. This form will need to be acknowledged and signed by our Club Secretary." />
                        Previous club (if applicable)</label>
                    <div class="col-sm-7">
                        <input id="tb_previousclub" name="tb_previousclub" type="text" class="form-control" value="<%:tb_previousclub%>" maxlength="100" />

                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-5" for="dd_boatinstorage">
                        <img id="qm_boatinstorage" src="../Dependencies/images/questionsmall.png" data-toggle="tooltip" data-html="true" title="" />
                        Do you currently have a boat stored at the club and want to continue to store it for this season?</label>
                    <div class="col-sm-7">
                        <select id="dd_boatinstorage" name="dd_boatinstorage" class="form-control" required>
                            <option></option>
                            <option>No</option>
                            <option>Yes</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>


        <!------------------------------------------------------------------------------------------------------>

        <div class="panel panel-danger">
            <div class="panel-heading">Declaration</div>
            <div class="panel-body">
                <ul>
                    <li>I hereby apply for membership of the Union Boat Club.</li>
                    <li>I agree to be bound by the rules of the Club and to pay the annual subscription fees as set at the Annual General Meeting.</li>
                    <li>I also agree to pay such additional fees and levies which may be set from time to time to cover such items as: regatta entries, racing seat fees and travel expenses.</li>
                    <li>I understand that there may be risk of personal injury involved in participating in the sport of rowing and hereby indemnify the Union Boat Club, its Executive, fellow members and coaches from any liability.</li>
                </ul>
                <div class="form-group">
                    <label class="control-label col-sm-5" for="dd_agreement">I agree with the above statements</label>
                    <div class="col-sm-7">
                        <select id="dd_agreement" name="dd_agreement" class="form-control" required>
                            <option></option>
                            <option>Yes</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-5" for="dd_correspondence">I also agree, for my information to held in the Union Boat Club database to receive email and text messages from the club.</label>
                    <div class="col-sm-7">
                        <select id="dd_correspondence" name="dd_correspondence" class="form-control" required>
                            <option></option>
                            <option>Yes</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>

        <!------------------------------------------------------------------------------------------------------>

        <div class="form-group">
            <div class="col-sm-5">
            </div>
            <div class="col-sm-7">
                <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info" Text="Submit" />
            </div>
        </div>


    </div>
</asp:Content>


