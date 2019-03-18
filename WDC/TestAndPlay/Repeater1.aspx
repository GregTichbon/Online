<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Repeater1.aspx.cs" Inherits="Online.TestAndPlay.Repeater1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">
        var sitectr = 1;
        var options = {
            source: "../functions/data.asmx/NZPostAddressSearch",
            minLength: 5,
            select: function (event, ui) {
                event.preventDefault();
                address = ui.item;
                thisid = this.id;
                $('#' + thisid).val(ui.item ?
                    address.label.replace(/,/g, "\r\n") : "Nothing selected, input was " + this.value);
            }
        };

        var zzzz = function () {
            var result = {};

            //$("[class*='validgroup_']").each(function (i) {
            $("[class*='updatevalidgroup']").each(function (i) {
                //xx = $(this).data('validgroup');
                xx = $(this).attr("id");
                //alert(xx);

                /*

                var field1Name = $(this).find('.field1').attr('name');
                if (field1Name != undefined) {
                    var field2Name = $(this).find('.field2').attr('name');
                    result['fieldPair_' + i] = field1Name + ' ' + field2Name;
                }
                */
                thisid = this.id;
                alert(thisid);
                result['personphone_' + i] = thisid;
            });
            alert(result);
            return result;
        }

        var getGroups = function () {
            var result = {};

            //$("[class*='validgroup_']").each(function (i) {
            $("[class*='updatevalidgroup']").each(function (i) {
                xx = $(this).data('validgroup');
                //xx = $(this).attr("id");
                alert(xx);

                /*

                var field1Name = $(this).find('.field1').attr('name');
                if (field1Name != undefined) {
                    var field2Name = $(this).find('.field2').attr('name');
                    result['fieldPair_' + i] = field1Name + ' ' + field2Name;
                }
                */
                thisid = this.id;
                //alert(thisid);
                result['personphone_' + i] = thisid;
            });
            alert(result);
            return result;
        }

        $(document).ready(function () {

            $("#Button1").click(function () {
                alert(1);
                zzzz();
            });

            

            /*
            groups: getGroups(),
            groups: { personphone_1: "tb_personphonemobile_1 tb_personphonehome_1 tb_personphonework_1" },  //the name of the group is not important
            */


            $("#form1").validate({
                ignore: [],
                groups: getGroups(),
                rules: {
                    tb_personemailconfirm_1: {
                        equalTo: '#tb_personemailaddress_1',
                        required: {
                            depends: function () { return $("#tb_personemailaddress_1").val() != "" }
                        }
                    },
                    tb_personphonemobile_1: {
                        require_from_group: [1, ".validgroup_personphone_1"],
                        pattern: /02[0-9] \d{5,9}/
                    },
                    tb_personphonehome_1: {
                        require_from_group: [1, ".validgroup_personphone_1"],
                        pattern: /02[0-9] \d{5,9}|0[0-9] \d{7}/
                    },
                    tb_personphonework_1: {
                        require_from_group: [1, ".validgroup_personphone_1"],
                        pattern: /02[0-9] \d{5,9}|0[0-9] \d{7}/
                    }
                },
                messages: {
                    tb_contact1emailaddressconfirm: {
                        equalTo: 'This must be the same as the email address above'
                    },
                    tb_personphonemobile_1: {
                        require_from_group: 'Please provide at least 1 phone number',
                        pattern: 'Must be in the format: 02? number, eg: 027 123456...'
                    },
                    tb_personphonehome_1: {
                        require_from_group: 'Please provide at least 1 phone number',
                        pattern: 'Must be in the format: 0? number, eg: 06 1234567 or  02? number, eg: 027 123456...'
                    },
                    tb_personphonework_1: {
                        require_from_group: 'Please provide at least 1 phone number',
                        pattern: 'Must be in the format: 0? number, eg: 06 1234567 or  02? number, eg: 027 123456...'
                    }
                }
            });



            $('body').on('click', '.addressformat', function () {
            //$('.addressformat').click(function () {
                alert(1);
                thisid = this.id;
                if ($('#span_' + thisid).text() == 'Address lookup mode (preferred)') {
                    $('#span_' + thisid).text('Free format address mode (not preferred)');
                    $('#tb_' + thisid).autocomplete("disable");
                } else {
                    $('#span_' + thisid).text('Address lookup mode (preferred)');
                    $('#tb_' + thisid).autocomplete("enable");
                }
            })

            $(document).on('keydown.autocomplete', '.autoaddress', function () {
                $(this).autocomplete(options);
            });

/*
            $(".autoaddress").autocomplete({
                source: "../functions/data.asmx/NZPostAddressSearch",
                minLength: 5,
                select: function (event, ui) {
                    event.preventDefault();
                    address = ui.item;
                    thisid = this.id;
                    $('#' + thisid).val(ui.item ?
                        address.label : "Nothing selected, input was " + this.value);
                }
            })


            .autocomplete("instance")._renderItem = function (ul, item) {
                return $("<li>")
                    //.append("<a>" + item.label + "<br />" + item.legaldescription + " " + item.area + "</a>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
*/

            // Add a new repeating section
            $('.addsite').click(function () {
                var lastRepeatingGroup = $('#div_site_1').last();

                var cloned = lastRepeatingGroup.clone()

                sitectr = sitectr + 1;
                cloned = cloned.repeater_changer(sitectr);

                var place = $('.addsite');
                cloned.insertAfter(place);

                $("#tb_personphonemobile_" + sitectr).rules("add", {
                    require_from_group: [1, ".validgroup_personphone_" + sitectr],
                    pattern: /02[0-9] \d{5,9}/,
                    messages: {
                        require_from_group: 'Please provide at least 1 phone number',
                        pattern: 'Must be in the format: 02? number, eg: 027 123456...'
                    }
                });

                $("#tb_personphonehome_" + sitectr).rules("add", {
                    require_from_group: [1, ".validgroup_personphone_" + sitectr],
                    pattern: /02[0-9] \d{5,9}/,
                    messages: {
                        require_from_group: 'Please provide at least 1 phone number',
                        pattern: 'Must be in the format: 0? number, eg: 06 1234567 or  02? number, eg: 027 123456...'
                    }
                });

                $("#tb_personphonework_" + sitectr).rules("add", {
                    require_from_group: [1, ".validgroup_personphone_" + sitectr],
                    pattern: /02[0-9] \d{5,9}/,
                    messages: {
                        require_from_group: 'Please provide at least 1 phone number',
                        pattern: 'Must be in the format: 0? number, eg: 06 1234567 or  02? number, eg: 027 123456...'
                    }
                });


                /*
                messages: {
                tb_contact1emailaddressconfirm: {
                        equalTo: 'This must be the same as the email address above'
                },
                tb_contact1mobilephone: {
                    require_from_group: 'Please provide at least 1 phone number',
                    pattern: 'Must be in the format: 02? number, eg: 027 123456...'
                },
                tb_contact1homephone: {
                    require_from_group: 'Please provide at least 1 phone number',
                    pattern: 'Must be in the format: 0? number, eg: 06 1234567 or  02? number, eg: 027 123456...'
                },
                tb_contact1workphone: {
                    require_from_group: 'Please provide at least 1 phone number',
                    pattern: 'Must be in the format: 0? number, eg: 06 1234567 or  02? number, eg: 027 123456...'

*/

                return false;
            });




            // Delete a repeating section
            $('.deletesite').click(function () {
                $(this).parent('div').remove();
                return false;
            });


        });


        $.fn.repeater_changer = function (new_id) {
            return this.each(function () {
                $(this).find('input, textarea, select').each(function () {
                    var ob = $(this);
                    ob.attr('id', this.id.replace(/_\d$/, '_' + new_id));
                    ob.attr('name', this.name.replace(/_\d$/, '_' + new_id));
                });

                $(this).find('.repeatupdateid').each(function () {
                    var ob = $(this);
                    ob.attr('id', this.id.replace(/_\d$/, '_' + new_id));
                });

                $(this).find('.repeatupdatefor').each(function () {
                    var ob = $(this);
                    val = ob.attr('for');
                    val = val.replace(/_\d$/, '_' + new_id);
                    ob.attr('for', val);
                });

                $(this).find('.repeatupdatehtml').each(function () {
                    var ob = $(this);
                    val = ob.html();
                    val = val.replace(/\d$/, new_id);
                    ob.html(val);
                });

                $(this).find('.repeatupdatehref').each(function () {
                    var ob = $(this);
                    val = ob.attr('href');
                    val = val.replace(/_\d$/, '_' + new_id);
                    ob.attr('href', val);
                });

                $(this).find('.repeatupdateclass').each(function () {
                    var ob = $(this);
                    val = ob.attr('class');
                    val = val.replace(/_\d$/, '_' + new_id);
                    ob.attr('class', val);
                });

                $(this).find('.repeatupdatevalidgroup').each(function () {
                    var ob = $(this);
                    val = ob.data("validgroup");
                    val = val.replace(/_\d$/, '_' + new_id);
                    ob.attr("data-validgroup", val);
                });
                
            });

        };
    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Repeated Section -->

    <a href="#" class="addsite">Add Site</a>

    <!-- Accordian header start -->
    <div id="div_site_1" class="repeatupdateid">
        <div class="panel-group">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <a data-toggle="collapse" href="#collapse_site_1" class="repeatupdatehref">
                        <h4 class="panel-title repeatupdatehtml">Site 1</h4>
                    </a>
                </div>
                <div id="collapse_site_1" class="panel-collapse collapse repeatupdateid">
                    <div class="panel-body">

                        <!-- Accordian header end -->




                        <!-- Type of Registration -->

                        <div class="form-group">
                            <label class="control-label col-sm-4 repeatupdatefor" for="dd_registrationtype_1">Registration type</label>
                            <div class="col-sm-8">
                                <select id="dd_registrationtype_1" name="dd_registrationtype_1" class="form-control" required>
                                    <option></option>
                                    <option>1</option>
                                    <option>2</option>

                                </select>
                            </div>
                        </div>

                        <!-- Physical Address -->
                        <div class="form-group">
                            <label class="control-label col-sm-4 repeatupdatefor" for="cb_physicaladdressformat_1">
                                Physical premises address
        <img src="../Images/questionsmall.png" title="If you are in 'Address lookup mode' start typing your address (at least 5 characters).  A list of addresses will be given to you as options, please select one.  The more that you type the closer the options provided will be.  If you cannot find your address, change the lookup mode above." />
                            </label>
                            <div class="col-sm-8">
                                <span id="span_physicaladdressformat_1" class="repeatupdateid">Address lookup mode (preferred)</span>
                                <a href="javascript:void(0);" id="physicaladdressformat_1" class="addressformat repeatupdateid">Change</a>
                                <textarea id="tb_physicaladdress_1" name="tb_physicaladdress_1" class="form-control autoaddress" rows="4" required></textarea>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-sm-4 repeatupdatefor" for="cb_witholdphysical_1">Withhold the physical premises address from the public? </label>
                            <div class="col-sm-1">
                                <input id="cb_witholdphysical_1" name="cb_witholdphysical_1" class="form-control" type="checkbox" value="Withold physical address" />
                            </div>
                        </div>

                        <!-- Day-to-day person -->



                        <div class="form-group">
                            <label class="control-label col-sm-4 repeatupdatefor" for="tb_personemailaddress_1">Email address</label>
                            <div class="col-sm-8">
                                <input id="tb_personemailaddress_1" name="tb_personemailaddress_1" type="email" class="form-control" required />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-4 repeatupdatefor" for="tb_personemailconfirm_1">Please re-type your email address</label>
                            <div class="col-sm-8">
                                <input id="tb_personemailconfirm_1" name="tb_personemailconfirm_1" type="email" class="form-control" required />
                            </div>
                        </div>




                        <div class="form-group">
                            <label class="control-label col-sm-4 repeatupdatefor" for="tb_personphonemobile_1">Mobile phone</label>
                            <div class="col-sm-8">
                                <input id="tb_personphonemobile_1" placeholder="eg: 027 123456..." name="tb_personphonemobile_1" type="text" class="form-control repeatupdatevalidgroup" data-validgroup="personphone_1" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-4 repeatupdatefor" for="tb_personphonehome_1">Home phone</label>
                            <div class="col-sm-8">
                                <input id="tb_personphonehome_1" name="tb_personphonehome_1" placeholder="eg: 06 1234567 or 027 123456..." type="text" class="form-control repeatupdatevalidgroup" data-validgroup="personphone_1" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-4 repeatupdatefor" for="tb_personphonework_1">Work phone</label>
                            <div class="col-sm-8">
                                <input id="tb_personphonework_1" name="tb_personphonework_1" placeholder="eg: 06 1234567 or 027 123456..." type="text" class="form-control repeatupdatevalidgroup" data-validgroup="personphone_1" />
                            </div>
                        </div>


                        <div class="form-group">
                            <label class="control-label col-sm-4 repeatupdatefor" for="tb_personposition_1">Position</label>
                            <div class="col-sm-8">
                                <input id="tb_personposition_1" name="tb_personposition_1" type="text" class="form-control" required />
                            </div>
                        </div>


















                        <!-- Attach Scope of Operation -->

                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_scope">
                                Please upload your completed "Scope of Operations"
                                <img src="../Images/questionsmall.png" title="This document is required.  It is available at https://www.mpi.govt.nz/document-vault/11437.  Please complete the document, save it to your own device and then upload it here" />

                            </label>
                            <div class="col-sm-4">
                                Working On
                            </div>
                            <div class="col-sm-4">
                                <a href="https://www.mpi.govt.nz/document-vault/11437" target="_blank">https://www.mpi.govt.nz/document-vault/11437</a>
                            </div>

    <div class="col-sm-12">
                                DELETE
                            </div> 
                            <!-- Accordian footer start -->
                        </div>
                    </div>
                </div>
            </div>
            <!-- Accordian footer end -->


        </div>
    </div>


    <!-- Submit -->
    <div class="form-group">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
            <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info" Text="Submit" />
            <input id="Button1" type="button" value="button" />
        </div>
    </div>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
