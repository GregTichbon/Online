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

            var phonectr = <%=phonectr%>;
            var parentctr = <%=parentctr%>;
            var parentphonectr = <%=parentphonectr%>;

            $(document).uitooltip({
                position: {
                    my: "right center",
                    at: "left center"
                },
                content: function () {
                    return $(this).prop('title');
                }
            });

            $('#qm_membershiptype').prop('title', '<table><tr><td>Full (Competitive)</td><td>$400.00*</td></tr><tr><td>Club - Recreation</td><td>$300.00</td></tr><tr><td>First Year Rower</td><td>$300.00*</td></tr><tr><td>Coxswain</td><td>$0.00*</td></tr><tr><td>Non-Resident Rower</td><td>$0.00*</td></tr><tr><td>Gym Only</td><td>$100.00</td></tr><tr><td>Casual</td><td>$50.00^</td></tr><tr><td>* Rowing NZ Competition License Fee</td><td>TBA</td></tr><tr><td colspan=\"2\">^ $10.00 per row and $5.00 per gym session</tr></table>');
            //Full (Competitive)", "Club - Recreation", "First Year Rower", "Coxswain", "Non-Resident Rower", "Gym Only", "Casual" };
            if ($('#school').val() != "") {
                $("#div_schoolyear").show();
            }

            $('#qm_boatinstorage').prop('title', 'If you have a boat and wish to store it at the club, please contact <a href="mailto:secretary@unionboatclub.co.nz">secretary@unionboatclub.co.nz</a>');

            $("#form1").validate({
                ignore: ":hidden:not('.validate')",
                rules: {
                    birthdate: {
                        pattern: /(([0-9])|([0-2][0-9])|([3][0-1])) (Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) \d{4}/
                    },
                    phone_validator: {
                        phone_validator: true
                    },
                    parent_validator: {
                        parent_validator: true
                    }
                },
                messages: {
                    birthdate: {
                        pattern: "Must be in the format of day month year, eg: 23 Jun 1985"
                    }
                }/*,
                errorPlacement: function (error, element) {
                    var placement = $(element).data('errorplacement');
                    if (placement) {
                        $(placement).append(error)
                    } else {
                        error.insertAfter(element);
                    }
                }*/
            });

           

            $.validator.addMethod("phone_validator", function (value, element) {
                if ($('#tbl_phone>tbody>tr').length > 1) {
                    return true;
                } else {
                    return false;
                }

            }, "You must enter at least one phone number.");

            $.validator.addMethod("parent_validator", function (value, element) {
                //alert($('#div_parent').is(":hidden"));
                //alert($('#tbl_parent>tbody>tr').length);
                if($('#div_parent').is(":hidden") || $('#tbl_parent>tbody>tr').length > 2) {
                    return true;
                } else {
                    return false;
                }
            }, "You must enter at least one parent/caregiver and a phone number");

            $('#btn_addphone').click(function () {
                phonectr++;
                tr = $('#tbl_phone>tbody>tr:first').clone();
                $(tr).find('td :input:not(:button)').each(function () {
                    id = $(this).data('name');
                    //lastdelim = id.lastIndexOf("_");
                    //newid = id.substring(0, lastdelim + 1) + phonectr;
                    newid = id + phonectr;
                    $(this).prop('name', newid);
                })

                $('#tbl_phone>tbody').append(tr);
                $(tr).show();
            })

            $('#btn_addparent').click(function () {
                parentctr++;
                tr = $('#tbl_parent>tbody>tr:first').clone();

                $(tr).find('td :input:not(:button)').each(function () {
                    id = $(this).data('name');
                    newid = id + parentctr;
                    $(this).prop('name', newid);
                })
                $('#tbl_parent>tbody').append(tr);
                $(tr).show();

                parentphonectr++;
                tr = $('#tbl_parent>tbody>tr:nth-child(2)').clone();
                table = $(tr).find('table');
                $(table).prop("id", "tbl_parent_ctr_" + parentctr);

                $(tr).find('td :input:not(:button)').each(function () {
                    id = $(this).data('name');
                    newid = id + parentctr + "_" + parentphonectr;
                    $(this).prop('name', newid);
                })

                $('#tbl_parent>tbody').append(tr);
                $(tr).show();

            })

            $('body').on('click', '.btn_parent_aphone', function () {
                table = $(this).closest('table');
                trthis = $(table).find('tr:last');
                parentphonectr++;
                tr = $('#tbl_parent_phone>tbody>tr:first').clone();
                table = $(trthis).closest('table');
                var thisparentctr = $(table).prop('id').substring(15);
                $(tr).find('td :input:not(:button)').each(function () {
                    id = $(this).data('name');
                    newid = id + thisparentctr + "_" + parentphonectr;
                    $(this).prop('name', newid);
                })
                tr.insertAfter($(trthis));
                $(tr).show();
            });

            $('body').on('click', '.btn_parent_remove_phone', function () {
                tr = $(this).closest('tr');
                //alert($(tr).closest('table').find('tbody tr').length);
                //if ($(tr).closest('table').find('tbody tr').length == 1) {
                //    alert('You must have at least one parent');
               // } else {
                    if (confirm('Are you sure you want to remove this phone?')) {
                        $(tr).remove();
                    }
                //}
            });

            /*
            $('body').on('click', '.btn_parent_aemail', function () {
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
            */

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

            $('#invoicetype').change(function () {
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

            $('#school').change(function () {
                school = $(this).val();
                //alert('*' + school + '*');
                if (school != "") {
                    $("#div_schoolyear").show();
                } else {
                    $("#div_schoolyear").hide();
                    $("#schoolyear").prop('selectedIndex', 0);
                }
            });

            $('#birthdate').change(function () {

            });

            $('.submit').click(function () {
                $('.processing').show();
            });

            //$('[required]').css('border', '1px solid red');
            //$('[required]').addClass('required');
        });

        function calculateage(e) {
            if (moment().diff(e, 'seconds') < 0) {
                e.date = moment(e).subtract(100, 'years');
                $("#birthdate").val(moment(e).format('D MMM YYYY'));
            }
            var years = moment().diff(e, 'years');
            thisyear = moment().year();
            var jan1 = moment([thisyear, 0, 1]);
            $("#span_age").text('Age: ' + years + ' years, ' + jan1.diff(e, 'years') + ' years at 1 Jan ' + thisyear);
            if (years < 18) {
                $('#div_parent').show();
                $('#invoicerecipient').rules('add',  { required: true });
                $('#invoicetype').rules('add',  { required: true });
                $('#invoiceaddress').rules('add',  { required: true });
            } else {
                $('#div_parent').hide();
                $('#invoicerecipient').rules('remove', 'required')
                $('#invoicetype').rules('remove', 'required')
                $('#invoiceaddress').rules('remove', 'required')
            }
        }

    </script>
    <style type="text/css">
        .validate {
            display: none;
        }

        .processing {
            margin: auto;
            width: 50%;
            display: none;
        }
               
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <input id="guid" name="guid" type="hidden" value="<%:guid%>" />
    
    <img src="../Dependencies/Images/processing2.gif" class="processing" />
    <div class="container" style="background-color: #B1C9E6">
        <p></p>
        <table style="width: 100%">
            <tr>
                <td style="width: 350px">
                    <img src="http://private.unionboatclub.co.nz/dependencies/images/Logo-Page-Head.png" style="width: 100%" /></td>
                <td style="text-align: center">
                    <h1>Registration / Renewal</h1>
                    <h2>1 Sep 2020 - 30 Aug 2021</h2>
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
                 <div class="col-sm-12"><img id="img_photo" alt="" src="Images/<%: person_id %>.jpg" style="float:left;width:200px" /></div>
                <div class="form-group">
                    <label class="control-label col-sm-5" for="firstname">First name</label>
                    <div class="col-sm-7">
                        <input id="firstname" name="firstname" type="text" class="form-control" value="<%:firstname%>" maxlength="20" required />
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-5" for="lastname">Last name</label>
                    <div class="col-sm-7">
                        <input id="lastname" name="lastname" type="text" class="form-control" value="<%:lastname%>" maxlength="30" required />
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-5" for="gender">Gender</label>
                    <div class="col-sm-7">
                        <select id="gender" name="gender" class="form-control" required>
                            <option></option>
                            <%= Generic.Functions.populateselect(gendervalues, gender,"None") %>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label for="birthdate" class="control-label col-sm-5">
                        Date of birth
                    </label>
                    <div class="col-sm-7">
                        <div class="input-group date" id="div_birthdate">
                            <input id="birthdate" name="birthdate" placeholder="eg: 23 Jun 1985" type="text" class="form-control" value="<%: birthdate %>" required />

                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-calendar"></span>
                            </span>

                            <span id="span_age" class="input-group-addon"></span>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-5" for="school">School (if applicable)</label>
                    <div class="col-sm-7">
                        <select id="school" name="school" class="form-control">
                            <%= Generic.Functions.populateselect(schoolvalues, school,"") %>
                        </select>
                    </div>
                </div>
                <div id="div_schoolyear" class="form-group" style="display: none">
                    <label class="control-label col-sm-5" for="schoolyear">School year</label>
                    <div class="col-sm-7">
                        <select id="schoolyear" name="schoolyear" class="form-control" required>
                            <%= Generic.Functions.populateselect(schoolyearvalues, schoolyear,"") %>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-5" for="medical">
                        <img src="../Dependencies/images/questionsmall.png" data-toggle="tooltip" data-html="true" title="Please provide any information that maybe useful, such as asthma, seizures, etc" />
                        Medical needs</label>
                    <div class="col-sm-7">
                        <textarea id="medical" name="medical" class="form-control" maxlength="500"><%: medical %></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-5" for="dietary">
                        <img src="../Dependencies/images/questionsmall.png" data-toggle="tooltip" data-html="true" title="This information is useful for catering at regattas and other catered events." />
                        Special Dietary requirements</label>
                    <div class="col-sm-7">
                        <textarea id="dietary" name="dietary" class="form-control" maxlength="500"><%: dietary %></textarea>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-5" for="emailaddress">Email address</label>
                    <div class="col-sm-7">
                        <input id="emailaddress" name="emailaddress" type="email" class="form-control" maxlength="100" required value="<%:emailaddress%>" />
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-5" for="tbl_phone">Phone</label>
                    <div class="col-sm-7">
                        <input name="phone_validator" class="validate" />
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
                                        <input type="text" class="form-control" data-name="repeat_phone_number_" required /></td>
                                    <td>
                                        <select class="form-control" data-name="repeat_phone_type_" required>
                                            <option></option>
                                            <%= Generic.Functions.populateselect(phonetypevalues, "","None") %>
                                        </select>
                                    </td>
                                     <td>
                                        <input type="text" class="form-control" data-name="repeat_phone_note_" /></td>
                                    <td>
                                        <input type="button" value="Remove" class="btn_phone_remove btn btn-info btn-sm" /></td>
                                </tr>
                                <%=html_phone %>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-5" for="residentialaddress">Home address</label>
                    <div class="col-sm-7">
                        <textarea id="residentialaddress" name="residentialaddress" class="form-control" rows="6" maxlength="500" required><%: residentialaddress %></textarea>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-5" for="school">
                        <img src="../Dependencies/images/questionsmall.png" data-toggle="tooltip" data-html="true" title="Rowers should be comfortable swimming in open water and able to swim 50m in light clothes unassisted. If you are unsure or not confident with your swimming ability please let us know. Your safety is most important to us." />
                        Swimming ability</label>
                    <div class="col-sm-7">
                        <select id="swimmer" name="swimmer" class="form-control" required>
                            <%= Generic.Functions.populateselect(swimmervalues, swimmer,"") %>
                        </select>
                    </div>
                </div>
                <!------------------------------------------------------>
            </div>
        </div>

        <div class="panel panel-danger" id="div_parent" style="display: none">
            <div class="panel-heading">Parent/Caregivers</div>
            <div class="panel-body">
                <input name="parent_validator" class="validate" />
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
                                <input type="text" class="form-control" data-name="repeat_parent_name_" required /></td>
                            <td>
                                <select class="form-control" data-name="repeat_parent_relationship_" required>
                                    <option></option>

                                    <%= Generic.Functions.populateselect(relationshipvalues, "","None") %>
                                </select>
                            </td>
                            <td>
                                <input type="text" class="form-control" data-name="repeat_parent_email_" required /></td>
                            <td>
                                <input type="text" class="form-control" data-name="repeat_parent_note_" /></td>
                            <td>
                                <input type="button" value="Remove Person" class="btn_parent_remove btn btn-info btn-sm" /></td>
                        </tr>

                        <tr style="display: none">
                            <td colspan="5">
                                <table id="tbl_parent_phone" class="table table-condensed table-bordered">
                                    <thead>
                                        <tr>
                                            <th>Phone Number</th>
                                            <th>Type</th>
                                            <th>Note</th>
                                            <th style="width: 10px">
                                                <input type="button" class="btn_parent_aphone btn btn-info btn-sm" value="Add Phone" /></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>
                                                <input type="text" class="form-control" data-name="repeat_parent_phone_number_" required /></td>
                                            <td>
                                                <select class="form-control" data-name="repeat_parent_phone_type_" required>
                                                    <option></option>
                                                    <%= Generic.Functions.populateselect(phonetypevalues, "","None") %>
                                                </select>
                                            </td> 
                                            <td>
                                                <input type="text" class="form-control" data-name="repeat_parent_phone_note_" /></td>
                                            <td>
                                                <input type="button" value="Remove Phone" class="btn_parent_remove_phone btn btn-info btn-sm" /></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                        <%=html_parent %>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="panel panel-danger">
            <div class="panel-heading">Financial</div>
            <div class="panel-body">
                <div class="form-group">
                    <label class="control-label col-sm-5" for="invoicerecipient">
                        Who should we address invoices/statements etc to?</label>
                    <div class="col-sm-7">
                        <input id="invoicerecipient" name="invoicerecipient" type="text" class="form-control" value="<%:invoicerecipient%>" maxlength="100" />
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-5" for="invoicetype">
                        How should we send invoices/statements?</label>
                    <div class="col-sm-7">
                        <select name="invoicetype" id="invoicetype" class="form-control">
                            <option></option>
                            <%= Generic.Functions.populateselect(invoicetypevalues, invoicetype,"None") %>
                        </select>
                    </div>
                </div>

                <div class="form-group" id="div_invoiceaddress">
                    <label class="control-label col-sm-5" for="invoiceaddress">
                        <span id="span_invoiceaddress">Address</span></label>
                    <div class="col-sm-7">
                        <textarea id="invoiceaddress" name="invoiceaddress" class="form-control" maxlength="100"><%:invoiceaddress%></textarea>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-5" for="invoicenote">
                        Note</label>
                    <div class="col-sm-7">
                        <textarea id="invoicenote" name="invoicenote" class="form-control" maxlength="100"><%:invoicenote%></textarea>
                    </div>
                </div>

            </div>
        </div>

        <div class="panel panel-danger">
            <div class="panel-heading">Membership</div>
            <div class="panel-body">
                <div class="form-group">
                    <label class="control-label col-sm-5" for="membershiptype">
                        <img id="qm_membershiptype" src="../Dependencies/images/questionsmall.png" data-toggle="tooltip" data-html="true" title="" />
                        Membership type</label>
                    <div class="col-sm-7">
                        <select name="membershiptype" id="membershiptype" class="form-control" required>
                            <option></option>
                            <%= Generic.Functions.populateselect(membershipvalues, membershiptype,"None") %>
                            <!--<option value="Non-Rower/Supporter">Non-Rower/Supporter</option>-->
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-5" for="familydiscount">
                        <img src="../Dependencies/images/questionsmall.png" data-toggle="tooltip" data-html="true" title="The club offers discounts to families with multiple members." />
                        Do you have other immediate family who are members of Union Boat Club?</label>
                    <div class="col-sm-7">
                        <select id="familydiscount" name="familydiscount" class="form-control" required>
                            <option></option>
                            <%= Generic.Functions.populateselect(yesnovalues, familydiscount,"None") %>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-5" for="previousclub">
                        <img src="../Dependencies/images/questionsmall.png" data-toggle="tooltip" data-html="true" title="If you are joining Union Boat Club from another club, you may need to provide a Clearance/Transfer from your previous club. This form will need to be acknowledged and signed by our Club Secretary." />
                        Previous club (if applicable)</label>
                    <div class="col-sm-7">
                        <input id="previousclub" name="previousclub" type="text" class="form-control" value="<%:previousclub%>" maxlength="100" />

                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-5" for="boatinstorage">
                        <img id="qm_boatinstorage" src="../Dependencies/images/questionsmall.png" data-toggle="tooltip" data-html="true" title="" />
                        Do you currently have a boat stored at the club and want to continue to store it for this season?</label>
                    <div class="col-sm-7">
                        <select id="boatinstorage" name="boatinstorage" class="form-control" required>
                            <option></option>
                            <%= Generic.Functions.populateselect(yesnovalues, boatinstorage,"None") %>
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
                    <label class="control-label col-sm-5" for="agreement">I agree with the above statements</label>
                    <div class="col-sm-7">
                        <select id="agreement" name="agreement" class="form-control" required>
                            <option></option>
                            <option>Yes</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-5" for="correspondence">I also agree, for my information to held in the Union Boat Club database to receive email and text messages from the club.</label>
                    <div class="col-sm-7">
                        <select id="correspondence" name="correspondence" class="form-control" required>
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
                <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="submit btn btn-info" Text="Submit" />
            </div>
        </div>
    </div>
</asp:Content>


