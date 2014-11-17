$(document).ready(function () {
    var canvas = document.getElementById('myCanvas');
  //  $("#myCanvas")
    var ctx = canvas.getContext('2d');
    var image = new Image();

    image.onload = function () {

        if (image.width != canvas.width)
            canvas.width = image.width;
        if (image.height != canvas.height)
            canvas.height = image.height;

        ctx.clearRect(0, 0, canvas.width, canvas.height);
        ctx.drawImage(image, 0, 0);

    }
    image.src = "http://demo-mcm.v5shop.net/uploadfile/product/201412616537868.jpg";
})