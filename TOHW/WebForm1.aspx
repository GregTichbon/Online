<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Te Ora Hou
    </title>
    <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" />
    <style>
        .Casual {
            color: red;
        }

        #dd_assignedto {
            margin: 4px;
            background-color: #EFEFEF;
            border-radius: 4px;
            border: 1px solid #D0D0D0;
            overflow: auto;
            padding: 3px;
        }

        #btn_save {
            margin: 4px;
            background-color: #EFEFEF;
            border-radius: 4px;
            border: 1px solid #D0D0D0;
            overflow: auto;
            padding: 4px;
        }

        .toggle {
            margin: 4px;
            background-color: #EFEFEF;
            border-radius: 4px;
            border: 1px solid #D0D0D0;
            overflow: auto;
            float: left;
        }

            .toggle label {
                float: left;
                width: 5.0em;
            }

                .toggle label span {
                    text-align: center;
                    padding: 3px 0px;
                    display: block;
                    cursor: pointer;
                }

                .toggle label input {
                    display: none;
                }


            .toggle .input-checked /*, .bounds input:checked + span works for firefox and ie9 but breaks js for ie8(ONLY) */ {
                background-color: lightgreen;
            }
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
    <script src="https://code.jquery.com/jquery-migrate-3.0.0.min.js"></script>

    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>

    <script type="text/javascript">
        var address_id = "";
        var id = "";
        $(document).ready(function () {

            showhideclasses();
            $('label').click(function () {
                if ($(this).children('input').is(":checked")) {
                    $(this).children('span').addClass('input-checked');
                } else {
                    $(this).children('span').removeClass('input-checked');
                }
                showhideclasses();
            });
            $("#dd_assignedto").change(function () {
                showhideclasses()
            });

            $("#btn_save").click(function () {
                alert("thanks");
            })

            $("#dialog").dialog({
                autoOpen: false,
                buttons: {
                    OK: function () {
                        $("#" + address_id + " option").eq(3).remove();
                        if ($("#otheraddress").val() == "") {
                            $("#" + address_id + " option").eq(0).prop('selected', true);
                        } else {
                            $("#" + address_id).append($('<option>', {
                                text: $("#otheraddress").val(),
                                selected: "selected"
                            }));
                        }
                        $(this).dialog("close");
                        update();
                    }
                }
            });

            $(".address").change(function () {
                address_id = $(this).attr("id");
                id = address_id.substring(8);
                if ($(this).val() == 'Other Address') {
                    $("#dialog").dialog("open");
                } else if ($(this).val() == 'Other Person') {
                    $("#" + address_id + " option").eq(0).prop('selected', true);
                    alert("to do");
                }
            });

            $(".assignedto").change(function () {
                id = $(this).attr("id").substring(11);
                update();
            });

            function update() {
                alert('do update for id: ' + id);
                $.ajax({
                    url: "data.asmx/update?id=" + id + "&address=" + xx + "&assignedto=" + xx, success: function (result) {
                        details = $.parseJSON(result);
                    }
                });
            }


            function showhideclasses() {
                status = "|Current";
                if ($('#cb_casual').is(":checked")) {
                    status += "|Casual"
                }
                status += "|";

                gender = "";
                genderdelim = "";
                if ($('#cb_female').is(":checked")) {
                    gender += "|Female"
                    genderdelim = "|";
                }
                if ($('#cb_male').is(":checked")) {
                    gender += "|Male"
                    genderdelim = "|";
                }
                gender += genderdelim;
                assigned = $("#dd_assignedto").val();

                $('#tbl_data > tbody  > tr').each(function () {
                    myid = $(this).attr("id").substring(3);
                    mygender = $(this).data("gender");
                    mystatus = $(this).data("status");
                    myassigned = $(this).find(".assignedto").val();

                    if ((gender.indexOf('|' + mygender + '|') != -1) && (status.indexOf('|' + mystatus + '|') != -1) && (myassigned == assigned || assigned == 'All')) {
                        $(this).show();
                    } else {
                        $(this).hide();
                    }
                });
            }
        })
    </script>


</head>
<body>
    <form method="post" action="./default.aspx" id="form1">
        

        
        <div>





            
            
            

 

            


    


                <table id="tbl_data">
                    <tr id="tr_90" class="Current" data-gender="Female" data-status="Current">
                        <td>Aroha Ranginui-Hiri</td>
                        <td>
                            <select class="address" id="address_90">
                                <option>40 Tawa St
                                </option>
                                <option>Other Address</option>
                                <option>Other Person</option>
                            </select></td>
                        <td>
                            <select class="status" id="status_90">
                                <option></option>
                                <option>Coming</option>
                                <option>Not Coming</option>
                                <option>No Response</option>
                                <option>Call in</option>
                                <option>Picked up</option>
                                <option>Picked up from another address</option>
                                <option>Called in - not coming</option>
                            </select></td>
                        <td></td>
                        <td>
                            <select class="assignedto" id="assignedto_90">
                                <option></option>
                                <option>Jay</option>
                                <option>Keith</option>
                                <option>Jordi</option>
                                <option>Greg</option>
                                <option>Nate</option>
                                <option>Watties</option>
                                <option>Isa</option>
                                <option>Judy</option>
                            </select></td>
                    </tr>
                </table>

        


            

        </div>
    </form>
</body>
</html>
