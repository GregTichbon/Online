<HTML>
<HEAD>

<SCRIPT LANGUAGE="JavaScript">
function showpic(src, w, h, alt, aln, pw, ph, bw, bh) {
if (src == null) return;
var iw, ih; // Set inner width and height
if (window.innerWidth == null) {
iw = document.body.clientWidth;
ih=document.body.clientHeight; 
}
else {
iw = window.innerWidth;
ih = window.innerHeight;
}
if (w == null) w = iw;
if(h == null)  h = ih;
if(alt == null) alt = "Picture";
if(aln == null) aln = "left";
if(pw == null) pw = 100;
if(ph == null) ph = 100;
if(bw == null) bw = 24;
if(bh == null) bh = 24;
var sw = Math.round((iw - bw) * pw / 100);
var sh = Math.round((ih - bh) * ph / 100);
if ((w * sh) / (h * sw) < 1) sw = Math.round(w * sh / h);
else sh = Math.round(h * sw / w);
document.write('<img src="'+src+'" alt="'+alt+'" width="'+sw+'" height="'+sh+'" align="'+aln+'">');
}
</script>
</HEAD>


<BODY>

<script language="javascript">
showpic("crowd.gif", 362, 113, "A crows of people", "middle");
</script>

</body>
</HTML>