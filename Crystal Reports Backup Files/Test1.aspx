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
                    <div id="event_102" class="event Training others past">
                        <div class="title" title="On water steady state 10+km @ 20">05:45 - 07:00 Seniors Training</div>
                        <div class="coaches" style="display: none">
                            <div class="person" id="coach_event_102_59" style="background-color: #FF681C;">Bob</div>
                        </div>
                    </div>
                    <div id="event_43" class="event Training others">
                        <div class="wrapper">
                            <div class="title" title="On Water">17:15 - 19:30 Novice Training</div>
                            <span id="attend_event_43" class="attendUnknown"></span></div>
                        <div class="coaches" style="display: none">
                            <div class="person" id="coach_event_43_57" style="background-color: lightgreen;">Peer</div>
                        </div>
                    </div>
                    <div id="event_95" class="event Training others">
                        <div class="wrapper">
                            <div class="title" title="Weights">17:15 - 20:00 Senior Training</div>
                            <span id="attend_event_95" class="attendUnknown"></span></div>
                    </div>
                </td>
                <td>
                    <div class="date">6 Nov 2018</div>
                    <div id="event_71" class="event Training others">
                        <div class="wrapper">
                            <div class="title" title="Ergs 2 x 30min @ 20">06:00 - 07:00 Senior Training</div>
                            <span id="attend_event_71" class="attendUnknown"></span></div>
                        <div class="coaches" style="display: none">
                            <div class="person" id="coach_event_71_85" style="background-color: orange;">John</div>
                        </div>
                    </div>
                    <div id="event_104" class="event CommitteeMeeting mine">
                        <div class="wrapper">
                            <div class="title" title="">18:00 - 20:00 Committee meeting</div>
                            <span id="attend_event_104" class="attendUnknown"></span></div>
                    </div>
                </td>
                <td>
                    <div class="date">7 Nov 2018</div>
                    <div id="event_52" class="event Training others">
                        <div class="wrapper">
                            <div class="title" title="On water">17:15 - 19:30 Novice Training</div>
                            <span id="attend_event_52" class="attendUnknown"></span></div>
                        <div class="coaches" style="display: none">
                            <div class="person" id="coach_event_52_59" style="background-color: #FF681C;">Bob</div>
                            <div class="person" id="coach_event_52_57" style="background-color: lightgreen;">Peer</div>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="date">8 Nov 2018</div>
                    <div id="event_79" class="event Training others">
                        <div class="wrapper">
                            <div class="title" title="Water/erg">05:45 - 07:00 Senior Training</div>
                            <span id="attend_event_79" class="attendUnknown"></span></div>
                        <div class="coaches" style="display: none">
                            <div class="person" id="coach_event_79_85" style="background-color: orange;">John</div>
                        </div>
                    </div>
                    <div id="event_103" class="event Training others">
                        <div class="wrapper">
                            <div class="title" title="">17:15 - 19:00 Senior Training</div>
                            <span id="attend_event_103" class="attendUnknown"></span></div>
                    </div>
                </td>
                <td>
                    <div class="date">9 Nov 2018</div>
                    <div id="event_98" class="event Training others">
                        <div class="wrapper">
                            <div class="title" title="">All day Senior Cross training</div>
                            <span id="attend_event_98" class="attendUnknown"></span></div>
                    </div>
                    <div id="event_96" class="event Training others">
                        <div class="wrapper">
                            <div class="title" title="Erg">06:00 - 07:00 Novice Training</div>
                            <span id="attend_event_96" class="attendUnknown"></span></div>
                        <div class="coaches" style="display: none">
                            <div class="person" id="coach_event_96_59" style="background-color: #FF681C;">Bob</div>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="date">10 Nov 2018</div>
                    <div id="event_97" class="event Training others">
                        <div class="wrapper">
                            <div class="title" title="On Water">07:00 - 08:00 Senior Training</div>
                            <span id="attend_event_97" class="attendUnknown"></span></div>
                        <div class="coaches" style="display: none">
                            <div class="person" id="coach_event_97_85" style="background-color: orange;">John</div>
                        </div>
                    </div>
                    <div id="event_101" class="event Training others">
                        <div class="wrapper">
                            <div class="title" title="On Water">08:00 - 10:00 Novice Training</div>
                            <span id="attend_event_101" class="attendUnknown"></span></div>
                        <div class="coaches" style="display: none">
                            <div class="person" id="coach_event_101_59" style="background-color: #FF681C;">Bob</div>
                            <div class="person" id="coach_event_101_57" style="background-color: lightgreen;">Peer</div>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="date">11 Nov 2018</div>
                    <div id="event_100" class="event SocialRow mine">
                        <div class="wrapper">
                            <div class="title" title="Fun or serious for whoever turns up">08:30 - 11:00 Social Rowers</div>
                            <span id="attend_event_100" class="attendUnknown"></span></div>
                    </div>
                </td>
            </tr>
            <tr></td><td>
                <div class="date">12 Nov 2018</div>
                <div id="event_44" class="event Training others">
                    <div class="wrapper">
                        <div class="title" title="On Water">17:15 - 19:30 Novice Training</div>
                        <span id="attend_event_44" class="attendUnknown"></span></div>
                </div>
            </td>
                <td>
                    <div class="date">13 Nov 2018</div>
                    <div id="event_72" class="event Training others">
                        <div class="wrapper">
                            <div class="title" title="">06:00 - 07:00 Senior Training</div>
                            <span id="attend_event_72" class="attendUnknown"></span></div>
                        <div class="coaches" style="display: none">
                            <div class="person" id="coach_event_72_85" style="background-color: orange;">John</div>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="date">14 Nov 2018</div>
                    <div id="event_53" class="event Training others">
                        <div class="wrapper">
                            <div class="title" title="">17:15 - 19:30 Novice Training</div>
                            <span id="attend_event_53" class="attendUnknown"></span></div>
                    </div>
                </td>
                <td>
                    <div class="date">15 Nov 2018</div>
                    <div id="event_80" class="event Training others">
                        <div class="wrapper">
                            <div class="title" title="">06:00 - 07:00 Senior Training</div>
                            <span id="attend_event_80" class="attendUnknown"></span></div>
                        <div class="coaches" style="display: none">
                            <div class="person" id="coach_event_80_85" style="background-color: orange;">John</div>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="date">16 Nov 2018</div>
                </td>
                <td>
                    <div class="date">17 Nov 2018</div>
                </td>
                <td>
                    <div class="date">18 Nov 2018</div>
                </td>
            </tr>
            <tr></td><td>
                <div class="date">19 Nov 2018</div>
                <div id="event_45" class="event Training others">
                    <div class="wrapper">
                        <div class="title" title="">17:15 - 19:30 Novice Training</div>
                        <span id="attend_event_45" class="attendUnknown"></span></div>
                </div>
            </td>
                <td>
                    <div class="date">20 Nov 2018</div>
                    <div id="event_73" class="event Training others">
                        <div class="wrapper">
                            <div class="title" title="">06:00 - 07:00 Senior Training</div>
                            <span id="attend_event_73" class="attendUnknown"></span></div>
                        <div class="coaches" style="display: none">
                            <div class="person" id="coach_event_73_85" style="background-color: orange;">John</div>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="date">21 Nov 2018</div>
                    <div id="event_54" class="event Training others">
                        <div class="wrapper">
                            <div class="title" title="">17:15 - 19:30 Novice Training</div>
                            <span id="attend_event_54" class="attendUnknown"></span></div>
                    </div>
                </td>
                <td>
                    <div class="date">22 Nov 2018</div>
                    <div id="event_81" class="event Training others">
                        <div class="wrapper">
                            <div class="title" title="">06:00 - 07:00 Senior Training</div>
                            <span id="attend_event_81" class="attendUnknown"></span></div>
                        <div class="coaches" style="display: none">
                            <div class="person" id="coach_event_81_85" style="background-color: orange;">John</div>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="date">23 Nov 2018</div>
                </td>
                <td>
                    <div class="date">24 Nov 2018</div>
                    <div id="event_99" class="event Regatta others">
                        <div class="wrapper">
                            <div class="title" title="">05:00 - 18:00 Waitara Regatta</div>
                            <span id="attend_event_99" class="attendUnknown"></span></div>
                        <div class="coaches" style="display: none">
                            <div class="person" id="coach_event_99_59" style="background-color: #FF681C;">Bob</div>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="date">25 Nov 2018</div>
                </td>
            </tr>
            <tr></td><td>
                <div class="date">26 Nov 2018</div>
                <div id="event_46" class="event Training others">
                    <div class="wrapper">
                        <div class="title" title="">17:15 - 19:30 Novice Training</div>
                        <span id="attend_event_46" class="attendUnknown"></span></div>
                </div>
            </td>
                <td>
                    <div class="date">27 Nov 2018</div>
                    <div id="event_74" class="event Training others">
                        <div class="wrapper">
                            <div class="title" title="">06:00 - 07:00 Senior Training</div>
                            <span id="attend_event_74" class="attendUnknown"></span></div>
                        <div class="coaches" style="display: none">
                            <div class="person" id="coach_event_74_85" style="background-color: orange;">John</div>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="date">28 Nov 2018</div>
                    <div id="event_55" class="event Training others">
                        <div class="wrapper">
                            <div class="title" title="">17:15 - 19:30 Novice Training</div>
                            <span id="attend_event_55" class="attendUnknown"></span></div>
                    </div>
                </td>
                <td>
                    <div class="date">29 Nov 2018</div>
                    <div id="event_82" class="event Training others">
                        <div class="wrapper">
                            <div class="title" title="">06:00 - 07:00 Senior Training</div>
                            <span id="attend_event_82" class="attendUnknown"></span></div>
                        <div class="coaches" style="display: none">
                            <div class="person" id="coach_event_82_85" style="background-color: orange;">John</div>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="date">30 Nov 2018</div>
                </td>
                <td>
                    <div class="date">1 Dec 2018</div>
                </td>
                <td>
                    <div class="date">2 Dec 2018</div>
                </td>
            </tr>
            <tr></td><td>
                <div class="date">3 Dec 2018</div>
                <div id="event_47" class="event Training others">
                    <div class="wrapper">
                        <div class="title" title="">17:15 - 19:30 Novice Training</div>
                        <span id="attend_event_47" class="attendUnknown"></span></div>
                </div>
            </td>
                <td>
                    <div class="date">4 Dec 2018</div>
                    <div id="event_75" class="event Training others">
                        <div class="wrapper">
                            <div class="title" title="">06:00 - 07:00 Senior Training</div>
                            <span id="attend_event_75" class="attendUnknown"></span></div>
                        <div class="coaches" style="display: none">
                            <div class="person" id="coach_event_75_85" style="background-color: orange;">John</div>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="date">5 Dec 2018</div>
                    <div id="event_56" class="event Training others">
                        <div class="wrapper">
                            <div class="title" title="">17:15 - 19:30 Novice Training</div>
                            <span id="attend_event_56" class="attendUnknown"></span></div>
                    </div>
                </td>
                <td>
                    <div class="date">6 Dec 2018</div>
                    <div id="event_83" class="event Training others">
                        <div class="wrapper">
                            <div class="title" title="">06:00 - 07:00 Senior Training</div>
                            <span id="attend_event_83" class="attendUnknown"></span></div>
                        <div class="coaches" style="display: none">
                            <div class="person" id="coach_event_83_85" style="background-color: orange;">John</div>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="date">7 Dec 2018</div>
                </td>
                <td>
                    <div class="date">8 Dec 2018</div>
                </td>
                <td>
                    <div class="date">9 Dec 2018</div>
                </td>
            </tr>
            <tr></td><td>
                <div class="date">10 Dec 2018</div>
                <div id="event_48" class="event Training others">
                    <div class="wrapper">
                        <div class="title" title="">17:15 - 19:30 Novice Training</div>
                        <span id="attend_event_48" class="attendUnknown"></span></div>
                </div>
            </td>
                <td>
                    <div class="date">11 Dec 2018</div>
                    <div id="event_76" class="event Training others">
                        <div class="wrapper">
                            <div class="title" title="">06:00 - 07:00 Senior Training</div>
                            <span id="attend_event_76" class="attendUnknown"></span></div>
                        <div class="coaches" style="display: none">
                            <div class="person" id="coach_event_76_85" style="background-color: orange;">John</div>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="date">12 Dec 2018</div>
                    <div id="event_57" class="event Training others">
                        <div class="wrapper">
                            <div class="title" title="">17:15 - 19:30 Novice Training</div>
                            <span id="attend_event_57" class="attendUnknown"></span></div>
                    </div>
                </td>
                <td>
                    <div class="date">13 Dec 2018</div>
                    <div id="event_84" class="event Training others">
                        <div class="wrapper">
                            <div class="title" title="">06:00 - 07:00 Senior Training</div>
                            <span id="attend_event_84" class="attendUnknown"></span></div>
                        <div class="coaches" style="display: none">
                            <div class="person" id="coach_event_84_85" style="background-color: orange;">John</div>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="date">14 Dec 2018</div>
                </td>
                <td>
                    <div class="date">15 Dec 2018</div>
                </td>
                <td>
                    <div class="date">16 Dec 2018</div>
                </td>
            </tr>
            <tr></td><td>
                <div class="date">17 Dec 2018</div>
                <div id="event_49" class="event Training others">
                    <div class="wrapper">
                        <div class="title" title="">17:15 - 19:30 Novice Training</div>
                        <span id="attend_event_49" class="attendUnknown"></span></div>
                </div>
            </td>
                <td>
                    <div class="date">18 Dec 2018</div>
                    <div id="event_77" class="event Training others">
                        <div class="wrapper">
                            <div class="title" title="">06:00 - 07:00 Senior Training</div>
                            <span id="attend_event_77" class="attendUnknown"></span></div>
                        <div class="coaches" style="display: none">
                            <div class="person" id="coach_event_77_85" style="background-color: orange;">John</div>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="date">19 Dec 2018</div>
                    <div id="event_58" class="event Training others">
                        <div class="wrapper">
                            <div class="title" title="">17:15 - 19:30 Novice Training</div>
                            <span id="attend_event_58" class="attendUnknown"></span></div>
                    </div>
                </td>
                <td>
                    <div class="date">20 Dec 2018</div>
                    <div id="event_85" class="event Training others">
                        <div class="wrapper">
                            <div class="title" title="">06:00 - 07:00 Senior Training</div>
                            <span id="attend_event_85" class="attendUnknown"></span></div>
                        <div class="coaches" style="display: none">
                            <div class="person" id="coach_event_85_85" style="background-color: orange;">John</div>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="date">21 Dec 2018</div>
                </td>
                <td>
                    <div class="date">22 Dec 2018</div>
                </td>
                <td>
                    <div class="date">23 Dec 2018</div>
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
