<!DOCTYPE html>
<html>
<head>
    <title>Manage HTML Sourced Data</title>
    <meta charset="utf-8" />
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" type="text/css" />
    <link href="https://cdn.jsdelivr.net/npm/gijgo@1.9.10/css/gijgo.min.css" rel="stylesheet" type="text/css" />
    <link href="https://cdn.jsdelivr.net/npm/gijgo@1.9.10/css/demo.min.css" rel="stylesheet" type="text/css" />
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/gijgo@1.9.10/js/gijgo.min.js" type="text/javascript"></script>


    <script type="text/javascript">
        var grid, dialog;

        function results_edit(e) {
            $('#ID').val(e.data.record.ID);
            $('#Name').val(e.data.record.Name);
            $('#PlaceOfBirth').val(e.data.record.PlaceOfBirth);
            dialog.open('Edit Player');
        }

        function results_delete(e) {
            if (confirm('Are you sure?')) {
                grid.removeRow(e.data.id - 1);
            }
        }

        function Save() {
            if ($('#ID').val()) {
                var id = parseInt($('#ID').val());
                grid.updateRow(id, { 'ID': id, 'Name': $('#Name').val(), 'PlaceOfBirth': $('#PlaceOfBirth').val() });
            } else {
                grid.addRow({ 'ID': grid.count(true) + 1, 'Name': $('#Name').val(), 'PlaceOfBirth': $('#PlaceOfBirth').val() });
            }
            dialog.close();
        }

        $(document).ready(function () {

            $('#btntest').click(function () {
                console.log(grid.getAll(true));
            })

            grid = $('#grid').grid({
                pager: { limit: 5 }
            });

            $("input[title='Next Page']").click(function () {
                alert(1);
            })
            $(":button").click(function () {
                alert(2);
            })
            $(".gj-button-md").click(function () {
                alert(3);
            })
            $(document).on('click', ".gj-button-md", function () {
                alert(4);
            })

            dialog = $('#dialog').dialog();

            $('#btnAdd').on('click', function () {
                $('#ID').val('');
                $('#Name').val('');
                $('#PlaceOfBirth').val('');
                dialog.open('Add Player');
            });

            $('#btnSave').on('click', Save);

            $('#btnCancel').on('click', function () {
                dialog.close();
            });

            $('#btnSearch').on('click', function () {
                grid.reload({ Name: $('#txtName').val(), PlaceOfBirth: $('#txtPlaceOfBirth').val() });
            });

            $('#btnClear').on('click', function () {
                $('#srcName').val('');
                $('#srcPlaceOfBirth').val('');
                grid.reload({ Name: '', PlaceOfBirth: '' });
            });
        });
    </script>


</head>
<body>
    <!-------------------------------------------------------------------->

    <table>
        <thead>
            <tr>
                <th>Monday</th>
                <th>Tuesday</th>
                <th>Wednesday</th>
                <th>Thursday</th>
                <th>Friday</th>
                <th>Saturday</th>
                <th>Sunday</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>
                    <div class="date">5 Nov 2018</div>
                    <div id="event_102" class="event Training others">
                        <div class="title" title="On water steady state 10+km @ 20">05:45 - 07:00 Seniors Training</div>
                    </div>
                    <div id="event_43" class="event Training others">
                        <div class="title" title="On Water">17:15 - 19:30 Novice Training</div>
                        <div class="coaches" style="display: none">
                            <div class="person" id="coach_event_43_57" style="background-color: lightgreen;">Peer</div>
                        </div>
                    </div>
                    <div id="event_95" class="event Training others">
                        <div class="title" title="Weights">17:15 - 20:00 Senior Training</div>
                    </div>
                </td>
                <td>
                    <div class="date">6 Nov 2018</div>
                    <div id="event_71" class="event Training others">
                        <div class="title" title="Ergs 2 x 30min @ 20">06:00 - 07:00 Senior Training</div>
                        <div class="coaches" style="display: none">
                            <div class="person" id="coach_event_71_85" style="background-color: orange;">John</div>
                        </div>
                    </div>
                    <div id="event_104" class="event CommitteeMeeting mine">
                        <div class="title" title="">18:00 - 20:00 Committee meeting</div>
                    </div>
                    </td>
                </tr>

        </tbody>
    </table>

    <!-------------------------------------------------------------------->


    <div class="gj-margin-top-10">
        <div class="gj-float-left">
            <form class="display-inline">
                <input id="txtName" type="text" placeholder="Name..." class="gj-textbox-md gj-display-inline-block gj-width-200" />
                <input id="txtPlaceOfBirth" type="text" placeholder="Place Of Birth..." class="gj-textbox-md gj-display-inline-block gj-width-200" />
                <button id="btnSearch" type="button" class="gj-button-md">Search</button>
                <button id="btnClear" type="button" class="gj-button-md">Clear</button>
            </form>
        </div>
        <div class="gj-float-right">
            <button id="btnAdd" type="button" class="gj-button-md">Add New Record</button>
        </div>
    </div>
    <div class="gj-clear-both"></div>
    <div class="gj-margin-top-10">
        <table id="grid">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Regatta</th>
                    <th>Event</th>
                    <th>Place</th>
                    <th data-tmpl="<span class='material-icons gj-cursor-pointer'>results_edit</span>" align="center" data-events="click: results_edit"></th>
                    <th data-tmpl="<span class='material-icons gj-cursor-pointer'>results_delete</span>" align="center" data-events="click: results_delete"></th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>5</td>
                    <td>North Island Secondary Schools (Fri 02 Mar 18)</td>
                    <td>boys u17 double sculls - Heat 1</td>
                    <td>4</td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>5</td>
                    <td>North Island Secondary Schools (Fri 02 Mar 18)</td>
                    <td>boys u16 single sculls - Heat 2</td>
                    <td>2</td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>5</td>
                    <td>North Island Secondary Schools (Fri 02 Mar 18)</td>
                    <td>boys u16 single sculls - Semi Final 2</td>
                    <td>5</td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>5</td>
                    <td>North Island Secondary Schools (Fri 02 Mar 18)</td>
                    <td>boys u17 double sculls - C Final</td>
                    <td>1</td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>5</td>
                    <td>North Island Secondary Schools (Fri 02 Mar 18)</td>
                    <td>boys u16 single sculls - B Final</td>
                    <td>1</td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>10</td>
                    <td>Karapiro Christmas (Fri 15 Dec 17)</td>
                    <td>boys u16 single sculls - heat 3</td>
                    <td>3</td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>11</td>
                    <td>Jury Cup (Sat 25 Nov 17)</td>
                    <td>mens club coxless quad sculls</td>
                    <td>6</td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>12</td>
                    <td>North Island Secondary Schools (Fri 10 Mar 17)</td>
                    <td>boys u18 novice double sculls - heat 3</td>
                    <td>6</td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>12</td>
                    <td>North Island Secondary Schools (Fri 10 Mar 17)</td>
                    <td>boys u18 novice coxed four</td>
                    <td>0</td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>4</td>
                    <td>Jury Cup (Sat 10 Dec 16)</td>
                    <td>boys u16 coxed quad sculls</td>
                    <td>5</td>
                    <td></td>
                    <td></td>
                </tr>
            </tbody>
        </table>






        <table id="grid1" style="display: none">
            <thead>
                <tr>
                    <th width="56">ID</th>
                    <th data-sortable="true">Name</th>
                    <th data-field="PlaceOfBirth">Place Of Birth</th>
                    <th width="64" data-tmpl="<span class='material-icons gj-cursor-pointer'>edit</span>" align="center" data-events="click: Edit"></th>
                    <th width="64" data-tmpl="<span class='material-icons gj-cursor-pointer'>delete</span>" align="center" data-events="click: Delete"></th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>1</td>
                    <td>Hristo Stoichkov</td>
                    <td>Plovdiv, Bulgaria</td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>Ronaldo Luís Nazário de Lima</td>
                    <td>Rio de Janeiro, Brazil</td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>3</td>
                    <td>David Platt</td>
                    <td>Chadderton, Lancashire, England</td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>4</td>
                    <td>Manuel Neuer</td>
                    <td>Gelsenkirchen, West Germany</td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>5</td>
                    <td>James Rodríguez</td>
                    <td>Cúcuta, Colombia</td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>6</td>
                    <td>Dimitar Berbatov</td>
                    <td>Blagoevgrad, Bulgaria</td>
                    <td></td>
                    <td></td>
                </tr>
            </tbody>
        </table>
    </div>




    <div id="dialog" class="gj-display-none" width="360" data-auto-open="false" data-modal="true">
        <div data-role="body">
            <input type="hidden" id="ID" />
            <div class="">
                <input type="text" class="gj-textbox-md" id="Name" placeholder="Name...">
            </div>
            <div class="gj-margin-top-20">
                <input type="text" class="gj-textbox-md" id="PlaceOfBirth" placeholder="Place Of Birth..." />
            </div>
        </div>
        <div data-role="footer">
            <button type="button" id="btnSave" class="gj-button-md">Save</button>
            <button type="button" id="btnCancel" class="gj-button-md">Cancel</button>
        </div>
    </div>
    <button type="button" id="btntest">Test</button>

</body>
</html>
