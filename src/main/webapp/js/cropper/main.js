$(function () {

  'use strict';

  var console = window.console || { log: function () {} };
  var $image = $('#image');
  var $download = $('#download');
  var $dataX = $('#dataX');
  var $dataY = $('#dataY');
  var $dataHeight = $('#dataHeight');
  var $dataWidth = $('#dataWidth');
  var $dataRotate = $('#dataRotate');
  var $dataScaleX = $('#dataScaleX');
  var $dataScaleY = $('#dataScaleY');
  var options = {
    aspectRatio: 1,
    preview: '.img-preview',
    crop: function (e) {
      $dataX.val(Math.round(e.x));
      $dataY.val(Math.round(e.y));
      $dataHeight.val(Math.round(e.height));
      $dataWidth.val(Math.round(e.width));
      $dataRotate.val(e.rotate);
      $dataScaleX.val(e.scaleX);
      $dataScaleY.val(e.scaleY);
    }
  };


  // Tooltip
  $('[data-toggle="tooltip"]').tooltip();


  // Cropper
  $image.on({
    'build.cropper': function (e) {
      console.log(e.type);
    },
    'built.cropper': function (e) {
      console.log(e.type);
    },
    'cropstart.cropper': function (e) {
      console.log(e.type, e.action);
    },
    'cropmove.cropper': function (e) {
      console.log(e.type, e.action);
    },
    'cropend.cropper': function (e) {
      console.log(e.type, e.action);
    },
    'crop.cropper': function (e) {
      console.log(e.type, e.x, e.y, e.width, e.height, e.rotate, e.scaleX, e.scaleY);
    },
    'zoom.cropper': function (e) {
      console.log(e.type, e.ratio);
    }
  }).cropper(options);


  // Buttons
  if (!$.isFunction(document.createElement('canvas').getContext)) {
    $('button[data-method="getCroppedCanvas"]').prop('disabled', true);
  }

  if (typeof document.createElement('cropper').style.transition === 'undefined') {
    $('button[data-method="rotate"]').prop('disabled', true);
    $('button[data-method="scale"]').prop('disabled', true);
  }


  // Download
  if (typeof $download[0].download === 'undefined') {
    $download.addClass('disabled');
  }


  // Options
  $('.docs-toggles').on('change', 'input', function () {
    var $this = $(this);
    var name = $this.attr('name');
    var type = $this.prop('type');
    var cropBoxData;
    var canvasData;

    if (!$image.data('cropper')) {
      return;
    }

    if (type === 'checkbox') {
      options[name] = $this.prop('checked');
      cropBoxData = $image.cropper('getCropBoxData');
      canvasData = $image.cropper('getCanvasData');

      options.built = function () {
        $image.cropper('setCropBoxData', cropBoxData);
        $image.cropper('setCanvasData', canvasData);
      };
    } else if (type === 'radio') {
      options[name] = $this.val();
    }

    $image.cropper('destroy').cropper(options);
  });


  // Methods
  $('.docs-buttons').on('click', '[data-method]', function () {
    var $this = $(this);
    var data = $this.data();
    var $target;
    var result;

    if ($this.prop('disabled') || $this.hasClass('disabled')) {
      return;
    }

    if ($image.data('cropper') && data.method) {
      data = $.extend({}, data); // Clone a new one

      if (typeof data.target !== 'undefined') {
        $target = $(data.target);

        if (typeof data.option === 'undefined') {
          try {
            data.option = JSON.parse($target.val());
          } catch (e) {
            console.log(e.message);
          }
        }
      }

      if (data.method === 'rotate') {
        $image.cropper('clear');
      }

      result = $image.cropper(data.method, data.option, data.secondOption);

      if (data.method === 'rotate') {
        $image.cropper('crop');
      }

      switch (data.method) {
        case 'scaleX':
        case 'scaleY':
          $(this).data('option', -data.option);
          break;

        case 'getCroppedCanvas':
          if (result) {

            // Bootstrap's Modal
            $('#getCroppedCanvasModal').modal().find('.modal-body').html(result);

            if (!$download.hasClass('disabled')) {
              $download.attr('href', result.toDataURL('image/jpeg'));
            }
          }

          break;
      }

      if ($.isPlainObject(result) && $target) {
        try {
          $target.val(JSON.stringify(result));
        } catch (e) {
          console.log(e.message);
        }
      }

    }
  });


  // Keyboard
  $(document.body).on('keydown', function (e) {

    if (!$image.data('cropper') || this.scrollTop > 300) {
      return;
    }

    switch (e.which) {
      case 37:
        e.preventDefault();
        $image.cropper('move', -1, 0);
        break;

      case 38:
        e.preventDefault();
        $image.cropper('move', 0, -1);
        break;

      case 39:
        e.preventDefault();
        $image.cropper('move', 1, 0);
        break;

      case 40:
        e.preventDefault();
        $image.cropper('move', 0, 1);
        break;
    }

  });


  // Import image
  var $inputImage = $('#inputImage');
  var URL = window.URL || window.webkitURL;
  var blobURL;

  if (URL) {
    $inputImage.change(function () {
      var files = this.files;
      var file;

      if (!$image.data('cropper')) {
        return;
      }

      if (files && files.length) {
        file = files[0];

        if (/^image\/\w+$/.test(file.type)) {
          blobURL = URL.createObjectURL(file);
          $image.one('built.cropper', function () {

            // Revoke when load complete
            URL.revokeObjectURL(blobURL);
          }).cropper('reset').cropper('replace', blobURL);
          $inputImage.val('');
        } else {
          window.alert('Please choose an image file.');
        }
      }
    });
  } else {
    $inputImage.prop('disabled', true).parent().addClass('disabled');
  }

});

function uploadImageFile(file) {
  var URL = window.URL || window.webkitURL;
  var blobURL = URL.createObjectURL(file);
  $('#image').one('built.cropper', function () {

    // Revoke when load complete
    URL.revokeObjectURL(blobURL);
  }).cropper('reset').cropper('replace', blobURL);
}

function uploadImageUrl(url) {
  // var blobURL = url;
  // var URL = window.URL || window.webkitURL;
  // $('#image').one('built.cropper', function () {
  //
  //   // Revoke when load complete
  //   URL.revokeObjectURL(blobURL);
  // }).cropper('reset').cropper('replace', blobURL);

  var a = document.createElement('a');
  var blobURL = url;
  var filename = "D:/tmp/" + new Date().getTime() + ".jpg";
  a.href = blobURL;
  a.download = filename;
  a.click();
  // window.URL.revokeObjectURL(url);
  $('#image').one('built.cropper', function () {

    // Revoke when load complete
    window.URL.revokeObjectURL(blobURL);
  }).cropper('reset').cropper('replace', filename);

}

// function saveImage() {
//   var $image = $('#image');
//   var src = $image.eq(0).attr("src");
//   var canvasData = $image.cropper("getCanvasData");
//   var cropBoxData = $image.cropper('getCropBoxData');
//
//   convertToData(src, canvasData, cropBoxData, function(basechar) {
//     // 回调后的函数处理
//   });
// }
//
// function convertToData(url, canvasData, cropData, callback) {
//   var cropw = cropData.width; // 剪切的宽
//   var croph = cropData.height; // 剪切的宽
//   var imgw = canvasData.width; // 图片缩放或则放大后的高
//   var imgh = canvasData.height; // 图片缩放或则放大后的高
//   var poleft = canvasData.left - cropdata.left; // canvas定位图片的左边位置
//   var potop = canvasData.top - cropdata.top; // canvas定位图片的上边位置
//   var canvas = document.createElement("canvas");
//   var ctx = canvas.getContext('2d');
//   canvas.width = cropw;
//   canvas.height = croph;
//   var img = new Image();
//   img.src = url;
//   img.onload = function() {
//     this.width = imgw;
//     this.height = imgh;
//     // 这里主要是懂得canvas与图片的裁剪之间的关系位置
//     ctx.drawImage(this, poleft, potop, this.width, this.height);
//     var base64 = canvas.toDataURL('image/jpg', 1);  // 这里的“1”是指的是处理图片的清晰度（0-1）之间，当然越小图片越模糊，处理后的图片大小也就越小
//     callback && callback(base64);	  // 回调base64字符串
//   }
// }
function saveImage() {
    var $image = $('#image');
    var result = $image.cropper("getCroppedCanvas");
    var data=result.toDataURL();
    var params = {   //准备向后台传的baas参数
        "image":data    //剪裁后的图片base64码
    };

    post('/image/upload.shtml', params);
}

function post(URL, PARAMS) {
    var temp = document.createElement("form");
    temp.action = URL;
    temp.method = "post";
    temp.style.display = "none";
    for (var x in PARAMS) {
        var opt = document.createElement("textarea");
        opt.name = x;
        opt.value = PARAMS[x];
        // alert(opt.name)
        temp.appendChild(opt);
    }
    document.body.appendChild(temp);
    temp.submit();
    return temp;
}    

