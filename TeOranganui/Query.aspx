<%@ Page Title="" Language="C#" MasterPageFile="~/TeOranganui.Master" AutoEventWireup="true" CodeBehind="Query.aspx.cs" Inherits="TeOranganui.Query" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Scripts/QueryBuilder/css/query-builder.default.css" rel="stylesheet" />
    <script src="Scripts/QueryBuilder/js/query-builder.standalone.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="builder"></div>

<script>
    var rules_basic = {
        condition: 'AND',
        rules: [{
            id: 'location',
            operator: 'equal',
            value: 1
        }, {
            condition: 'OR',
            rules: [{
                id: 'gender',
                operator: 'equal',
                value: 1
            }, {
                id: 'gender',
                operator: 'equal',
                value: 3
            }]
        }]
    };

    $('#builder').queryBuilder({
        plugins: ['bt-tooltip-errors'],

        filters: [{
            id: 'moenumber',
            label: 'MOE Number',
            type: 'string'
        }, {
            id: 'gender',
            label: 'Gender',
            type: 'integer',
            input: 'select',
            values: {
                1: 'Female',
                2: 'Male',
                3: 'Co-ed'
            },
            operators: ['equal', 'not_equal', 'in', 'not_in', 'is_null', 'is_not_null']
        }, {
            id: 'authority',
            label: 'Authority',
            type: 'integer',
            input: 'radio',
            values: {
                1: 'Private',
                0: 'State',
                2: 'Integrated'
            },
            operators: ['equal']
        }, {
            id: 'location',
            label: 'Location',
            type: 'integer',
            input: 'select',
            values: {
                1: 'Whanganui',
                2: 'Marton',
                3: 'Bulls',
                4: 'Taihape'
            },
            operators: ['equal', 'not_equal', 'in', 'not_in', 'is_null', 'is_not_null']
        }],

        rules: rules_basic
    });

    $('#btn-reset').on('click', function () {
        $('#builder').queryBuilder('reset');
    });

    $('#btn-set').on('click', function () {
        $('#builder').queryBuilder('setRules', rules_basic);
    });

    $('#btn-get').on('click', function () {
        var result = $('#builder').queryBuilder('getRules');

        if (!$.isEmptyObject(result)) {
            alert(JSON.stringify(result, null, 2));
        }
    });
</script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
