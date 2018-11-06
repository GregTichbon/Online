<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Test2.aspx.cs" Inherits="UBC.Test2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>

    <style>
        .droppable {
            width: 100px;
            height: 100px;
            background: grey;
            font-size: 15pt;
            font-family: Helvetical, Arial, sans-serif;
            color: white;
            line-height: 100px;
            vertical-align: middle;
            text-align: center;
        }

        .draggable {
            width: 100px;
            height: 100px;
            background: green;
        }

        .placeholder {
            background: red;
        }
    </style>
    <script>
        var original = {};

        function compress(droppable) {
            var dropIndex = $('td').index(droppable);
            $.each($('td:not(:has(.draggable:visible), .placeholder), td:has(.ui-draggable-dragging)'), function (index, value) {
                if ($('td').index(value) > dropIndex) {
                    moveRight(droppable);
                    return;
                }
            });
            moveLeft(droppable);
        };

        function moveRight(droppable) {
            var nextIndex = $('td').index(droppable) + 1;
            if (nextIndex > 8) {
                console.log(nextIndex);
                return;
            }
            $(droppable).children('.draggable:visible:not(.ui-draggable-dragging):last').detach().prependTo($('td').eq(nextIndex));
            if ($('td').eq(nextIndex).children('.draggable:visible:not(.ui-draggable-dragging)').length > 1) {
                moveRight($('td').eq(nextIndex));
            }
        };

        function moveLeft(droppable) {
            var nextIndex = $('td').index(droppable) - 1;
            if (nextIndex < 0) {
                console.log(nextIndex);
                return;
            }
            $(droppable).children('.draggable:visible:not(.ui-draggable-dragging):last').detach().prependTo($('td').eq(nextIndex));
            if ($('td').eq(nextIndex).children('.draggable:visible:not(.ui-draggable-dragging)').length > 1) {
                moveLeft($('td').eq(nextIndex));
            }
        };

        function revert() {
            $.each(original, function (key, value) {
                if ($('td').eq(value).children().length === 0 &&
                    !$('td').eq(value).hasClass('placeholder')) {
                    $('#' + key).detach().prependTo($('td').eq(value));
                    revert();
                }
            })
        };
        $(document).ready(function () {

            $('.draggable').draggable({
                placeholder: 'placeholder',
                zIndex: 1000,
                containment: 'table',
                helper: function (evt) {
                    var that = $(this).clone().get(0);
                    $(this).hide();
                    return that;
                },
                start: function (evt, ui) {
                    $.each($('.draggable:not(.ui-draggable-dragging)'), function (index, value) {
                        original[value.id] = $('td').index($(value).parent());
                    });
                },
                cursorAt: {
                    top: 20,
                    left: 20
                }
            });

            $('.droppable').droppable({
                hoverClass: 'placeholder',
                drop: function (evt, ui) {
                    alert('dropped');
                    var draggable = ui.draggable;
                    var droppable = this;

                    $(draggable).detach().css({
                        top: 0,
                        left: 0
                    }).prependTo($(droppable)).show();
                },
                over: function (evt, ui) {
                    console.log('over');
                    var draggable = ui.draggable;
                    var droppable = this;
                    revert();
                    if ($(droppable).children('.draggable:visible:not(.ui-draggable-dragging)').length > 0) {
                        compress(droppable);
                    }
                }
            })
        });


    </script>
</head>
<body>
    <form id="form1" runat="server">
        <table>
            <tr>
                <td class="droppable">
                    <div class="draggable" id="d1">1</div>
                </td>
                <td class="droppable"></td>
                <td class="droppable">
                    <div class="draggable" id="d2">2</div>
                </td>
            </tr>
            <tr>
                <td class="droppable"></td>
                <td class="droppable">
                    <div class="draggable" id="d3">3</div>
                </td>
                <td class="droppable"></td>
            </tr>
            <tr>
                <td class="droppable">
                    <div class="draggable" id="d4">4</div>
                </td>
                <td class="droppable">
                    <div class="draggable" id="d5">5</div>
                </td>
                <td class="droppable">
                    <div class="draggable" id="d6">6</div>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
