<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register2.aspx.cs" Inherits="Online.Animals.Register2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .hideelement {
            display: none;
        }
    </style>

    <script src="<%: ResolveUrl("~/Scripts/pwstrength-bootstrap.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Scripts/Mask/JQuery.Maks.min.js")%>"></script>

    <script type="text/javascript">

        var newid = 0;

        $(document).ready(function () {
            <%= Online.WDCFunctions.WDCFunctions.testaccess() %>

            $(".phone-group").mask('009 0000000999');

            $("#pagehelp").colorbox({ href: "RegisterHelp.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });

            $("#form1").validate({
                groups: {
                    phone_numbers: "tb_mobilephone tb_homephone tb_workphone"
                },
                rules: {
                    tb_emailconfirm: {
                        //equalTo: '#tb_emailaddress'
                    },

                    tb_mobilephone: {
                        require_from_group: [1, ".phone-group"],
                        pattern: /02[0-9] \d{5,9}/
                    },
                    tb_homephone: {
                        require_from_group: [1, ".phone-group"],
                        pattern: /02[0-9] \d{5,9}|0[0-9] \d{7}/
                    },
                    tb_workphone: {
                        require_from_group: [1, ".phone-group"],
                        pattern: /02[0-9] \d{5,9}|0[0-9] \d{7}/
                    },
                    tb_dateofbirth: {
                        pattern: /(([0-9])|([0-2][0-9])|([3][0-1])) (Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) \d{4}/
                    }

                },
                messages: {
                    tb_emailconfirm: {
                        equalTo: 'This must be the same as the email address above'
                    },
                    tb_mobilephone: {
                        require_from_group: 'Please provide at least 1 phone number',
                        pattern: 'Must be in the format: 02? number, eg: 027 123456...'
                    },
                    tb_homephone: {
                        require_from_group: 'Please provide at least 1 phone number',
                        pattern: 'Must be in the format: 0? number, eg: 06 1234567 or  02? number, eg: 027 123456...'
                    },
                    tb_workphone: {
                        require_from_group: 'Please provide at least 1 phone number',
                        pattern: 'Must be in the format: 0? number, eg: 06 1234567 or  02? number, eg: 027 123456...'
                    },
                    tb_dateofbirth: {
                        pattern: "Must be in the format of day month year, eg: 23 Jun 1985"
                    }
                }
            });

            $("#form2").validate();

            $('#cb_residentialaddressformat').click(function () {
                if ($('#span_residentialaddressformat').text() == 'Address lookup mode (preferred)') {
                    $('#span_residentialaddressformat').text('Free format address mode (not preferred)');
                    $("#tb_residentialaddress").autocomplete("disable");
                } else {
                    $('#span_residentialaddressformat').text('Address lookup mode (preferred)');
                    $("#tb_residentialaddress").autocomplete("enable");
                }
            })

            $('#cb_postaladdressformat').click(function () {
                if ($('#span_postaladdressformat').text() == 'Address lookup mode (preferred)') {
                    $('#span_postaladdressformat').text('Free format address mode (not preferred)');
                    $("#tb_postaladdress").autocomplete("disable");
                } else {
                    $('#span_postaladdressformat').text('Address lookup mode (preferred)');
                    $("#tb_postaladdress").autocomplete("enable");
                }
            })

            $("#tb_residentialaddress").autocomplete({
                source: "../functions/data.asmx/NZPostAddressSearch",
                minLength: 5,
                select: function (event, ui) {
                    event.preventDefault();
                    address = ui.item;
                    $("#tb_residentialaddress").val(ui.item ?
                        address.label.replace(/,/g, "\r\n") : "Nothing selected, input was " + this.value);
                }
            })

            $("#tb_postaladdress").autocomplete({
                source: "../functions/data.asmx/NZPostAddressSearch",
                minLength: 5,
                select: function (event, ui) {
                    event.preventDefault();
                    address = ui.item;
                    $("#tb_postaladdress").val(ui.item ?
                        address.label.replace(/,/g, "\r\n") : "Nothing selected, input was " + this.value);
                }
            })

            .autocomplete("instance")._renderItem = function (ul, item) {
                return $("<li>")
                  //.append("<a>" + item.label + "<br />" + item.legaldescription + " " + item.area + "</a>")
                  .append("<a>" + item.label + "</a>")
                  .appendTo(ul);
            };

            $('#div_dateofbirth').datetimepicker({
                format: 'D MMM YYYY',
                extraFormats: ['D MMM YY', 'D MMM YYYY', 'DD/MM/YY', 'DD/MM/YYYY', 'DD.MM.YY', 'DD.MM.YYYY', 'DD MM YY', 'DD MM YYYY'],
                daysOfWeekDisabled: [0, 6],
                showClear: true,
                viewDate: false,
                useCurrent: false,
                sideBySide: true,
                viewMode: 'years'
            });

            $("#div_dateofbirth").on("dp.change", function (e) {
                if (moment().diff(e.date, 'seconds') < 0) {
                    e.date = moment(e.date).subtract(100, 'years');
                    $("#tb_dateofbirth").val(moment(e.date).format('D MMM YYYY'));
                }
                var years = moment().diff(e.date, 'years');
                $("#span_age").text('Age: ' + years + ' years');
            });

            $('body').on('click', '.item', function () {
                thisitem = $(this);
                if ($(thisitem).attr("id") == 'item_new') {
                    //$('#tb_dogname').val('');
                    DeleteLabel = '';
                    UpdateLabel = 'Create';
                    Deletehide = "hideelement";
                } else {
                    $('#tb_dogname').val($(thisitem).closest('td').next('td').text());
                    $('#dd_dogbreed1').val($(thisitem).attr('breed1'));
                    $('#dd_dogbreed2').val($(thisitem).attr('breed2'));
                    $('#dd_dogyears').val($(thisitem).attr('years'));
                    $('#dd_dogmonths').val($(thisitem).attr('months'));
                    $('#dd_dogcolour1').val($(thisitem).attr('colour1'));
                    $('#dd_dogcolour2').val($(thisitem).attr('colour2'));
                    $('#dd_doggender').val($(thisitem).attr('gender'));
                    $('#dd_dogneutered').val($(thisitem).attr('neutered'));
                    $('#tb_dogchip').val($(thisitem).attr('chip'));
                    $('#tb_dogmarks').val($(thisitem).attr('marks'));
                    if ($(thisitem).attr('remove') == 'Yes') {
                        DeleteLabel = 'Restore'
                    } else {
                        DeleteLabel = 'Remove'
                    }
                    UpdateLabel = 'Update';
                    Deletehide = "";

                }

                //$('.ui-dialog-buttonpane').find('button:first').css('visibility','hidden');

                $("#itemmaint").dialog({
                    modal: true,
                    width: 600,
                    buttons: [{
                        text: DeleteLabel,
                        //classes: {
                        //    "ui-button": "hideelement"
                        //},
                        //disabled: true,
                        "class": Deletehide,
                        click: function () {
                            if (confirm("Do you really want to " + DeleteLabel + " this dog?")) {
                                if ($(thisitem).attr('remove') == 'Yes') {
                                    $(thisitem).attr('remove', 'No');
                                    $(thisitem).css("background-color", "");
                                } else {
                                    $(thisitem).attr('remove', 'Yes');
                                    $(thisitem).css("background-color", "red");
                                }
                                $(this).dialog("close");
                            }
                        },

                    }, {
                        text: UpdateLabel,
                        click: function () {
                            $('#form2').validate();
                            if ($('#form2').valid()) {
                                if ($(thisitem).attr("id") == "item_new") {
                                    newid++;
                                    //$('#table_items tbody').append('<tr><td id="item_new_' + newid + '" class="item">Edit</td><td>' + $('#tb_dogname').val() + '</td><td>' + $('#dd_dogcolour1 option:selected').text() + ' ' + $('#dd_dogbreed1 option:selected').text() + '</td></tr>');
                                    $('#table_items tbody').append('<tr><td id="item_new_' + newid + '" class="item">Edit</td><td></td><td></td></tr>');
                                    thisitem = $('#item_new_' + newid);
                                }
                                $(thisitem).next('td').text($('#tb_dogname').val());
                                $(thisitem).next('td').next('td').text($('#dd_dogcolour1 option:selected').text() + ' ' + $('#dd_dogbreed1 option:selected').text());

                                $(thisitem).attr('breed1', $('#dd_dogbreed1').val());
                                $(thisitem).attr('breed2', $('#dd_dogbreed2').val());
                                $(thisitem).attr('years', $('#dd_dogyears').val());
                                $(thisitem).attr('months', $('#dd_dogmonths').val());
                                $(thisitem).attr('colour1', $('#dd_dogcolour1').val());
                                $(thisitem).attr('colour2', $('#dd_dogcolour2').val());
                                $(thisitem).attr('gender', $('#dd_doggender').val());
                                $(thisitem).attr('neutered', $('#dd_dogneutered').val());
                                $(thisitem).attr('chip', $('#tb_dogchip').val());
                                $(thisitem).attr('marks', $('#tb_dogmarks').val());

                                $('#tb_dogname').val('');
                                $('#dd_dogbreed1').val('');
                                $('#dd_dogbreed2').val('');
                                $('#dd_dogyears').val('');
                                $('#dd_dogmonths').val('');
                                $('#dd_dogcolour1').val('');
                                $('#dd_dogcolour2').val('');
                                $('#dd_doggender').val('');
                                $('#dd_dogneutered').val('');
                                $('#tb_dogchip').val('');
                                $('#tb_dogmarks').val('');


                                $(this).dialog("close");
                            }
                        },
                    }]
                });


            });

            $("#form1").submit(function (event) {
                delim = String.fromCharCode(254);
                $('#table_items tr').each(function (i1, tr) {
                    $(tr).find('td.item').each(function (i2, td) {
                        id = $(td).attr('id');
                        name = $(td).closest('td').next('td').text();
                        breed1 = $(td).attr('breed1');
                        breed2 = $(td).attr('breed2');
                        years = $(td).attr('years');
                        months = $(td).attr('months');
                        colour1 = $(td).attr('colour1');
                        colour2 = $(td).attr('colour2');
                        gender = $(td).attr('gender');
                        neutered = $(td).attr('neutered');
                        chip = $(td).attr('chip');
                        marks = $(td).attr('marks');
                        value = name + delim + breed1 + delim + breed2 + delim + years + delim + months + delim + colour1 + delim + colour2 + delim + gender + delim + neutered + delim + chip + delim + marks;
                        $('<input>').attr({
                            type: 'hidden',
                            name: id,
                            value: value
                        }).appendTo('#form1');
                    });
                });
                //event.preventDefault();
            });


            <% =Online.WDCFunctions.WDCFunctions.googleanalyticstracking(false)%>

        }); //document.ready
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%
        string selected;
        string none = "none";
    %>

    <a id="pagehelp">
        <img id="helpicon" src="http://wdc.whanganui.govt.nz/online/images/question.png" title="Click on me for specific help on this page." /></a>
    <h1>New Dog Owner Registration
    </h1>
    <div>
        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_reference">Reference number:</label>
            <div class="col-sm-8">
                <asp:TextBox ID="tb_reference" name="tb_reference" runat="server" ReadOnly="true" Style="width: 100%"></asp:TextBox>
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_lastname">Last name</label>
            <div class="col-sm-8">
                <input id="tb_lastname" name="tb_lastname" type="text" class="form-control" required />
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_firstname">
                First name
            <img src="../Images/questionsmall.png" title="Only your first name in full.  If you are known by a 'nickname' or shortened version of your first name please enter it in the 'Known as' field below." /></label>
            <div class="col-sm-8">
                <input id="tb_firstname" name="tb_firstname" type="text" class="form-control" required />
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_othernames">
                Other names
            <img src="../Images/questionsmall.png" title="ie: middle names." /></label>
            <div class="col-sm-8">
                <input id="tb_othernames" name="tb_othernames" type="text" class="form-control" />
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_knownas">Known as</label>
            <div class="col-sm-8">
                <input id="tb_knownas" name="tb_knownas" type="text" class="form-control" />
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="cb_residentialaddressformat">
                Residential address
            <img src="../Images/questionsmall.png" title="If you are in 'Address lookup mode' start typing your address (at least 5 characters).  A list of addresses will be given to you as options, please select one.  The more that you type the closer the options provided will be.  If you cannot find your address, change the lookup mode above." /></label>
            <div class="col-sm-8">
                <span id="span_residentialaddressformat">Address lookup mode (preferred)</span>
                <a href="javascript:void(0);" id="cb_residentialaddressformat">Change</a>
                <textarea id="tb_residentialaddress" name="tb_residentialaddress" class="form-control" rows="4" required></textarea>
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="cb_postaladdressformat">
                Postal address
            <img src="../Images/questionsmall.png" title="This is only required if different to the residential address above. If you are in 'Address lookup mode' start typing your address (at least 5 characters).  A list of addresses will be given to you as options, please select one.  The more that you type the closer the options provided will be.  If you cannot find your address, change the lookup mode above." /></label>
            <div class="col-sm-8">
                <span id="span_postaladdressformat">Address lookup mode (preferred)</span>
                <a href="javascript:void(0);" id="cb_postaladdressformat">Change</a>
                <textarea id="tb_postaladdress" name="tb_postaladdress" class="form-control" rows="4"></textarea>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_emailaddress">Email address</label>
            <div class="col-sm-8">
                <input id="tb_emailaddress" name="tb_emailaddress" type="email" class="form-control" required />
            </div>
        </div>
        <div class="form-group" id="div_emailconfirm">
            <label class="control-label col-sm-4" for="tb_emailconfirm">Please re-type your email address</label>
            <div class="col-sm-8">
                <input id="tb_emailconfirm" name="tb_emailconfirm" type="email" class="form-control inhibitcutcopypaste required" autocomplete="off" />
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_mobilephone">Mobile phone</label>
            <div class="col-sm-8">
                <input id="tb_mobilephone" placeholder="eg: 027 123456..." name="tb_mobilephone" type="text" class="form-control phone-group" />
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_homephone">Home phone</label>
            <div class="col-sm-8">
                <input id="tb_homephone" name="tb_homephone" placeholder="eg: 06 1234567 or 027 123456..." type="text" class="form-control phone-group" />
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_workphone">Work phone</label>
            <div class="col-sm-8">
                <input id="tb_workphone" name="tb_workphone" placeholder="eg: 06 1234567 or 027 123456..." type="text" class="form-control phone-group" />
            </div>
        </div>


        <div class="form-group">
            <label class="control-label col-sm-4" for="dd_gender">Gender</label>
            <div class="col-sm-8">
                <select id="dd_gender" name="dd_gender" class="form-control" required>
                    <option></option>
                    <%=Online.WDCFunctions.WDCFunctions.populateselect(genders, "", "None")%>
                </select>
            </div>
        </div>



        <div class="form-group">
            <label for="tb_dateofbirth" class="control-label col-sm-4">
                Date of birth
            <img src="../Images/questionsmall.png" title="Your date of birth will help us better locate you on our council records and will help distinguish you from others with the same name" /></label>
            <div class="col-sm-8">
                <div class="input-group date" id="div_dateofbirth">
                    <input id="tb_dateofbirth" name="tb_dateofbirth" required placeholder="eg: 23 Jun 1985" type="text" class="form-control" />

                    <span class="input-group-addon">
                        <span class="glyphicon glyphicon-calendar"></span>
                    </span>

                    <span id="span_age" class="input-group-addon"></span>
                </div>
            </div>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
            <table class="table" id="table_items">
                <thead>
                    <tr>
                        <th class="item" id="item_new">Add</th>
                        <th>Name</th>
                        <th>Description</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
            <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info" Text="Submit" />
        </div>
    </div>









</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">

    <div id="itemmaint" title="Dog Details" class="container form-horizontal" style="display: none">

        <form id="form2">
            <!-- Name -->

            <div class="form-group">
                <label class="control-label col-sm-4 " for="tb_dogname">Name</label>
                <div class="col-sm-8">
                    <input type="text" id="tb_dogname" name="tb_dogname" class="form-control" maxlength="100" required />
                </div>
            </div>

            <!-- Breed-->
            <div class="form-group">
                <label class="control-label col-sm-4 " for="dd_dogbreed1">Breed</label>
                <div class="col-sm-4">
                    <select id="dd_dogbreed1" name="dd_dogbreed1" class="form-control" required>
                        <option></option>
                        <%= breeds %>
                    </select>Primary
                </div>

                <div class="col-sm-4">
                    <select id="dd_dogbreed2" name="dd_dogbreed2" class="form-control" required>
                        <option></option>
                        <%= breeds %>
                    </select>Secondary
                </div>
            </div>


            <!-- Age-->
            <div class="form-group">
                <label class="control-label col-sm-4 " for="dd_dogyears">Age</label>
                <div class="col-sm-4">
                    <select id="dd_dogyears" name="dd_dogyears" class="form-control" required>
                        <option></option>
                        <option>0</option>
                        <option>1</option>
                        <option>2</option>
                        <option>3</option>
                        <option>4</option>
                        <option>5</option>
                        <option>6</option>
                        <option>7</option>
                        <option>8</option>
                        <option>9</option>
                        <option>10</option>
                        <option>11</option>
                        <option>12</option>
                        <option>13</option>
                        <option>14</option>
                        <option>15</option>

                    </select>Years
                </div>

                <div class="col-sm-4">
                    <select id="dd_dogmonths" name="dd_dogmonths" class="form-control" required>
                        <option></option>
                        <option>0</option>
                        <option>1</option>
                        <option>2</option>
                        <option>3</option>
                        <option>4</option>
                        <option>5</option>
                        <option>6</option>
                        <option>7</option>
                        <option>8</option>
                        <option>9</option>
                        <option>10</option>
                        <option>11</option>
                    </select>Months
                </div>
            </div>


            <!-- Colour-->
            <div class="form-group">
                <label class="control-label col-sm-4 " for="dd_dogcolour1">Primary Colour</label>
                <div class="col-sm-8">
                    <select id="dd_dogcolour1" name="dd_dogcolour1" class="form-control" required>
                        <option></option>
                        <%= colours %>
                    </select>
                </div>
            </div>

            <!-- Colour-->
            <div class="form-group">
                <label class="control-label col-sm-4 " for="dd_dogcolour2">Secondary Colour</label>
                <div class="col-sm-8">
                    <select id="dd_dogcolour2" name="dd_dogcolour2" class="form-control" required>
                        <option></option>
                        <%= colours %>
                    </select>
                </div>
            </div>


            <!-- Gender-->
            <div class="form-group">
                <label class="control-label col-sm-4 " for="dd_doggender">Gender</label>
                <div class="col-sm-8">
                    <select id="dd_doggender" name="dd_doggender" class="form-control" required>
                        <option></option>
                        <%=Online.WDCFunctions.WDCFunctions.populateselect(doggenders, "", "None")%>
                    </select>
                </div>
            </div>

            <!-- Neutered-->
            <div class="form-group">
                <label class="control-label col-sm-4 " for="dd_dogneutered">Neutered</label>
                <div class="col-sm-8">
                    <select id="dd_dogneutered" name="dd_dogneutered" class="form-control" required>
                        <option></option>
                        <option>Yes</option>
                        <option>No</option>


                    </select>
                </div>
            </div>
            <!-- Chip-->
            <div class="form-group">
                <label class="control-label col-sm-4 " for="tb_dogchip">Chip</label>
                <div class="col-sm-8">
                    <input type="text" id="tb_dogchip" class="form-control" maxlength="100" />
                </div>
            </div>

            <!-- Distinguishing Marks-->
            <div class="form-group">
                <label class="control-label col-sm-4 " for="tb_dogmarks">Distinguishing Marks</label>
                <div class="col-sm-8">
                    <textarea id="tb_dogmarks" class="form-control" maxlength="100"></textarea>
                </div>
            </div>

        </form>
    </div>

</asp:Content>
