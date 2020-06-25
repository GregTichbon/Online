<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="tabletoExcel.aspx.cs" Inherits="TOHW.Pickups.tabletoExcel" %>


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

        .worker {
            font-weight: bolder;
        }

        .Additional {
            color: green;
        }

        #dd_assignedto, #search, #dd_status {
            background-color: #EFEFEF;
            border-radius: 4px;
            border: 1px solid #D0D0D0;
            overflow: auto;
            height: 25px;
        }

        option {
            background-color: #82caff;
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
                    display: block;
                    cursor: pointer;
                }

                .toggle label input {
                    display: none;
                }

            .toggle .input-checked /*, .bounds input:checked + span works for firefox and ie9 but breaks js for ie8(ONLY) */ {
                background-color: lightgreen;
            }


        /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
        #map {
            height: 600px;
            width: 100%;
            display: none;
        }
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
    <script src="/Scripts/table2Excel/dist/jquery.table2excel.js"></script>

    <script src="https://code.jquery.com/jquery-migrate-3.0.0.min.js"></script>

    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
    <script src="/Scripts/addclear.min.js"></script>

    <script src="/Scripts/moment/moment.js"></script>
    <script src="/Scripts/jquery.ui.autocomplete.scroll.min.js"></script>


    <script type="text/javascript">

        $(document).ready(function () {

            $("#btn_export").click(function () {
                $("#tbl_data").table2excel({
                    name: "Pickups",
                    // exclude CSS class
                    exclude: ".noExport",
                    name: "Sheet1",
                    filename: "Pickups" + new Date().toISOString().replace(/[\-\:\.]/g, ""), //do not include extension
                    fileext: ".xls"
                });
            });


        }) //document.ready





    </script>

</head>
<body>
    <form method="post" action="./default.aspx" id="form1">


        <input id="btn_export" type="button" value="Export" />

        <table id="tbl_data" class="table table-striped">
            <tbody>
                <tr id="tr_7391" class="Current" data-version="46" data-gender="Female" data-status="Current" data-name="Aazaria Taripo" data-worker="">
                    <td id="name_7391">Aazaria Taripo</td>
                    <td>
                        <select class="address" id="address_7391" data-value="24 Moore Ave" data-count="1">
                            <option></option>
                            <option>24 Moore Ave</option>
                        </select></td>
                    <td>
                        <select class="status" id="status_7391" data-value="Picked up">
                            <option></option>
                            <option>Coming</option>
                            <option>Not Coming</option>
                        </select></td>
                    <td>
                        <select class="assignedto" id="assignedto_7391" data-value="Keith">
                            <option></option>
                            <option>Jay</option>
                            <option>Keith</option>
                        </select></td>
                    <td>
                        <input class="note" id="note_7391" value="xxxxxx" type="text" /></td>
                </tr>
                <tr id="tr_7429" class="Current" data-version="7" data-gender="Male" data-status="Current" data-name="Aden Taputoro-Thomason" data-worker="">
                    <td id="name_7429">Aden Taputoro-Thomason</td>
                    <td>
                        <select class="address" id="address_7429" data-value="" data-count="1">
                            <option></option>
                            <option></option>
                            <option>Other Address</option>
                            <option>Other Person</option>
                            <option>32 Totara St</option>
                        </select></td>
                    <td>
                        <select class="status" id="status_7429" data-value="Made own way">
                            <option></option>
                            <option>Coming</option>
                        </select></td>
                    <td>
                        <select class="assignedto" id="assignedto_7429" data-value="">
                            <option></option>
                            <option>Jay</option>
                            <option>Keith</option>
                        </select></td>
                    <td>
                        <input class="note" id="note_7429" value="zzzzzzzzzzz" data-value="yyyyyyyyyy" type="text" /></td>
                </tr>

            </tbody>
        </table>


    </form>
</body>
</html>

