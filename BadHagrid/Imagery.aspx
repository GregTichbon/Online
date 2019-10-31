<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Imagery.aspx.cs" Inherits="BadHagrid.Imagery" %>


<!doctype html>
<html lang="en" class="">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width">

    <title>Infinite Scroll &#xB7; Masonry images</title>
    <style>
        body {
            font-family: sans-serif;
            line-height: 1.4;
            padding: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .grid__col-sizer,
        .photo-item {
            width: 32%;
        }

        .grid__gutter-sizer {
            width: 2%;
        }

        .photo-item {
            margin-bottom: 10px;
            float: left;
        }

        .photo-item__image {
            display: block;
            max-width: 100%;
        }

        .photo-item__caption {
            position: absolute;
            left: 10px;
            bottom: 10px;
            margin: 0;
        }

            .photo-item__caption a {
                color: white;
                font-size: 0.8em;
                text-decoration: none;
            }

        .page-load-status {
            display: none; /* hidden by default */
            padding-top: 20px;
            border-top: 1px solid #DDD;
            text-align: center;
            color: #777;
        }

        /* loader ellips in separate pen CSS */
    </style>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://unpkg.com/infinite-scroll@3/dist/infinite-scroll.pkgd.js"></script>
    <script src="https://unpkg.com/masonry-layout@4/dist/masonry.pkgd.js"></script>





</head>

<body>

    <h1>Infinite Scroll - Loading JSON + Masonry</h1>

    <p>Loading photos from the <a href="https://unsplash.com/developers?utm_source=infinite-scroll-demos&utm_medium=referral&utm_campaign=api-credit">Unsplash API</a></p>

    <div class="grid">
        <div class="grid__col-sizer"></div>
        <div class="grid__gutter-sizer"></div>
    </div>

    <div class="page-load-status">
        <div class="loader-ellips infinite-scroll-request">
            <span class="loader-ellips__dot"></span>
            <span class="loader-ellips__dot"></span>
            <span class="loader-ellips__dot"></span>
            <span class="loader-ellips__dot"></span>
        </div>
        <p class="infinite-scroll-last">End of content</p>
        <p class="infinite-scroll-error">No more pages to load</p>
    </div>


    <!-- .photo-item template HTML -->
    <script type="text/html" id="photo-item-template">
        <div class="photo-item">
            <img class="photo-item__image" src="{{urls.regular}}" alt="Photo by {{user.name}}" />
            <p class="photo-item__caption">
                <a href="{{user.links.html}}?utm_source=infinite-scroll-demos&utm_medium=referral&utm_campaign=api-credit">{{user.name}}</a>
            </p>
        </div>
    </script>

    <script>
        var $grid = $('.grid').masonry({
            itemSelector: '.photo-item',
            columnWidth: '.grid__col-sizer',
            gutter: '.grid__gutter-sizer',
            percentPosition: true,
            stagger: 30,
            // nicer reveal transition
            visibleStyle: { transform: 'translateY(0)', opacity: 1 },
            hiddenStyle: { transform: 'translateY(100px)', opacity: 0 },
        });

        //------------------//

        // Get an API key for your demos at https://unsplash.com/developers
        var unsplashID = '9ad80b14098bcead9c7de952435e937cc3723ae61084ba8e729adb642daf0251';

        // get Masonry instance
        var msnry = $grid.data('masonry');

        $grid.infiniteScroll({
            path: function () {
                return 'https://api.unsplash.com/photos?client_id=' + unsplashID + '&page=' + this.pageIndex;
            },
            // load response as flat text
            responseType: 'text',
            outlayer: msnry,
            status: '.page-load-status',
            history: false,
        });

        $grid.on('load.infiniteScroll', function (event, response) {
            console.log(response)
            // parse response into JSON data
            var data = JSON.parse(response);
            // compile data into HTML
            var itemsHTML = data.map(getItemHTML).join('');
            // convert HTML string into elements
            var $items = $(itemsHTML);
            // append item elements
            $items.imagesLoaded(function () {
                $grid.infiniteScroll('appendItems', $items)
                    .masonry('appended', $items);
            })
        });

        // load initial page
        $grid.infiniteScroll('loadNextPage');

        //------------------//

        var itemTemplateSrc = $('#photo-item-template').html();

        function getItemHTML(photo) {
            return microTemplate(itemTemplateSrc, photo);
        }

        // micro templating, sort-of
        function microTemplate(src, data) {
            // replace {{tags}} in source
            return src.replace(/\{\{([\w\-_\.]+)\}\}/gi, function (match, key) {
                // walk through objects to get value
                var value = data;
                key.split('.').forEach(function (part) {
                    value = value[part];
                });
                return value;
            });
        }
    </script>

</body>
</html>
