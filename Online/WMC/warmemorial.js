// Google Map display template
$(function () {
    'use strict';

    $('header nav > .responsive-button').on('click', function () {
        $(this).next().toggle('fast');
    });

    $('nav.subpage-nav > .responsive-button').on('click', function () {
        $(this).next().toggle('fast');
    });

    $(window).resize(function () {
        if ($(window).width() >= 700) {
            $('nav.subpage-nav > .responsive-button ~ ul').removeAttr('style');
        }

        if ($(window).width() >= 1000) {
            $('header nav > .responsive-button ~ ul').removeAttr('style');
        }
    });
});