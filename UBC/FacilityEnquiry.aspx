<%@ Page Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="FacilityEnquiry.aspx.cs" Inherits="UBC.FacilityEnquiry" %>
 <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <!-- Style Sheets -->
    <link href="<%: ResolveUrl("/Dependencies/bootstrap.min.css")%>" rel="stylesheet" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />
    <link href="<%: ResolveUrl("/Dependencies/bootstrap-datetimepicker.min.css")%>" rel="stylesheet" />

    <!-- Javascript -->
    <script src="<%: ResolveUrl("/Dependencies/jquery-2.2.0.min.js")%>"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>

    <script type="text/javascript">
        // Change JQueryUI plugin names to fix name collision with Bootstrap.
        $.widget.bridge('uitooltip', $.ui.tooltip);
        $.widget.bridge('uibutton', $.ui.button);
    </script>

    <script src="<%: ResolveUrl("/Dependencies/bootstrap.min.js")%>"></script>
    <script src="<%: ResolveUrl("/Dependencies/jquery.validate.min.js")%>"></script>
    <script src="<%: ResolveUrl("/Dependencies/additional-methods.js")%>"></script>
    <script src="<%: ResolveUrl("/Dependencies/moment.min.js")%>"></script>
    <script src="<%: ResolveUrl("/Dependencies/bootstrap-datetimepicker.min.js")%>"></script>

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
                },
                submitHandler: function (form) {
                    $(".processing").show();
                    form.submit();
                }
             /*,
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

            /*
            $('.submit').click(function () {
                alert(1);
                $('.processing').show();
            });
            
            $("form").submit(function (event) {
                $('.processing').show();
            });
            */

            //$('[required]').css('border', '1px solid red');
            //$('[required]').addClass('required');
        });

       

    </script>
    <style type="text/css">
        .validate {
            display: none;
        }

.processing {
    position: fixed;
    left: 0px;
    top: 0px;
    width: 100%;
    height: 100%;
    z-index: 9999;
    background: url('/dependencies/images/processing2.gif') 50% 50% no-repeat ;
}
               
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <input id="guid" name="guid" type="hidden" value="<%:guid%>" />
    
    <div style="display: none" class="processing"></div>
    <div class="container" style="background-color: #B1C9E6">
        <p></p>
        <table style="width: 100%">
            <tr>
                <td style="width: 350px">
                    <img src="https://ubc.org.nz/dependencies/images/Logo-Page-Head.png" style="width: 100%" /></td>
                <td style="text-align: center">
                    <h1>Facilities Booking Enquiry</h1>
                </td>
            </tr>
        </table>
        <hr />
        <div class="panel panel-danger">
            <div class="panel-body">
                Please fill in the form below.
            </div>
            <div class="panel-body">
                <!------------------------------------------------------>
                <div class="form-group">
                    <label class="control-label col-sm-5" for="firstname">
                    First name</label>
                    <div class="col-sm-7">
                        <input id="firstname" name="firstname" type="text" class="form-control" value="<%:firstname%>" maxlength="20" required />
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-5" for="lastname">
                    Last name</label>
                    <div class="col-sm-7">
                        <input id="lastname" name="lastname" type="text" class="form-control" value="<%:lastname%>" maxlength="30" required />
                    </div>
                </div>
                <div class="form-group">
                    Drop down<br />
&nbsp;<div class="col-sm-7">
                        <select id="school" name="school" class="form-control">
                            <%= Generic.Functions.populateselect(schoolvalues, school,"") %>
                        </select>
                    </div>
                </div>
                <div id="div_schoolyear" class="form-group" style="display: none">
                    <label class="control-label col-sm-5" for="schoolyear">
                    School year</label>
                    <div class="col-sm-7">
                        <select id="schoolyear" name="schoolyear" class="form-control" required>
                            <%= Generic.Functions.populateselect(schoolyearvalues, schoolyear,"") %>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-5" for="medical">
                    <img src="/Dependencies/images/questionsmall.png" data-toggle="tooltip" data-html="true" title="Please provide any information that maybe useful, such as asthma, seizures, etc" />
                        Medical needs</label>
                    <div class="col-sm-7">
                        <textarea id="medical" name="medical" class="form-control" maxlength="500"><%: medical %></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-5" for="dietary">
                    <img src="/Dependencies/images/questionsmall.png" data-toggle="tooltip" data-html="true" title="This information is useful for catering at regattas and other catered events." />
                        </label>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-5" for="emailaddress">
                    Email address</label>
                    <div class="col-sm-7">
                        <input id="emailaddress" name="emailaddress" type="email" class="form-control" maxlength="100" required value="<%:emailaddress%>" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-5" for="tbl_phone">
                    Phone</label>
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
                                        </select> </td>
                                    <td>
                                        <input type="text" class="form-control" data-name="repeat_phone_note_" /></td>
                                    <td>
                                        <input type="button" value="Remove" class="btn_phone_remove btn btn-info btn-sm" /><br />
                                    </td>
                                </tr>
                                <%=html_phone %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!------------------------------------------------------------------------------------------------------>

        <div class="form-group">
            <div class="col-sm-5">
                <p class="MsoNormal">
                    Name<o:p></o:p></p>
                <p class="MsoNormal">
                    Contact Details<o:p></o:p></p>
                <p class="MsoNormal">
                    When<o:p></o:p></p>
                <p class="MsoNormal">
                    Setup and packdown details<o:p></o:p></p>
                <p class="MsoNormal">
                    Purpose<o:p></o:p></p>
                <p class="MsoNormal">
                    Alcohol<o:p></o:p></p>
                <p class="MsoNormal">
                    Supervision etc<o:p></o:p></p>
            </div>
            <div class="col-sm-7">
                <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="submit btn btn-info" Text="Submit" />
            </div>
        </div>
    </div>
</asp:Content>


