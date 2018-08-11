# Image Cover jQuery Plugin v1.0.1

<p>Resize proportionally and center image to fill with it a container element.</p>
<p>This plugin was created about my personal needs in my developments. It's simple, light and solves a specific need. I think that it can be useful to others developers.</p>
<p>I will work in it to add new features keeping the simple and concrete spirit of the plugin.</p>

## Installation
<p>Add it in your <code>&lt;head&gt;</code> page.</p>
<pre>
&lt;script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"&gt;&lt;/script&gt;
&lt;script type="text/javascript" src="jquery.image-cover.min.js"&gt;&lt;/script&gt;
</pre>
## How to use
<p>Add the '.image-cover' class in all images that you want apply the plugin.</p>
<pre>&lt;img src="image.jpg" class="image-cover"/&gt;</pre>
<p>Plugin will detect the inmediatly parent to fill image in it.</p>
<pre>
&lt;article&gt;
  &lt;img src="image.jpg" class="image-cover"/&gt;
&lt;/article&gt;
</pre>
<p>Support to add content above image.</p>
<pre>
&lt;a href="/"&gt;
  &lt;span&gt;
    Link text
  &lt;/span&gt;
  &lt;img src="example.jpg" class="image-cover"/&gt;
&lt;/a&gt;
</pre>
<p>You also can use your own class.</p>
<pre>$(".my-class").imageCover();</pre>
<p>The plugin have a Bootstrap Carousel support.</p>
<pre>$(".my-class").imageCover({
  carousel: "#your-carousel-id" // Bootstrap carousel support
});</pre>

## Updates

### v1.0.1
- Support to auto absolute position to elements above image.

### v1.0.0
- First stable release.
