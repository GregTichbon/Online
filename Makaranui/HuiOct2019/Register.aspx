<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Makaranui.HuiOct2019.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        th {
            text-align: left;
        }

            th.right, td.right {
                text-align: right;
            }

        .numeric {
            direction: rtl;
            text-align: right;
            width: 50px;
        }

        #regtable {
            width: 100%;
        }

        table {
            border: 1px solid black;
            border-collapse: collapse;
        }

            table td, table th {
                border: 1px solid black;
                padding: 5px;
                text-align: left;
            }

            table tbody td {
                font-size: 13px;
            }

            table tr.blue {
                background: #D0E4F5;
            }

            table tr.altcolour:nth-child(even) {
                background: #D0E4F5;
            }

            table thead {
                background: #0B6FA4;
                border-bottom: 5px solid #FFFFFF;
            }

                table thead th {
                    font-size: 17px;
                    font-weight: bold;
                    color: #FFFFFF;
                    text-align: left;
                    border-left: 2px solid #FFFFFF;
                }

                    table thead th:first-child {
                        border-left: none;
                    }

        :required {
            border-color: darkred;
        }

        .toprighticon {
            border-style: none;
            border-color: inherit;
            border-width: 0;
            position: fixed;
            top: 5px;
            right: 0px;
            z-index: 9999;
        }

        .btn-info {
            background-color: red !important;
            border-color: red !important;
        }
        /*
        [maint="changed"] {
            color: red;
        }
            */

  
           input[type=checkbox]
{
  /* Double-sized Checkboxes */
  -ms-transform: scale(3); /* IE */
  -moz-transform: scale(3); /* FF */
  -webkit-transform: scale(3); /* Safari and Chrome */
  -o-transform: scale(3); /* Opera */
  margin:14px !important;
}

    </style>
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap.min.css")%>" rel="stylesheet" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />

    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
    <script src="<%: ResolveUrl("~/Dependencies/jquery.validate.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Dependencies/bootstrap.min.js")%>"></script>
    <script type="text/javascript">

        var mywidth;
        var tr;
        var mode;
        var newctr = 0;

        $(document).ready(function () {
            tablerowcolours();
            counttshirts();
            countpeople();

            $(function () {
                $('[data-toggle="tooltip"]').tooltip();
            });



            var currentprimarycontact = $('input:radio[name="primarycontact"]:checked').val();
            //alert(currentprimarycontact);

            mywidth = $(window).width() * .95;
            if (mywidth > 800) {
                mywidth = 800;
            }

            $("#form1").validate({
                rules: {
                    phone: {
                        required: "#primarycontact:checked"
                    },
                    email: {
                        required: "#primarycontact:checked"
                    }
                }
            });

            $("#help").click(function () {
                $("#dialog_help").dialog({
                    resizable: false,
                    //height: 700,
                    width: mywidth,
                    modal: true,
                    position: { my: "centre", at: "centre", of: window }
                });
            })

            $(document).on('click', '.maintain', function () {
                mode = $(this).data('mode');
                if (mode == "add") {
                    $("#dialog_items").find(':input').val('');
                } else {
                    tr = $(this).closest('tr');

                    $('#primarycontact').prop('checked', $(tr).find('input:radio').is(':checked'));
                    $('#firstname').val($(tr).find('td:eq(2)').text());
                    $('#lastname').val($(tr).find('td:eq(3)').text());
                    $('#phone').val($(tr).find('td:eq(4)').text());
                    $('#email').val($(tr).find('td:eq(5)').text());
                    $('#age').val($(tr).find('td:eq(6)').text());
                    $('#diet').val($(tr).find('td:eq(7)').text());
                    $('#health').val($(tr).find('td:eq(8)').text());
                    $('#medication').val($(tr).find('td:eq(9)').text());
                    $('#emergency').val($(tr).find('td:eq(10)').text());
                    $('#firstaid').val($(tr).find('td:eq(11)').text());
                }


                $("#dialog_items").dialog({
                    resizable: false,
                    //height: 700,
                    width: mywidth,
                    modal: true,
                    position: { my: "centre", at: "centre", of: window },
                    appendTo: "#form1"
                });

                var myButtons = {
                    "Cancel": function () {
                        $(this).dialog("close");
                    },
                    "Save": function () {
                        if ($("#form1").valid()) {
                            if (mode == "add") {
                                tr = $('#regtable > tbody tr:first').clone();
                                $(tr).removeAttr('style');
                                $('#regtable > tbody > tr:last').after(tr);
                                $(tr).attr('id', 'person_new_' + get_newctr());
                                //$(tr).find('td:first').attr("class", "inserted");
                            } else {
                                //$(tr).find('td:first').attr("class", "changed");
                            }
                            $(tr).attr('maint', 'changed');



                            $(tr).find('input:radio').prop('checked', $('#primarycontact').is(':checked'));
                            $(tr).find('td').eq(2).text($('#firstname').val());
                            $(tr).find('td').eq(3).text($('#lastname').val());
                            $(tr).find('td').eq(4).text($('#phone').val());
                            $(tr).find('td').eq(5).text($('#email').val());
                            $(tr).find('td').eq(6).text($('#age').val());
                            $(tr).find('td').eq(7).text($('#diet').val());
                            $(tr).find('td').eq(8).text($('#health').val());
                            $(tr).find('td').eq(9).text($('#medication option:selected').text());
                            $(tr).find('td').eq(10).text($('#emergency').val());
                            $(tr).find('td').eq(11).text($('#firstaid option:selected').text());
                            countpeople();

                            $(this).dialog("close");
                        }
                    }
                }


                if (mode != 'add') {
                    myButtons["Delete"] = function () {
                        if (window.confirm("Are you sure you want to delete this registration?")) {
                            $('#primarcontact').prop("checked", false);
                            $(tr).find('td:first').attr("class", "deleted");
                            $(tr).attr('maint', 'deleted');
                            $(tr).hide();

                            tablerowcolours();
                            countpeople();
                            $(this).dialog("close");
                        }
                    }
                }


                $("#dialog_items").dialog('option', 'buttons', myButtons);



            });
            $('input:radio[name="primarycontact"]').change(function () {
                newrb = $(this);
                $(newrb).closest('tr').attr('maint', 'changed');
                oldrb = $('input:radio[name="primarycontact"][value="' + currentprimarycontact + '"]')
                $(oldrb).closest('tr').attr('maint', 'changed');
                currentprimarycontact = $(newrb).val();
            });




            $('#koha').change(function () {
                $(this).val(parseFloat($(this).val()).toFixed(2));
                calculatetotal();
            })

            $('.tshirt').change(function () {
                counttshirts();
            });

            $(".tshirt").focus(function () {
                $(this).select();
            });
            $("#koha").focus(function () {
                $(this).select();
            });

            $('.submit').click(function (e) {
                if ($("input[name='primarycontact']:checked").length == 0) {
                    alert('You must select one person to be the primary contact.  You will need to enter an email address and mobile phone number for them.');
                    e.preventDefault();
                    return;
                }

                primarytr = $("input[name='primarycontact']:checked").closest('tr');
                if ($(primarytr).find('td:eq(4)').text() == "" || $(primarytr).find('td:eq(5)').text() == "") {
                    alert('You must enter an email address and mobile phone number for the primary contact.');
                    e.preventDefault();
                    return;
                }

                delim = String.fromCharCode(254);
                $('#regtable > tbody > tr[maint="changed"]').each(function () {
                    id = $(this).attr('id');
                    if ($(this).find('td:eq(1)').find(':radio').is(':checked')) {
                        primarycontact = 'Yes';
                    } else {
                        primarycontact = '';
                    }

                    firstname = $(this).find('td:eq(2)').text();
                    lastname = $(this).find('td:eq(3)').text();
                    phone = $(this).find('td:eq(4)').text();
                    email = $(this).find('td:eq(5)').text();
                    age = $(this).find('td:eq(6)').text();
                    diet = $(this).find('td:eq(7)').text();
                    health = $(this).find('td:eq(8)').text();
                    medication = $(this).find('td:eq(9)').text();
                    emergency = $(this).find('td:eq(10)').text();
                    firstaid = $(this).find('td:eq(11)').text();

                    value = primarycontact + delim + firstname + delim + lastname + delim + phone + delim + email + delim + age + delim + diet + delim + health + delim + medication + delim + emergency + delim + firstaid;
                    //alert(value);
                    $('<input>').attr({
                        type: 'hidden',
                        name: id,
                        value: value
                    }).appendTo('#form1');
                });

                $('#regtable > tbody > tr[maint="deleted"]').each(function () {
                    //don't do if new
                    id = $(this).attr('id') + '_delete';
                    if (id.substring(0, 3) != 'new') {
                        $('<input>').attr({
                            type: 'hidden',
                            name: id,
                            value: ""
                        }).appendTo('#form1');
                    }
                });
            });

            $(".numeric, .phone").keydown(function (event) {
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
            $('[required]').addClass('required');

        }); //document.ready

        function counttshirts() {
            tshirtcount = 0;
            $('.tshirt').each(function () {
                tshirtcount += parseInt($(this).val());
            })
            $('#tshirtamount').text((tshirtcount * 15).toFixed(2));
            if (tshirtcount == 0) {
                tshirtcount = "";
            }
            $('#tshirtcount').text(tshirtcount);
            calculatetotal();
        };

        function countpeople() {
            //$('#peopleattending').text($('#regtable tbody tr:visible').length);
            calculatetotal();
        }

        function calculatetotal() {
            $('#totalamount').html("<b>" + (parseFloat(50) + parseFloat($('#tshirtamount').text()) + parseFloat($('#koha').val())).toFixed(2) + "</b>");
        }

        function tablerowcolours() {
            var class1 = "";
            $("#regtable tbody tr:visible").each(function () {
                if (class1 == 'blue') {
                    class1 = 'white';
                    class2 = 'blue'
                } else {
                    class1 = 'blue';
                    class2 = 'white'
                }
                $(this).addClass(class1).removeClass(class2);

            });
        }

        function get_newctr() {
            newctr++;
            return newctr;
        }


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <input type="hidden" name="guid" value="<%=guid %>" />
    <h2>Wananga Registration</h2>
    <br />

    <div class="toprighticon">
        <input type="button" id="help" class="btn btn-info" value="Help" />
    </div>

    <div style="height: 35px">
        <input class="maintain btn btn-info" data-mode="add" type="button" style="float: left;" value="Add a person" />
    </div>

    <div style="height: 250px; overflow: auto;">
        <table id="regtable">
            <thead>
                <tr>
                    <th>Edit</th>
                    <th>Primary Contact</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Phone</th>
                    <th>Email</th>
                    <th class="right">Age</th>
                    <th>Special<br />
                        Dietary Needs</th>
                    <th>Health/Medical<br />
                        Issues</th>
                    <th>Medication</th>
                    <th>Emergency Contact</th>
                    <th>First Aid</th>
                </tr>
            </thead>
            <tbody><%= registrationhtml %></tbody>
        </table>
    </div>
    <br />
    <div style="text-align: center;margin-right: auto;margin-left: auto;">
        <table style="display:inline-block;">
            <thead>
                <tr>
                    <th colspan="2">T-Shirts</th>
                </tr>
                <tr>
                    <th>Size</th>
                    <th class="right">Number</th>
                </tr>
            </thead>
            <tbody>
                <%= tshirtshtml %>
            </tbody>
        </table>

        <table style="display:inline-block;vertical-align:top">
            <thead>
                <tr>
                    <th colspan="3">Costs</th>
                </tr>
                <tr>
                    <th>Description</th>
                    <th class="numeric">Amount</th>
                </tr>
            </thead>
            <tbody>
                <tr class="altcolour">
                    <td>Whanau contributions</td>
                    <td class="numeric" style="padding-right: 10px">50.00</td>
                </tr>
                <tr class="altcolour">
                    <td>Koha</td>
                    <td>$<span class="numeric">
                        <input type="text" id="koha" class="numeric" value="<%=koha %>" /></span></td>
                </tr>
                <tr class="altcolour">
                    <td><span id="tshirtcount"></span> T-shirts</td>
                         <td class="numeric" id="tshirtamount" style="padding-right: 10px"></td>
                </tr>
                <tr class="altcolour">
                    <td><b>Total</b></td>

                    <td class="numeric" id="totalamount" style="padding-right: 10px"></td>
                </tr>
                <tr class="altcolour">
                   
                    <td colspan="2"><asp:Button ID="submit" runat="server" OnClick="submit_Click" Style="float: right;" class="submit btn btn-info" Text="Submit" /></td>
                   
                </tr>
            </tbody>
        </table>
        

    </div>

    <div id="dialog_items" title="Person Details" style="display: none" class="form-horizontal">
        <div class="form-group">
            <label class="control-label col-sm-4" for="firstname">Primary Contact</label>
            <div class="col-sm-8">
                <input type="checkbox" id="primarycontact"  style="text-align:left" />
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="firstname">First Name</label>
            <div class="col-sm-8">
                <input type="text" id="firstname" name="firstname" class="form-control" required="required" />
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="lastname">Last Name</label>
            <div class="col-sm-8">
                <input type="text" id="lastname" name="lastname" class="form-control" required="required" />
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="phone">Phone</label>
            <div class="col-sm-8">
                <input type="text" id="phone" name="phone" class="phone form-control" />
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="email">Email address</label>
            <div class="col-sm-8">
                <input type="email" id="email" name="email" class="form-control" />
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="age">Age</label>
            <div class="col-sm-8">
                <input type="text" id="age" name="age" class="numeric form-control" maxlength="3" required="required" />
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="diet">Special Dietary Needs</label>
            <div class="col-sm-8">
                <textarea id="diet" name="diet" class="form-control"></textarea>
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="health">Health/Medical Issues</label>
            <div class="col-sm-8">
                <textarea id="health" class="form-control"></textarea>
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="medication"><img src="../Dependencies/questionsmall.png" data-toggle="tooltip" title="Please confirm that you will bring any medication you require."> Medication</label>
            <div class="col-sm-8">
                <select id="medication" name="medication" class="form-control" required="required">
                    <option>N/A</option>
                    <option>Yes</option>
                </select>
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="emergency">Emergency Contact</label>
            <div class="col-sm-8">
                <textarea id="emergency" name="emergency" class="form-control" required="required"></textarea>
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="firstaid"><img src="../Dependencies/questionsmall.png" data-toggle="tooltip" title="Do you have a first aid certificate?"> First Aid</label>
            <div class="col-sm-8">
                <select id="firstaid" name="firstaid" class="form-control" required="required">
                    <option>Yes</option>
                    <option>No</option>
                </select>
            </div>
        </div>
    </div>

    <div id="dialog_help" title="Help" style="display: none">
        <ol>
            <li>Click on &lsquo;<strong>Add a person&rsquo;</strong></li>
            <li><strong>&lsquo;Primary Contact&rsquo;</strong> click on this if you are to be the main contact person for this registration. You will receive emails, updating you on the hui.</li>
            <li><strong>&lsquo;Email Address&rsquo; </strong>this is how we will communicate with you for updates, so make sure you have typed it correctly</li>
            <li><strong>&lsquo;Age&rsquo; </strong>&ndash; this is to understand the age range and plan activities accordingly.</li>
            <li><strong>&lsquo;Special Dietary Needs&rsquo; </strong>&ndash; If you have any diet needs that you need the cooks to know about, you need to state it here.</li>
            <li><strong>&lsquo;Health/Medical issues&rsquo;</strong> -&nbsp; we will be travelling into rural areas on the bus.&nbsp; You must be clear about and health/medical issues so the organisers can be aware of possible issues.</li>
            <li><strong>&lsquo;medication&rsquo;</strong> - if you require medication you must take responsibility for your health &amp; wellbeing and bring that with you.</li>
            <li><strong>&lsquo;emergency contact&rsquo;</strong> &ndash;this is who we will contact if there should be an emergency.</li>
            <li><strong>&lsquo;First Aid&rsquo;</strong> &ndash; we want to know who holds a current First Aid Certificate. This helps us be prepared for a First Aid situation.</li>
            <li>Click on<strong> &lsquo;Save&rsquo;</strong></li>
            <li><strong>&lsquo;Order your Tshirts&rsquo; </strong>&ndash; order your tshirt by entering the number of tshirts you want in the correct size. You can put in multiple sizes.</li>
            <li><strong>&lsquo;Cost&rsquo;</strong> &ndash; You can add a koha, especially if you are bringing a large koha, to assist with costs. This table adds up all the costs of the hui and tshirts.</li>
            <li>Click on<strong> &lsquo;Submit&rsquo;</strong></li>
        </ol>
    </div>

</asp:Content>
