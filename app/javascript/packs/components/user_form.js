export default class UserForm {
  constructor() {
    $(document).ready(function() {
      showImage();
    })

    $(document).on("turbo:render", function() {
      showImage();
    });

    function showImage() {
      $("#user_avatar").on("change", function() {
        let output = $(".avatar > img")
        let newSrc = URL.createObjectURL(event.target.files[0])
        $(output).attr('src', newSrc)
      })
    }
  }
}
